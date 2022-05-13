{
  inputs,
  pkgs,
}:
inputs.self.lib.mkDerivation {
  system = "x86_64-linux";
  pname = "make";
  inherit (pkgs.gnumake) version;
  builder = "/bin/sh";
  args = [./builder.sh];
  env = {
    PATH =
      inputs.nixpkgs.lib.concatMapStringsSep ":" (name: "${pkgs.${name}}/bin") [
        "bintools"
        "gnugrep" # FIXME: sbase grep is not acceptable according to ./configure
        "gnused" # FIXME: sbase sed is not acceptable according to ./configure
        "gawk"
        "gcc" # FIXME: use a minimalistic compiler
        "gzip"
        "gnumake"
        "sbase"
      ]
      + ":/bin";
    inherit (pkgs.gnumake) src;
  };
}
