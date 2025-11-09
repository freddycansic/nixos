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
    # TODO move to fish config not bash
    shellAliases = {
      logout = "loginctl kill-user $USER";
      l = "ls -la";
    };
  };

  home-manager.users.freddy = {
    programs.fish.enable = true;

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      configPath = "${builtins.toString ./.}/starship.toml";
    };
  };
}
