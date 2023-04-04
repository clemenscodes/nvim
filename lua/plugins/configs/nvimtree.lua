local status_ok = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
local options = {
    filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        adaptive_size = true,
        side = "left",
        width = 40,
        hide_root_folder = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
    },
    git = {
        enable = false,
        ignore = false,
    },
    filesystem_watchers = {
        enable = true,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = "none",

        indent_markers = {
            enable = false,
        },

        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },

            glyphs = {
                default = " ",
                symlink = " ",
                folder = {
                    default = " ",
                    empty = " ",
                    empty_open = " ",
                    open = " ",
                    symlink = " ",
                    symlink_open = " ",
                    arrow_open = " ",
                    arrow_closed = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = " ",
                    renamed = "➜ ",
                    untracked = "★",
                    deleted = " ",
                    ignored = "◌",
                },
            },
        },
    },
}

return options
