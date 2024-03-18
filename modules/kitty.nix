{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.kitty];

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = "
      enabled_layouts tall
      confirm_os_window_close 0
    ";
    font = {
      name = "firacode";
      size = 11;
    };
    theme = "Gruvbox Dark";
  };

  home.file."${config.xdg.configHome}/kitty/themes/gruvbox_dark.conf".text = ''
    # gruvbox dark by morhetz, https://github.com/morhetz/gruvbox
    # This work is licensed under the terms of the MIT license.
    # For a copy, see https://opensource.org/licenses/MIT.

    background  #282828
    foreground  #ebdbb2

    cursor                #928374

    selection_foreground  #928374
    selection_background  #3c3836

    color0  #282828
    color8  #928374

    # red
    color1                #cc241d
    # light red
    color9                #fb4934

    # green
    color2                #98971a
    # light green
    color10               #b8bb26

    # yellow
    color3                #d79921
    # light yellow
    color11               #fabd2d

    # blue
    color4                #458588
    # light blue
    color12               #83a598

    # magenta
    color5                #b16286
    # light magenta
    color13               #d3869b

    # cyan
    color6                #689d6a
    # light cyan
    color14               #8ec07c

    # light gray
    color7                #a89984
    # dark gray
    color15               #928374
  '';
}
