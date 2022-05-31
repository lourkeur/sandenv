{
  inputs,
  pkgs,
}:
inputs.self.lib.mkDerivation {
  system = "x86_64-linux";
  pname = "sed";
  inherit (pkgs.gnused) version;
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
        "xz"
        "gnumake"
        "sbase"
      ]
      + ":/bin";
    inherit (pkgs.gnused) src;
  };
}
