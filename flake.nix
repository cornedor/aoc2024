{
  description = "AOC24 development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    {
      devShells.aarch64-darwin =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.gleam
              pkgs.erlang_27
              pkgs.rebar3
            ];
          };
        };
    };
}
 