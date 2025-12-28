{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Used with `nixos-rebuild switch --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Essential modules
        ./configuration.nix
        ./modules/fonts.nix
        ./modules/ime.nix

        # Optional modules
        ./modules/build-essential.nix
        ./modules/ocaml.nix
        ./modules/coq.nix
        ./modules/unfree.nix
        ./modules/riscv.nix
      ];
    };
  };
}
