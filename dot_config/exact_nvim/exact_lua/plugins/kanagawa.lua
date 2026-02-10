return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      background = {
        dark = "dragon",
      },
      transparent = false, -- Set to true if you want your terminal background to show through
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
