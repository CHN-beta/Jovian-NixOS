{ 
  decky-loader,
  fetchFromGitHub,
  pnpm_9,
}:
decky-loader.overridePythonAttrs rec {
  pname = "decky-loader";
  version = "3.1.8-pre1";

  src = fetchFromGitHub {
    owner = "SteamDeckHomebrew";
    repo = "decky-loader";
    rev = "v${version}";
    hash = "sha256-eaKtmb7qtQLH8r5Y8ZO0Kc5K2IT97Zv4F4DGtblO6jA=";
  };

  pnpmDeps = pnpm_9.fetchDeps {
    inherit pname version src;
    sourceRoot = "${src.name}/frontend";
    hash = "sha256-Gg7e1y+gDIT5du6u8HdxF9pNAPjkQSK4Q+K7xpxm+Ps=";
  };
}