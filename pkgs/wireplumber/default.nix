{ wireplumber', fetchFromGitHub }:
wireplumber'.overrideAttrs(_: {
  version = "0.5.7";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "wireplumber";
    rev = "0.5.7-jupiter1.4";
    hash = "sha256-gU+5CA7SqUTnevs2Xqfm2PCe9zxJXS8HG2y7JY6aBzY=";
  };
})
