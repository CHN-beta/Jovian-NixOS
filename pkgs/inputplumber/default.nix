{
  inputplumber',
  fetchFromGitHub,
  rustPlatform,
}:
inputplumber'.overrideAttrs rec {
  version = "0.58.0";

  src = fetchFromGitHub {
    owner = "ShadowBlip";
    repo = "InputPlumber";
    tag = "v${version}";
    hash = "sha256-FAnA9M9/SLTdsZReZy9BI6+pFFb6kf79aXsWk92QAIc=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-g4YlY/FviPGU/x+Sb29BxbemBwJ82xFByED/LyGKgwU=";
  };
}
