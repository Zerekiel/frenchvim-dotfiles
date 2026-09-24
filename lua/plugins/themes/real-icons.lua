return {
  {
    "Mirsmog/real-icons.nvim",
    build = ":RealIcons install",
    lazy = false,
    opts = {
      integrations = {
        neo_tree = true,
        bufferline = true,
        lualine = false,
        telescope = true,
      }
    }
  }
}
