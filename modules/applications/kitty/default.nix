{ config, lib, pkgs, ... }:

{
  options = {
    kitty.enable = lib.mkEnableOption "kitty";
  };

  config = lib.mkIf ( config.kitty.enable ) {
    home-manager.users.${config.user} = {
      xdg.configFile.kittyThemeFile = {
        source = ./theme.conf;
        target = "./kitty/theme.conf";
      };

      xdg.configFile.kittyCatppuccinMocha = {
        source = ./themes/mocha.conf;
        target = "./kitty/themes/mocha.conf";
      };

      programs.kitty = {
        enable = true;
        font = {
          name = "family='Fira Code' variable_name=FiraCodeRoman style=FiraCodeRoman-Regular";
          package = pkgs.fira-code;
          size = 16;
        };
        keybindings = {
          "ctrl+v" = "paste_from_clipboard";
          "ctrl+tab" = "no_op";
          "kitty_mod+tab" = "no_op";
          "kitty_mod+h" = "no_op";
          "kitty_mod+n" = "no_op";
          "kitty_mod+e" = "no_op";
          "ctrl+equal" = "change_font_size all +1.0";
          "ctrl+minus" = "change_font_size all -1.0";
          "ctrl+0" = "change_font_size all 0";
          "ctrl+alt+r" = "load_config_file";
        };
        settings = {
          kitty_mod = "ctrl+shift";
          cursor_shape = "beam";
          mouse_hide_wait = 3.0;
          copy_on_select = true;
          focus_follows_mouse = true;
          scrollback_lines = -1;
          scrollback_pager = "nvim";
          sync_to_monitor = true;
          enable_audio_bell = false;
          confirm_os_window_close = 0;
          allow_remote_control = true;
        };
        extraConfig = 
          ''
          font_features FiraCodeRoman-Regular +ss02 +ss03 +ss04 +cv02 +cv06 +cv16 +cv25 +cv26 +cv28 +cv29 +cv30 +cv32
          include theme.conf
          mouse_map kitty_mod+left press grabbed mouse_selection rectangle
          mouse_map shift+left press ungrabbed,grabbed mouse_selection normal
          mouse_map ctrl+shift+alt+left press ungrabbed,grabbed mouse_selection rectangle
          '';
      };
    };
  };
}
