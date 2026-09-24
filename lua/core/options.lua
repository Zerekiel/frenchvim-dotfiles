local utils = require("core.utils")

local opt = vim.opt
local fn = vim.fn

-- display numbers
opt.number = true
opt.relativenumber = true

-- Split window below/right when creating horizontal/vertical windows
opt.splitbelow = true
opt.splitright = true

-- Clipboard settings, always use clipboard for all delete, yank, change, put
-- operation, see https://stackoverflow.com/q/30691466/6064933
if fn["provider#clipboard#Executable"]() ~= "" then
	opt.clipboard:append("unnamedplus")
end

-- Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
opt.swapfile = false

-- Time in milliseconds to wait for a mapped sequence to complete,
-- Basically it render my keymaps effective :)
-- see https://unix.stackexchange.com/q/36882/221410 for more info
opt.timeoutlen = 500

-- General tab settings
opt.tabstop = 2 -- Number of visual spaces per TAB
opt.softtabstop = 2 -- Number of spaces in tab when editing
opt.shiftwidth = 2 -- Number of spaces to use for autoindent
opt.expandtab = true -- Expand tab to spaces so that tabs are spaces

-- Ignore case in general, but become case-sensitive when uppercase is present
opt.ignorecase = true
opt.smartcase = true

-- File and script encoding settings for vim
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1" }

-- Disable showing current mode on command line since statusline plugins can show it.
opt.showmode = false

-- Persistent undo even after you close a file and re-open it
opt.undofile = true

-- Completion behaviour
opt.completeopt:append("menuone") -- Show menu even if there is only one item
opt.completeopt:remove("preview") -- Disable the preview window

opt.pumheight = 10 -- Maximum number of items to show in popup menu
opt.pumblend = 5 -- Pseudo transparency for completion menu
opt.pumborder = "single"

opt.winblend = 0 -- Pseudo transparency for floating window
opt.winborder = "single"

-- Align indent to next multiple value of shiftwidth. For its meaning,
-- see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
opt.shiftround = true

opt.virtualedit = "block" -- Virtual edit is useful for visual block edit

-- External program to use for grep command
if utils.executable("rg") then
	opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	opt.grepformat = "%f:%l:%c:%m"
end

-- Enable true color support. Do not set this option if your terminal does not
-- support true colors! For a comprehensive list of terminals supporting true
-- colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
opt.termguicolors = true

-- Set up cursor color and shape in various mode, ref:
-- https://neovim.io/doc/user/faq/#_how-to-change-cursor-color-in-the-terminal%3f
opt.guicursor =
	"n-v:block-Cursor/lCursor,i-c-ci-ve:ver50-blinkwait50-blinkoff100-blinkon175-Cursor2/lCursor2,r-cr:hor20,o:hor20"

opt.showcmdloc = "statusline"

-- Code Folding
-- Code folding
opt.foldenable = true
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

opt.fillchars:append({
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	foldinner = " ",
	eob = " ",
})
