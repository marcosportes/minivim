-- ========================================
-- Minivim - Minimalist Neovim + Gruvbox
-- No external plugins - 100% native
-- Compatible with Neovim 0.8+
-- ========================================

-- Add Minivim lua modules path
package.path = package.path .. ";/etc/minivim/lua/?.lua"

-- Load core modules
require("settings").setup()
require("theme").setup()
require("keymaps").setup()
require("commands").setup()
require("autocmds").setup()
require("welcome").setup()
