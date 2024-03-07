{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, P, exec, rofi -show run"
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
}
