{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, P, exec, rofi -show drun -show-icons"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"

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

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        layout = "master";
      };

      master = {
        no_gaps_when_only = 1;
      };

      monitor = ",preferred,auto,auto";

      windowrulev2 = [
        "noanim,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
        "noinitialfocus,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
        "windowdance,class:^(jetbrains-.*)$,floating:1"
        # Fix splash screen showing in weird places and prevent annoying focus takeovers
        "center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"

        # Center popups/find windows
        "center,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        # Disable window flicker when autocomplete or tooltips appear
        "nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1"
      ];
    };
  };
}
