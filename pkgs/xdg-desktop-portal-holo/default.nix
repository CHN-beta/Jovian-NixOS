{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  glib,
  dbus,
  fontconfig,
  systemd,
  xdg-desktop-portal,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xdg-desktop-portal-holo";
  version = "0.1.14.bb73298";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "xdg-desktop-portal-holo";
    rev = "bb73298cd763e0ce131912e48c766a4032c9f910";
    hash = "sha256-WD6yCO3EIsEqQP3dWvysJ02QCGkyUaVtyAkKiPeBjGo=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    glib
  ];

  buildInputs = [
    dbus
    fontconfig
    glib
    systemd
    xdg-desktop-portal
  ];
})
