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
  nixpkgs.overlays = [
    (import inputs.rust-overlay)
  ];

  environment.systemPackages = with pkgs; [
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
    # give rustrover a stable path to find rust stdlib source
    home.file.".local/share/rust/rust-src".source = "${rustToolchain}/lib/rustlib/src/rust";
  };
}
