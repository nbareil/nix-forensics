{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "usnrs";
    version = "v0.1.0";

    buildFeatures = [ "usnrs-cli" ];

    src = fetchFromGitHub {
      inherit pname version;
      owner = "airbus-cert";
      repo = pname;
      rev = version;
      sha256 = "sha256-zBSMIXRjAGuerkaTIGgn7TCrVnxprrXCIjV5OFIvMuU=";
    };

    cargoHash = "sha256-PX2CCs+ZvoeHizopHbccvaJHXkp6/h3Je3271uRFyB0=";

    meta = {
      description = "A cross-platform parser for the Windows USN Journal format";
      homepage = "https://github.com/airbus-cert/usnrs";
    };
  }
