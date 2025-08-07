{
  rustPlatform,
  fetchFromGitLab,
  replaceVars,
  jupiter-hw-support,
  jovian-stubs,
  steamos-polkit-helpers,
  steamdeck-firmware,
  jupiter-dock-updater-bin,
  iwd,
  trace-cmd,
  iw,
  orca,
  pkg-config,
  wrapGAppsNoGuiHook,
  glib,
  gsettings-desktop-schemas,
  udev,
}:
rustPlatform.buildRustPackage rec {
  pname = "steamos-manager";
  version = "25.6.1";

  src = fetchFromGitLab {
    domain = "gitlab.steamos.cloud";
    owner = "holo";
    repo = "steamos-manager";
    rev = "v${version}";
    hash = "sha256-PCh+vxswKs82f2Wp5vZRPS0IFIaktNoxQG1BXr3JiF4=";
  };

  cargoHash = "sha256-zb3y6X2T3quAVwNSKRYroZbpSvml72n1PkJGiX5OQuA=";

  # tests assume Steam Deck hardware and FHS paths
  doCheck = false;

  patches = [ 
    (replaceVars ./hardcode-paths.patch
    {
      stubs = jovian-stubs;
      steamDeckFirmware = steamdeck-firmware;
      jupiterDockUpdaterBin = jupiter-dock-updater-bin;
      hwsupport = jupiter-hw-support;
      polkitHelpers = steamos-polkit-helpers;
      iwd = iwd;
      traceCmd = trace-cmd;
      iw = iw;
      orca = orca;
      out = null;
    })
    # FIXME: build steamos-log-submitter and reenable this maybe?
    ./disable-ftrace.patch
  ];

  postPatch = ''
    substituteInPlace \
      src/daemon/{root,user}.rs \
      src/hardware.rs \
      src/platform.rs \
      data/*/*.service \
      --replace-warn "@out@" "$out"
  '';

  strictDeps = true;

  nativeBuildInputs = [
    pkg-config
    glib
    wrapGAppsNoGuiHook
  ];

  buildInputs = [
    glib
    gsettings-desktop-schemas
    udev
  ];

  postInstall = ''
    # fixup location to match vendor packaging
    mkdir $out/lib
    mv $out/bin/steamos-manager $out/lib/steamos-manager

    # copied from vendor makefile, s@$(DESTDIR)/usr@$out@g
    install -d -m0755 "$out/share/dbus-1/services/"
    install -d -m0755 "$out/share/dbus-1/system-services/"
    install -d -m0755 "$out/share/dbus-1/system.d/"
    install -d -m0755 "$out/lib/systemd/system/"
    install -d -m0755 "$out/lib/systemd/user/"

    install -D -m644 -t "$out/share/steamos-manager/devices" "data/devices/"*
    install -D -m644 LICENSE "$out/share/licenses/steamos-manager/LICENSE"

    install -m644 "data/platform.toml" "$out/share/steamos-manager/"

    install -m644 "data/system/com.steampowered.SteamOSManager1.service" "$out/share/dbus-1/system-services/"
    install -m644 "data/system/com.steampowered.SteamOSManager1.conf" "$out/share/dbus-1/system.d/"
    install -m644 "data/system/steamos-manager.service" "$out/lib/systemd/system/"

    install -m644 "data/user/com.steampowered.SteamOSManager1.service" "$out/share/dbus-1/services/"
    install -m644 "data/user/steamos-manager.service" "$out/lib/systemd/user/"
    install -m644 "data/user/orca.service" "$out/lib/systemd/user/"
  '';

  postFixup = ''
    wrapGApp $out/lib/steamos-manager
  '';
}