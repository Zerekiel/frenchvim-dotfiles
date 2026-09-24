return {
  "catgoose/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      options = {
        parsers = {
          css = true
        }
      },
    })
  end,
}
