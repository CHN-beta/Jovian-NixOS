{ linux-firmware, fetchFromGitHub }:

linux-firmware.overrideAttrs(_: rec {
  version = "20250701.1";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "linux-firmware";
    rev = "jupiter-${version}";
    hash = "sha256-YrLiZOrH+B7DCOQUSCuH4ujDCRlZadlVdwzGQxHQJ/E=";
  };
})
