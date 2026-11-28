{pkgs ? import <nixpkgs> {}}:
pkgs.appimageTools.wrapType2 {
  pname = "tikz-editor";
  version = "1.3.0";

  src = pkgs.fetchurl {
    url = "https://github.com/DominikPeters/tikz-editor/releases/download/app-v1.3.0/TikZ.Editor_1.3.0_amd64.AppImage";
    hash = "sha256-AXo5mIjGg2yiI2syrkHF7z/RzeeMsa2gmpKCQ5EjW2Q==";
  };

  extraPkgs = pkgs:
    with pkgs; [
      webkitgtk_4_1
      gtk3
      glib
      libsoup_3
      libgpg-error
    ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    cat > $out/share/applications/tikz-editor.desktop <<EOF
    [Desktop Entry]
    Type=Application
    Name=TikZ Editor
    Comment=Visual TikZ editor
    Exec=tikz-editor %F
    Terminal=false
    Categories=Education;Graphics;
    StartupNotify=true
    EOF
  '';

  meta = {
    description = "Visual TikZ editor";
    homepage = "https://github.com/DominikPeters/tikz-editor";
    license = pkgs.lib.licenses.mit;
    platforms = ["x86_64-linux"];
    mainProgram = "tikz-editor";
  };
}
