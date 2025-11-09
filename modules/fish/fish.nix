{
  config,
  pkgs,
  ...
}: {
  # https://nixos.wiki/wiki/Fish
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  home-manager.users.freddy = {
    xdg.configFile."starship.toml".source = ./starship.toml;

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        fastfetch
      '';
      shellAliases = {
        logout = "loginctl kill-user $USER";
        l = "ls -la";
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
