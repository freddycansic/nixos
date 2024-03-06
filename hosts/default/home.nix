{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "freddy";
  home.homeDirectory = "/home/freddy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
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
    pkgs.discord
    pkgs.woeusb
    pkgs.brave
    pkgs.kitty
    pkgs.bitwarden
    pkgs.psst
    pkgs.zoxide
    pkgs.nethogs
    pkgs.jetbrains.idea-ultimate
    pkgs.gradle
    pkgs.gammastep
  ];

  programs.home-manager.enable = true;
  programs.brave.enable = true;
  programs.zsh.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = "
      enabled_layouts tall
      confirm_os_window_close 0
    ";
  };

  programs.git = {
    enable = true;
    userEmail = "93549743+freddycansic@users.noreply.github.com";
    userName = "Freddy Cansick";
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      commit.gpgsign = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    enableBashIntegration = false;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      gruvbox_original_dark_medium = let
        bg0 = "#282828";
        bg1 = "#32302f";
        bg2 = "#32302f";
        bg3 = "#45403d";
        bg4 = "#45403d";
        bg5 = "#5a524c";
        bg_statusline1 = "#32302f";
        bg_statusline2 = "#3a3735";
        bg_statusline3 = "#504945";
        bg_diff_green = "#34381b";
        bg_visual_green = "#3b4439";
        bg_diff_red = "#402120";
        bg_visual_red = "#4c3432";
        bg_diff_blue = "#0e363e";
        bg_visual_blue = "#374141";
        bg_visual_yellow = "#4f422e";
        bg_current_word = "#3c3836";

        fg0 = "#ebdbb2";
        fg1 = "#ebdbb2";
        red = "#fb4934";
        orange = "#fe8019";
        yellow = "#fabd2f";
        green = "#b8bb26";
        aqua = "#8ec07c";
        blue = "#83a598";
        purple = "#d3869b";
        bg_red = "#cc241d";
        bg_green = "#b8bb26";
        bg_yellow = "#fabd2f";

        grey0 = "#7c6f64";
        grey1 = "#928374";
        grey2 = "#a89984";
      in {
        "type" = yellow;
        "constant" = purple;
        "constant.numeric" = purple;
        "constant.character.escape" = orange;
        "string" = green;
        "string.regexp" = blue;
        "comment" = grey0;
        "variable" = fg0;
        "variable.builtin" = blue;
        "variable.parameter" = fg0;
        "variable.other.member" = fg0;
        "label" = aqua;
        "punctuation" = grey2;
        "punctuation.delimiter" = grey2;
        "punctuation.bracket" = fg0;
        "keyword" = red;
        "keyword.directive" = aqua;
        "operator" = orange;
        "function" = green;
        "function.builtin" = blue;
        "function.macro" = aqua;
        "tag" = yellow;
        "namespace" = aqua;
        "attribute" = aqua;
        "constructor" = yellow;
        "module" = blue;
        "special" = orange;

        "markup.heading.marker" = grey2;
        "markup.heading.1" = {
          fg = red;
          modifiers = ["bold"];
        };
        "markup.heading.2" = {
          fg = orange;
          modifiers = ["bold"];
        };
        "markup.heading.3" = {
          fg = yellow;
          modifiers = ["bold"];
        };
        "markup.heading.4" = {
          fg = green;
          modifiers = ["bold"];
        };
        "markup.heading.5" = {
          fg = blue;
          modifiers = ["bold"];
        };
        "markup.heading.6" = {
          fg = fg0;
          modifiers = ["bold"];
        };
        "markup.list" = red;
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.link.url" = {
          fg = blue;
          modifiers = ["underlined"];
        };
        "markup.link.text" = purple;
        "markup.quote" = grey2;
        "markup.raw" = green;

        "diff.plus" = green;
        "diff.delta" = orange;
        "diff.minus" = red;

        "ui.background" = {bg = bg0;};
        "ui.background.separator" = grey0;
        "ui.cursor" = {
          fg = bg0;
          bg = fg0;
        };
        "ui.cursor.match" = {
          fg = orange;
          bg = bg_visual_yellow;
        };
        "ui.cursor.insert" = {
          fg = bg0;
          bg = grey2;
        };
        "ui.cursor.select" = {
          fg = bg0;
          bg = blue;
        };
        "ui.cursorline.primary" = {bg = bg1;};
        "ui.cursorline.secondary" = {bg = bg1;};
        "ui.selection" = {bg = bg3;};
        "ui.linenr" = grey0;
        "ui.linenr.selected" = fg0;
        "ui.statusline" = {
          fg = fg0;
          bg = bg3;
        };
        "ui.statusline.inactive" = {
          fg = grey0;
          bg = bg1;
        };
        "ui.statusline.normal" = {
          fg = bg0;
          bg = fg0;
          modifiers = ["bold"];
        };
        "ui.statusline.insert" = {
          fg = bg0;
          bg = yellow;
          modifiers = ["bold"];
        };
        "ui.statusline.select" = {
          fg = bg0;
          bg = blue;
          modifiers = ["bold"];
        };
        "ui.bufferline" = {
          fg = grey0;
          bg = bg1;
        };
        "ui.bufferline.active" = {
          fg = fg0;
          bg = bg3;
          modifiers = ["bold"];
        };
        "ui.popup" = {
          fg = grey2;
          bg = bg2;
        };
        "ui.window" = {
          fg = grey0;
          bg = bg0;
        };
        "ui.help" = {
          fg = fg0;
          bg = bg2;
        };
        "ui.text" = fg0;
        "ui.text.focus" = fg0;
        "ui.menu" = {
          fg = fg0;
          bg = bg3;
        };
        "ui.menu.selected" = {
          fg = bg0;
          bg = blue;
          modifiers = ["bold"];
        };
        "ui.virtual.whitespace" = {fg = bg4;};
        "ui.virtual.indent-guide" = {fg = bg4;};
        "ui.virtual.ruler" = {bg = bg3;};

        "hint" = blue;
        "info" = aqua;
        "warning" = yellow;
        "error" = red;
        "diagnostic" = {underline = {style = "curl";};};
        "diagnostic.hint" = {
          underline = {
            color = blue;
            style = "dotted";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = aqua;
            style = "dotted";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = yellow;
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = red;
            style = "curl";
          };
        };
      };
    };

    settings = {
      theme = "gruvbox_original_dark_medium";

      editor = {
        soft-wrap.enable = true;
        search.smart-case = false;
        color-modes = true;
      };

      keys.select = {
        y = "yank_to_clipboard";
      };

      keys.normal = {
        # Use system clipboard by default
        # Swap around p and P commands
        p = "paste_clipboard_before";
        P = "paste_clipboard_after";

        y = "yank_to_clipboard";

        d = ["yank_to_clipboard" "delete_selection"];
      };

      keys.normal.space = {
        y = "yank";
        p = "paste_before";
        P = "paste_after";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, P, exec, rofi -show run"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
      };

      monitor = "DP-2,1920x1080@144,0x0,1";

      windowrulev2 = [
        "noanim,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
        "noinitialfocus,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
      ];
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/freddy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    XDG_RUNTIME_DIR = "/run/user/$(id -u)";
  };
}
