{
  stdenv,
  lib,
  fetchFromGitea,
  cmake,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "opensd";
  version = "0.52";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "OpenSD";
    repo = "opensd";
    tag = "v${finalAttrs.version}";
    hash = "sha256-7DbDkqhNq4Io26XYhwr/5eLdF3TkZyKKHiNgmT5yaWE=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ ];

  cmakeFlags = [
    "-DUDEV_RULE_DIR=${placeholder "out"}/lib/udev/rules.d"
    "-DOPT_INSTALL_GROUP=OFF"
  ];

  meta = {
    description = "Userspace driver for Steam Deck input";
    license = lib.licenses.gpl3Plus;
  };
})
