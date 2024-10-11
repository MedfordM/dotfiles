{ pkgs, ... }:

{
  imports = [
    modules/common/zellij
    modules/common/git
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bat
    pkgs.jq
  ];

  xdg.configFile.kittyThemeFile = {
    source = ./kitty/theme.conf;
    target = "./kitty/theme.conf";
  };

  xdg.configFile.kittyCatppuccinMocha = {
    source = ./kitty/themes/mocha.conf;
    target = "./kitty/themes/mocha.conf";
  };

  programs.kitty = {
    enable = true;
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
        include theme.conf
        mouse_map kitty_mod+left press grabbed mouse_selection rectangle
        mouse_map shift+left press ungrabbed,grabbed mouse_selection normal
        mouse_map ctrl+shift+alt+left press ungrabbed,grabbed mouse_selection rectangle
    '';
  };

  programs.eza.enable = true;
  programs.neovim.enable = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/michaelmedford/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
