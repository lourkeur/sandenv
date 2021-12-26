{
  inputs,
  pkgs,
}:
inputs.self.lib.mkDerivation {
  system = "x86_64-linux";
  inherit (pkgs.sbase) pname version;
  builder = "/bin/sh";
  args = [./builder.sh];
  env = {
    PATH =
      inputs.nixpkgs.lib.concatMapStringsSep ":" (name: "${pkgs.${name}}/bin") [
        "bintools"
        "gawk"
        "gcc" # FIXME: use a minimalistic compiler
        "gnumake"
        "sbase"
      ]
      + ":/bin";
    inherit (pkgs.sbase) src;
  };

  contentAddressed = false; #temp
}
