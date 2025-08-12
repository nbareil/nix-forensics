{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "usnrs";
    name = "usnrs";

    buildFeatures = [ "usnrs-cli" ];

    src = fetchFromGitHub {
      inherit pname name;
      owner = "airbus-cert";
      repo = pname;
      rev = "1bb32673d703aaa7a1dc67f6211457728c7b7043";
      sha256 = "sha256-VDxm8XlTc9raXP6naMWlKzff7SErwhnPVpEtCvYM1Kg=";
    };

    cargoHash = "sha256-bKDbVgQ8aHjpOtkw8YcFpFKKj8ouQL44MGdvw1pOmEs=";

    meta = {
      description = "A cross-platform parser for the Windows USN Journal format";
      homepage = "https://github.com/airbus-cert/usnrs";
    };
  }
