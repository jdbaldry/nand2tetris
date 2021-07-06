{ pkgs ? import <nixpkgs> }:

with pkgs;
mkShell {
  buildInputs = [ gnumake zip ];
  shellHook = ''
    export PATH="$PATH":"$(pwd)"
  '';
}
