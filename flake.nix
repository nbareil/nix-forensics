# flake.nix
{
  description = "A flake for Windows DFIR tools and libraries";

  # Flake inputs: All external dependencies are declared here.
  # This replaces the `fetchTarball` call from your default.nix.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/1e2e384c5b7c50dbf8e9c441a9e58d85f408b01f"; # Corresponds to nixos-23.11 pin
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Flake outputs: The packages, shells, and other artifacts produced by this flake.
  outputs = { self, nixpkgs, flake-utils }:
    # Use flake-utils to generate outputs for common systems (x86_64-linux, aarch64-linux, etc.)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # The overlay defines all your custom packages.
        # It takes two arguments:
        # - `final`: The final package set after all overlays are applied. Use this for self-references.
        # - `prev`: The package set before this overlay is applied. Use this for dependencies from nixpkgs.
        overlay = final: prev: {

          # --- Overrides ---
          my-python-registry = prev.python3Packages.python-registry.overridePythonAttrs {
            src = prev.fetchFromGitHub {
              owner = "nbareil";
              repo = "python-registry";
              rev = "f4cddbc4ce77b0ca3682474e10d130c624a96349";
              hash = "sha256-CUOC3UxgD7zUf0OmOh4fpa/oqKsT3hkr4ZGHHKCA/nQ=";
            };
          };

          # --- Libs ---
          # Dependencies defined within this overlay are referenced via `final`.
          # Dependencies from nixpkgs are referenced via `prev`.
          libcerror = prev.callPackage ./pkgs/libcerror.nix {};
          libcthreads = prev.callPackage ./pkgs/libcthreads.nix { inherit (final) libcerror; };
          libcnotify = prev.callPackage ./pkgs/libcnotify.nix { inherit (final) libcerror; };
          libcdatetime = prev.callPackage ./pkgs/libcdatetime.nix { inherit (final) libcerror; };
          libcsplit = prev.callPackage ./pkgs/libcsplit.nix { inherit (final) libcerror; };
          libclocale = prev.callPackage ./pkgs/libclocale.nix { inherit (final) libcerror; };
          libcdata  = prev.callPackage ./pkgs/libcdata.nix  { inherit (final) libcerror libcthreads; };
          libuna  = prev.callPackage ./pkgs/libuna.nix  { inherit (final) libcerror libcthreads libcnotify libcdatetime libclocale;  };
          libcfile  = prev.callPackage ./pkgs/libcfile.nix  { inherit (final) libcerror libcthreads libuna libclocale libcnotify; };
          libcpath  = prev.callPackage ./pkgs/libcpath.nix  { inherit (final) libcerror libcthreads libuna libclocale libcsplit; };
          libbfio  = prev.callPackage ./pkgs/libbfio.nix  { inherit (final) libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; };
          libfcache = prev.callPackage ./pkgs/libfcache.nix { inherit (final) libcdata libcerror libcthreads; };
          libfdata = prev.callPackage ./pkgs/libfdata.nix { inherit (final) libcdata libcerror libcnotify libcthreads libfcache; };
          libfdatetime = prev.callPackage ./pkgs/libfdatetime.nix { inherit (final) libcerror; };
          libfguid = prev.callPackage ./pkgs/libfguid.nix { inherit (final) libcerror; };
          libfusn = prev.callPackage ./pkgs/libfusn.nix { inherit (final) libcerror libcnotify libfdatetime libuna; };
          libfwnt = prev.callPackage ./pkgs/libfwnt.nix { inherit (final) libcdata libcerror libcnotify libcthreads; };
          libhmac = prev.callPackage ./pkgs/libhmac.nix { inherit (final) libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; };
          libfsntfs = prev.callPackage ./pkgs/libfsntfs.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfusn libfwnt libhmac libuna; });
          libfmapi = prev.callPackage ./pkgs/libfmapi.nix { inherit (final) libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; };
          libfvalue = prev.callPackage ./pkgs/libfvalue.nix { inherit (final) libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna ; };
          libmapidb = prev.callPackage ./pkgs/libmapidb.nix { inherit (final) libcerror libcnotify; };
          libesedb = prev.callPackage ./pkgs/libesedb.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfmapi libfvalue libfwnt libmapidb libuna; });
          libvshadow = prev.callPackage ./pkgs/libvshadow.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libuna;});
          libcdirectory = prev.callPackage ./pkgs/libcdirectory.nix { inherit (final) libcerror libclocale libuna; };
          libexe = prev.callPackage ./pkgs/libexe.nix { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libuna; };
          libfwevt = prev.callPackage ./pkgs/libfwevt.nix { inherit (final) libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; };
          libregf = prev.callPackage ./pkgs/libregf.nix { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfwnt libuna; };
          libwrc = prev.callPackage ./pkgs/libwrc.nix { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwnt libuna; };
          libevtx = prev.callPackage ./pkgs/libevtx.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcdirectory libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwevt libfwnt libregf libuna libwrc;});
          libvmdk = prev.callPackage ./pkgs/libvmdk.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfvalue libuna;});
          libvhdi = prev.callPackage ./pkgs/libvhdi.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfguid libuna;});
          libfole = prev.callPackage ./pkgs/libfole.nix { inherit (final) libcerror; };
          libmsiecf = prev.callPackage ./pkgs/libmsiecf.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfvalue libuna;});
          libfwps = prev.callPackage ./pkgs/libfwps.nix { inherit (final) libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libuna; };
          libfwsi = prev.callPackage ./pkgs/libfwsi.nix { inherit (final) libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libfole libfwps libuna; };
          liblnk = prev.callPackage ./pkgs/liblnk.nix ({ inherit (prev) fuse python3; } // { inherit (final) libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfwps libfwsi libuna;});

          # --- Tools ---
          shellbags = ps: prev.callPackage ./pkgs/shellbags.nix { python2Packages = ps; };
          INDXParse = prev.callPackage ./pkgs/INDXParse.nix {};
          INDXRipper = prev.callPackage ./pkgs/INDXRipper.nix {};
          dfir_ntfs = prev.callPackage ./pkgs/dfir_ntfs.nix {};
          yarp = prev.callPackage ./pkgs/yarp.nix {};
          cimlib = prev.callPackage ./pkgs/cimlib.nix {};
          shimCacheParser = prev.callPackage ./pkgs/shimCacheParser.nix {};
          #mftspy = prev.callPackage ./pkgs/mftspy.nix { inherit (final) libfsntfs; };
          regrippy = prev.callPackage ./pkgs/regrippy.nix {};
          regipy = prev.callPackage ./pkgs/regipy.nix { inherit (final) libfwsi; };
          netstructlib = prev.callPackage ./pkgs/netstructlib.nix {};
          CobaltStrikeParser = prev.callPackage ./pkgs/CobaltStrikeParser.nix { inherit (final) netstructlib; };
          domaintoolslib = prev.callPackage ./pkgs/domaintoolslib.nix {};
          pymisplib = prev.callPackage ./pkgs/pymisplib.nix {};
          splunklib = prev.callPackage ./pkgs/splunklib.nix {};
          pdoclib = prev.callPackage ./pkgs/pdoclib.nix {};
          huntlib = prev.callPackage ./pkgs/huntlib.nix { inherit (final) splunklib domaintoolslib pymisplib; };
          evtxTools = prev.callPackage ./pkgs/evtxTools.nix {};
          usnrs = prev.callPackage ./pkgs/usnrs.nix {};
          liblnk-python = prev.python3Packages.toPythonModule final.liblnk;
          timeliner = prev.callPackage ./pkgs/timeliner.nix {};
          libevtx-python = prev.python3Packages.toPythonModule final.libevtx;
          #srum-dump = prev.callPackage ./pkgs/srum-dump.nix { inherit (final) libesedb; };
          amcacheparser = prev.callPackage ./pkgs/amcacheparser.nix {};
          bits_parser = prev.callPackage ./pkgs/bits_parser.nix {};
          at_jobs_carver = prev.callPackage ./pkgs/at_jobs_carver.nix {};
          ccm_rua_finder = prev.callPackage ./pkgs/ccm_rua_finder.nix {};
          registryFlush = prev.python3Packages.callPackage ./pkgs/registryFlush.nix { inherit (final) yarp; };
          forensicslab = prev.callPackage ./pkgs/forensicslab.nix {};

          # --- Custom Python Environment ---
          customPython = prev.python3.withPackages (ps: with ps; [
              ps.requests
              ps.python-magic
              ps.grpcio
              ps.dateutil
              ps.pandas
              ps.requests_ntlm
              ps.google-api-python-client
              ps.pandas
              ps.pytest-vcr
              ps.jinja2
              ps.lxml
              ps.yara-python
              ps.fuse
              ps.evtx
              ps.progressbar
              ps.pytest
            ] ++ [
              final.pdoclib
              final.huntlib
              final.splunklib
              final.libevtx-python
              final.liblnk-python
            ]);

          # --- Docker Image ---
          # This assumes your docker.nix and shell.nix can be called with a `pkgs` argument.
          # You may need to adjust them to work in a flake context.
          docker = prev.callPackage ./docker.nix {
            nixForensicsShell = import ./shell.nix { pkgs = final; };
          };
        };

        # Import nixpkgs with our overlay for the specified system.
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        # Expose the overlay so other flakes can use your packages.
        overlay = overlay;

        # Define the packages that can be built with `nix build .#<name>`
        packages = {
          inherit (pkgs)
            # Expose all the main tools
            INDXParse INDXRipper dfir_ntfs yarp cimlib shimCacheParser regrippy regipy
            CobaltStrikeParser evtxTools usnrs timeliner amcacheparser bits_parser
            at_jobs_carver ccm_rua_finder registryFlush forensicslab
            # Expose the custom python env and docker image
            customPython docker;

          default = pkgs.customPython;

          all = with self.packages.${pkgs.system}; [
               customPython
               evtxTools
               evtx-tools
               usnrs
               INDXRipper
               INDXParse
               CobaltStrikeParser
               libvmdk
               libmsiecf
               libvhdi
               libvshadow
               liblnk
               libesedb
               cimlib
               bits_parser
               at_jobs_carver
               ccm_rua_finder
               forensicslab
               notatin
               shimCacheParser
               dfir_ntfs
               yarp
               regrippy
               regipy
               amcacheparser
               registryFlush
               my-python-registry
            ];
        };



        # Define the development shell, accessible via `nix develop`
        devShells.default = pkgs.mkShell {
          # Packages available in the shell environment
          buildInputs = with pkgs; [
            # Add all your tools here for a complete environment
            customPython
            INDXParse
            INDXRipper
            dfir_ntfs
            yarp
            cimlib
            shimCacheParser
            regrippy
            regipy
            CobaltStrikeParser
            evtxTools
            usnrs
            timeliner
            amcacheparser
            bits_parser
            at_jobs_carver
            ccm_rua_finder
            registryFlush
            forensicslab
          ];
        };
      }
    );
}
