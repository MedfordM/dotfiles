{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "michaelmedford";
  home.homeDirectory = "/Users/michaelmedford";

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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.bat

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  xdg.configFile.kittyThemeFile = {
    source = ../kitty/theme.conf;
    target = "kitty/theme.conf";
  };

  xdg.configFile.kittyCatppuccinMocha = {
    source = ../kitty/themes/mocha.conf;
    target = "./kitty/themes/mocha.conf";
  };

  programs.eza.enable = true;
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
  programs.neovim.enable = true;
  programs.zellij.enable = true;

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
