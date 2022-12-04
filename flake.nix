{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww-fork.url = "github:SomeGuyNamedMy/swww";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, hyprland, swww-fork, nur, emacs-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.mason = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          { home.stateVersion = "22.11";
            home.username = "mason";
            home.homeDirectory = "/home/mason";
          }
          { nixpkgs.overlays = [ (import emacs-overlay) ]; }
          hyprland.homeManagerModules.default
          ./shell.nix
          ./kakoune.nix
          ./mpd.nix
          ./desktop.nix
          ./programming-env.nix
          ./packages.nix
        ];
      };
    };
}
