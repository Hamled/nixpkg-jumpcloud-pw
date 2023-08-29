{
  description = "JumpCloud Password Manager";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let system = "x86_64-linux"; in { };
}
