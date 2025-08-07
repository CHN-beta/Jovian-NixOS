{ mangohud', fetchFromGitHub }:
mangohud'.overrideAttrs {
  version = "0.8.1.r49";

  src = fetchFromGitHub {
    owner = "flightlessmango";
    repo = "mangohud";
    rev = "a113f7cf4d1af688301043a4c70ee43098bc9e15";
    hash = "sha256-KQFU9XVuRnS6IynFgDqzCqcnd741fjQ3d9wA97STkQ4=";
  };
}
