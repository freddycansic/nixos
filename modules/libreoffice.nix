{pkgs, ...}: {
  environment.systemPackages = [pkgs.libreoffice pkgs.hunspellDicts.en-gb-large];
}
