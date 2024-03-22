{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        inherit (nixpkgs) lib;
        pkgs = import nixpkgs { inherit system; };

        other = pkgs.python311Packages.buildPythonPackage rec {
          version = "1";
          pname = "other";
          doCheck = false;
          format = "pyproject";
          src = pkgs.lib.cleanSource ./other;
          nativeBuildInputs = with pkgs.python311Packages; [
            setuptools
          ];
        };

        this = pkgs.python311Packages.buildPythonPackage rec {
          version = "1";
          pname = "this";
          doCheck = false;
          format = "pyproject";
          nativeBuildInputs = with pkgs.python311Packages; [
            setuptools
            other
          ];
          src = pkgs.lib.cleanSource ./.;
        };
      in
      rec
      {
        devShell =
          pkgs.mkShell {
            packages = [ this ];
          };
      }
    );
}

