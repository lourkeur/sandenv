{
  description = "A very basic flake";

  inputs = {
    devshell.url = "github:numtide/devshell";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    nur.url = "github:nix-community/nur";
  };

  outputs = inputs @ {
    self,
    devshell,
    fup,
    nixpkgs,
    nur,
    ...
  }:
    fup.lib.mkFlake {
      inherit self inputs;

      sharedOverlays = [
        devshell.overlay
        nur.overlay
      ];

      lib = import ./lib;

      outputsBuilder = channels: let
        stage0 = {
          inherit
            (channels.nixpkgs)
            bzip2
            dash
            gawk
            gcc
            gnugrep
            gnumake
            gnused
            gzip
            xz
            ;
          inherit (channels.nixpkgs.nur.repos.sikmir) sbase;
          bintools = channels.nixpkgs.bintools-unwrapped;
        };
        step = prev: let
          pkgs = stage0 // prev;
        in inputs.nixpkgs.lib.genAttrs [
          "bzip2"
          "dash"
          "gnugrep"
          "gnumake"
          "gzip"
          "sbase"
          "xz"
        ] (pkg: import packages/${pkg} {inherit pkgs inputs;});
        stage1 = step stage0;
        stage2 = step stage1;
      in {
        devShell = channels.nixpkgs.callPackage nix/devshell.nix {};
        packages =
          stage2
          // {
            default = channels.nixpkgs.buildEnv {
              name = "sandenv-core";
              paths = builtins.attrValues stage2;
            };
          };
      };
    };
}
