{
  description = "Rust development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in

    {

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          name = "rust";
          packages = with pkgs; [
            rustc
            cargo
            clippy
            rustfmt
          ];

        };
      });
    };
}
