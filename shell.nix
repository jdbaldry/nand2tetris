{ pkgs ? import <nixpkgs> }:

with pkgs;
mkShell {
  buildInputs = [ gnumake openjdk zip ];
  shellHook = ''
    export PATH="$PATH":"$(pwd)"
  '';
}
