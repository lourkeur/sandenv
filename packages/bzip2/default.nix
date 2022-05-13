{
  inputs,
  pkgs,
}:
inputs.self.lib.mkDerivation {
  system = "x86_64-linux";
  inherit (pkgs.bzip2) pname version;
  builder = "/bin/sh";
  args = [./builder.sh];
  env = {
    PATH = inputs.nixpkgs.lib.concatMapStringsSep ":" (name: "${pkgs.${name}}/bin") [
      "gnugrep" # FIXME: sbase grep is not acceptable according to ./configure
      "gnused" # FIXME: sbase sed is not acceptable according to ./configure
      "gawk"
      "gcc" # FIXME: use a minimalistic compiler
      "gnumake"
      "gzip"
      "sbase"
    ];
    inherit (pkgs.bzip2) src;
  };
}
