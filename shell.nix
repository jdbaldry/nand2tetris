{ pkgs ? import <nixpkgs> }:

with pkgs;
mkShell {
  buildInputs = [ dos2unix gnumake openjdk zip ];
  shellHook = ''
    export PATH="$PATH":"$(pwd)"
  '';
}
