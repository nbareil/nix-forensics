{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "evtx";
    version = "v0.8.1";

    src = fetchFromGitHub {
      inherit pname version;
      owner = "omerbenamram";
      repo = pname;
      rev = version;
      sha256 = "sha256-aa04Ia11+Ae1amc3JAtYdSWf+f/fenTt0Bny/AauaHo=";
    };

    cargoHash = "sha256-6ixxHcHks4us2AoJLq5fxFTfmtP4S0ugNPSGOaWGzXk=";

    meta = {
      description = "A cross-platform parser for the Windows XML EventLog format";
      homepage = "https://github.com/omerbenamram/evtx";
    };
  }
