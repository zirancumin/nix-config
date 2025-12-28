{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Used with `nixos-rebuild switch --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    nixosConfigurations = {
      "probook" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Essential modules
          ./configuration.nix
          ./hosts/probook/hardware-configuration.nix
          ./modules/fonts.nix
          ./modules/ime.nix
          {
            boot.extraModprobeConfig = ''
              options rtw88_pci disable_aspm=1 disable_msi=1
              options rtw88_core disable_lps_deep=1
            '';
          }
          # Optional modules
          ./modules/build-essential.nix
          ./modules/ocaml.nix
          ./modules/coq.nix
          ./modules/unfree.nix
          ./modules/riscv.nix
        ];
      };
      "thinkpad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/thinkpad/hardware-configuration.nix
          ./modules/fonts.nix
          ./modules/ime.nix
        ];
      };
    };
  };
}
