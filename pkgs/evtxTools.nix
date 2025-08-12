{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "evtx";
    version = "v0.9.0";

    src = fetchFromGitHub {
      inherit pname version;
      owner = "omerbenamram";
      repo = pname;
      rev = version;
      sha256 = "sha256-fgOuhNE77zVjL16oiUifnKZ+X4CQnZuD8tY+h0JTOYU=";
    };

    cargoHash = "sha256-E9BoqpnKhVNwOiEvZROF3xj9Ge8r2CNaBiwHdkdV5aw=";

    meta = {
      description = "A cross-platform parser for the Windows XML EventLog format";
      homepage = "https://github.com/omerbenamram/evtx";
    };
  }
