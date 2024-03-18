{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "gruvbox_original_dark_medium";

      editor = {
        soft-wrap.enable = true;
        search.smart-case = false;
        color-modes = true;
        # statusline.primary-selection-length = true;
      };

      keys.select = {
        y = "yank_to_clipboard";
      };

      keys.normal = {
        # Use system clipboard by default
        # Swap around p and P commands
        p = "paste_clipboard_before";
        P = "paste_clipboard_after";

        y = "yank_to_clipboard";

        d = ["yank_to_clipboard" "delete_selection"];
      };

      keys.normal.space = {
        y = "yank";
        p = "paste_before";
        P = "paste_after";
      };
    };

    themes = {
      gruvbox_original_dark_medium = let
        bg0 = "#282828";
        bg1 = "#32302f";
        bg2 = "#32302f";
        bg3 = "#45403d";
        bg4 = "#45403d";
        bg5 = "#5a524c";
        bg_statusline1 = "#32302f";
        bg_statusline2 = "#3a3735";
        bg_statusline3 = "#504945";
        bg_diff_green = "#34381b";
        bg_visual_green = "#3b4439";
        bg_diff_red = "#402120";
        bg_visual_red = "#4c3432";
        bg_diff_blue = "#0e363e";
        bg_visual_blue = "#374141";
        bg_visual_yellow = "#4f422e";
        bg_current_word = "#3c3836";

        fg0 = "#ebdbb2";
        fg1 = "#ebdbb2";
        red = "#fb4934";
        orange = "#fe8019";
        yellow = "#fabd2f";
        green = "#b8bb26";
        aqua = "#8ec07c";
        blue = "#83a598";
        purple = "#d3869b";
        bg_red = "#cc241d";
        bg_green = "#b8bb26";
        bg_yellow = "#fabd2f";

        grey0 = "#7c6f64";
        grey1 = "#928374";
        grey2 = "#a89984";
      in {
        "type" = yellow;
        "constant" = purple;
        "constant.numeric" = purple;
        "constant.character.escape" = orange;
        "string" = green;
        "string.regexp" = blue;
        "comment" = grey0;
        "variable" = fg0;
        "variable.builtin" = blue;
        "variable.parameter" = fg0;
        "variable.other.member" = fg0;
        "label" = aqua;
        "punctuation" = grey2;
        "punctuation.delimiter" = grey2;
        "punctuation.bracket" = fg0;
        "keyword" = red;
        "keyword.directive" = aqua;
        "operator" = orange;
        "function" = green;
        "function.builtin" = blue;
        "function.macro" = aqua;
        "tag" = yellow;
        "namespace" = aqua;
        "attribute" = aqua;
        "constructor" = yellow;
        "module" = blue;
        "special" = orange;

        "markup.heading.marker" = grey2;
        "markup.heading.1" = {
          fg = red;
          modifiers = ["bold"];
        };
        "markup.heading.2" = {
          fg = orange;
          modifiers = ["bold"];
        };
        "markup.heading.3" = {
          fg = yellow;
          modifiers = ["bold"];
        };
        "markup.heading.4" = {
          fg = green;
          modifiers = ["bold"];
        };
        "markup.heading.5" = {
          fg = blue;
          modifiers = ["bold"];
        };
        "markup.heading.6" = {
          fg = fg0;
          modifiers = ["bold"];
        };
        "markup.list" = red;
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.link.url" = {
          fg = blue;
          modifiers = ["underlined"];
        };
        "markup.link.text" = purple;
        "markup.quote" = grey2;
        "markup.raw" = green;

        "diff.plus" = green;
        "diff.delta" = orange;
        "diff.minus" = red;

        "ui.background" = {bg = bg0;};
        "ui.background.separator" = grey0;
        "ui.cursor" = {
          fg = bg0;
          bg = fg0;
        };
        "ui.cursor.match" = {
          fg = orange;
          bg = bg_visual_yellow;
        };
        "ui.cursor.insert" = {
          fg = bg0;
          bg = grey2;
        };
        "ui.cursor.select" = {
          fg = bg0;
          bg = blue;
        };
        "ui.cursorline.primary" = {bg = bg1;};
        "ui.cursorline.secondary" = {bg = bg1;};
        "ui.selection" = {bg = bg3;};
        "ui.linenr" = grey0;
        "ui.linenr.selected" = fg0;
        "ui.statusline" = {
          fg = fg0;
          bg = bg3;
        };
        "ui.statusline.inactive" = {
          fg = grey0;
          bg = bg1;
        };
        "ui.statusline.normal" = {
          fg = bg0;
          bg = fg0;
          modifiers = ["bold"];
        };
        "ui.statusline.insert" = {
          fg = bg0;
          bg = yellow;
          modifiers = ["bold"];
        };
        "ui.statusline.select" = {
          fg = bg0;
          bg = blue;
          modifiers = ["bold"];
        };
        "ui.bufferline" = {
          fg = grey0;
          bg = bg1;
        };
        "ui.bufferline.active" = {
          fg = fg0;
          bg = bg3;
          modifiers = ["bold"];
        };
        "ui.popup" = {
          fg = grey2;
          bg = bg2;
        };
        "ui.window" = {
          fg = grey0;
          bg = bg0;
        };
        "ui.help" = {
          fg = fg0;
          bg = bg2;
        };
        "ui.text" = fg0;
        "ui.text.focus" = fg0;
        "ui.menu" = {
          fg = fg0;
          bg = bg3;
        };
        "ui.menu.selected" = {
          fg = bg0;
          bg = blue;
          modifiers = ["bold"];
        };
        "ui.virtual.whitespace" = {fg = bg4;};
        "ui.virtual.indent-guide" = {fg = bg4;};
        "ui.virtual.ruler" = {bg = bg3;};

        "hint" = blue;
        "info" = aqua;
        "warning" = yellow;
        "error" = red;
        "diagnostic" = {underline = {style = "curl";};};
        "diagnostic.hint" = {
          underline = {
            color = blue;
            style = "dotted";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = aqua;
            style = "dotted";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = yellow;
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = red;
            style = "curl";
          };
        };
      };
    };
  };
}