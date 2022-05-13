{
  inputs,
  pkgs,
}:
inputs.self.lib.mkDerivation {
  system = "x86_64-linux";
  inherit (pkgs.xz) pname version;
  builder = "/bin/sh";
  args = [./builder.sh];
  env = {
    PATH = inputs.nixpkgs.lib.concatMapStringsSep ":" (name: "${pkgs.${name}}/bin") [
      "gnugrep" # FIXME: sbase grep is not acceptable according to ./configure
      "gnused" # FIXME: sbase sed is not acceptable according to ./configure
      "gawk"
      "gcc" # FIXME: use a minimalistic compiler
      "gnumake"
      "bzip2"
      "sbase"
      "bintools"
    ];
    inherit (pkgs.xz) src;
  };

  contentAddressed = false; #temp
}
