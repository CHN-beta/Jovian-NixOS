{ 
  gamescope',
  fetchFromGitHub,
}:

# NOTE: vendoring gamescope for the time being since we want to match the
#       version shipped by the vendor, ensuring feature level is equivalent.

gamescope'.overrideAttrs(old: rec {
  version = "3.16.14";

  src = fetchFromGitHub {
    owner = "ValveSoftware";
    repo = "gamescope";
    rev = version;
    fetchSubmodules = true;
    hash = "sha256-i1a3nTospbGR/uPbwuM0z6cATANvw3QCFXd99e3tXCs=";
  };

  # FIXME: remove after nixpkgs updates
  postPatch = ''
    patchShebangs default_extras_install.sh
  '';
})
