# TODO: FOD, advanced attributes
{
  system,
  pname,
  version,
  builder,
  args ? [],
  outputs ? ["out"],
  contentAddressed ? true,
  env ? {},
}:
builtins.derivation (env
  // {
    inherit pname version system builder args outputs;
    name = "${pname}-${version}";
    __contentAddressed = contentAddressed;
  })
