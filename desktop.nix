{ pkgs, lib, config, ... }: #my-wallpapers, ... }:

{

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
  };

  qt.enable = true;
  qt.platformTheme = "gtk";



  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    extraConfig = builtins.readFile ./hyprland.conf
                  + "bind=SUPER,R,exec,${pkgs.bemenu}/bin/bemenu-run -b\n"
                  + "bind=SUPER,P,exec,rofi -show";
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    style = ./nord-waybar.css;
  };

  programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = ./nord.rasi;
  };

  programs.qutebrowser = {
    enable = true;
    extraConfig = "config.source('${./nord-qutebrowser.py}')";
  };
  programs.librewolf.enable = true;

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  services.fnott = {
    enable = true;
  };

  services.gammastep = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
  };

  programs.mpv = {
    enable = true;
  };

  xdg.enable = true;
  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "imv %U";
      terminal = false;
      mimeType = [ "image/jpeg" "image/png" ];
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "text/plain" = [ "emacs.desktop" ];
    };
  };
}
