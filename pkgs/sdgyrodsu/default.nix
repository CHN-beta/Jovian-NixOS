{
  lib,
  stdenv,
  fetchFromGitHub,
  ncurses,
  hidapi,
  systemd,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "sdgyrodsu";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "kmicki";
    repo = "SteamDeckGyroDSU";
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-24ZnX9n4vIMFwNWbQOT7aLvlX7uiTzMVRHfuaTkwg6M=";
  };

  buildInputs = [
    ncurses
    hidapi
    systemd
  ];

  makeFlags = [
    "NOPREPARE=1"
    "CHECKDEPS="
    "release"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r bin/release/sdgyrodsu $out/bin

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cemuhook DSU server for the Steam Deck Gyroscope";
    homepage = "https://github.com/kmicki/SteamDeckGyroDSU";
    license = licenses.mit;
  };
})
