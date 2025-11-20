{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    pkgs.vulkan-tools # dependency of zed
  ];

  home-manager.users.freddy = {
    programs.zed-editor = {
      enable = true;
      extensions = ["fish" "rust"];
      userSettings = {
        ui_font_size = 16;
        ui_font_family = "SFMono Nerd Font";
        buffer_font_size = 13;
        buffer_font_family = "SFMono Nerd Font";
        theme = {
          mode = "system";
          light = "One Light";
          dark = "One Dark";
        };
        tab_bar = {
          show = true;
        };
        gutter = {
          folds = false;
          # code_actions = false;
        };
        format_on_save = "on";
        soft_wrap = "editor_width";
        tab_size = 4;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        inlay_hints = {
          enabled = false;
        };
        git = {
          inline_blame = {
            enabled = false;
          };
        };
        languages = {
          Ruby = {
            tab_size = 2;
            language_servers = ["ruby-lsp" "!solargraph"];
          };
          Rust = {
            language_servers = ["rust-analyzer"];
            code_actions_on_format = {
              organiseImports = true;
            };
          };
          Haml = {
            tab_size = 2;
          };
          nix = {
            tab_size = 2;
          };
        };
        lsp = {
          rust-analyzer = {
            binary = {
              path = "/usr/bin/nix";
              arguments = ["develop" "--command" "rust-analyzer"];
            };
          };
          ruby-lsp = {
            initialization_options = {
              enabledFeatures = {
                diagnostics = false;
              };
            };
            settings = {
              use_bundler = true;
            };
          };
          rubocop = {
            initialization_options = {
              enabledFeatures = {
                safeAutocorrect = false;
              };
            };
            settings = {
              use_bundler = true;
            };
          };
        };
      };
    };
  };
}
