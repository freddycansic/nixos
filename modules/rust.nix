{
  config,
  pkgs,
  inputs,
  ...
}:
# let
#   libPath = builtins.replaceStrings [" "] [":"] (pkgs.lib.makeLibraryPath [
#     pkgs.libxkbcommon
#     pkgs.libGL
#     pkgs.wayland
#     pkgs.libX11
#     pkgs.libXrandr
#     pkgs.libXi
#     pkgs.libXcursor
#     pkgs.pkg-config
#     pkgs.dbus
#   ]);
# in
let
  rustToolchain = pkgs.rust-bin.selectLatestNightlyWith (toolchain:
    toolchain.default.override {
      extensions = [
        "rust-src"
        "llvm-tools-preview"
        "rustc-codegen-cranelift-preview"
      ];
    });
in {
  # NOTE: If getting AccessDeniedException in RustRover for copying stdlib, do:
  # cp -r \
  # ~/.local/share/rust/rust-toolchain/lib/rustlib/src/rust \
  # ~/.cache/JetBrains/RustRover2026.2/intellij-rust/stdlib-local-copy/1.100.0-nightly-e9b48022324cbc4a56c6306460b750120f974d4a

  nixpkgs.overlays = [
    (import inputs.rust-overlay)
  ];

  environment.systemPackages = with pkgs; [
    (inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "rust-rover" [
      "al.aoli.intellijdirenv" # direnv
      "nix-idea" # nix
      "GLSL"
    ])

    rustToolchain

    cargo-tarpaulin
    clang
    mold
  ];

  environment.variables = {
    WINIT_UNIX_BACKEND = "wayland";
    # LD_LIBRARY_PATH = libPath;
  };

  home-manager.users.freddy = {
    # give rustrover a stable path to find rust toolchain + stdlib source
    home.file.".local/share/rust/rust-toolchain".source = "${rustToolchain}";
  };
}
