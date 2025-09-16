--NOTE: 1 for float, 2 for tab, 3 for running in split term(only bottom split), only works after restart nvim
_G.RUNNER_MODE = 1

-- helper function to get mode
local function get_mode()
  if RUNNER_MODE == 1 then
    return "float"
  elseif RUNNER_MODE == 2 then
    return "tab"
  elseif RUNNER_MODE == 3 then
    return "term"
  else
    return "float"
  end
end

return {
  "CRAG666/code_runner.nvim",
  main = "code_runner",
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
  opts = function()
    return {
      mode = get_mode(), -- toggle mode, options: tab, float , term
      focus = true,
      startinsert = true,
      term = { position = "bot", size = 20 },
      float = {
        border = "rounded",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
      },
      filetype = {
        cpp = {
          "cd $dir && cl /utf-8 /nologo /EHsc /O2 /std:c++latest /Zc:__cplusplus $fileName /Fe:$fileNameWithoutExt.exe && $fileNameWithoutExt.exe",
        },
        c = {
          "cd $dir && cl /utf-8 /nologo /O2 $fileName /Fe:$fileNameWithoutExt.exe && $fileNameWithoutExt.exe",
        },
        python = {
          "cd $dir &&",
          "python -u $fileName",
        },
      },
    }
  end,
  keys = {
    { "<F5>",       "<cmd>w<CR><cmd>RunCode<CR>", desc = "Save and Run Code" },
    { "<S-F5>",     "<cmd>RunClose<CR>",          desc = "Stop Running" },
    { "<C-F5>",     "<cmd>w<CR><cmd>RunFile<CR>", desc = "Save and Run File" },
    { "<leader>rc", "<cmd>w<CR><cmd>RunCode<CR>", desc = "Save and Run Code" },
    { "<leader>rf", "<cmd>w<CR><cmd>RunFile<CR>", desc = "Save and Run File" },
    { "<leader>rp", "<cmd>RunProject<CR>",        desc = "Run Project" },
    { "<leader>rx", "<cmd>RunClose<CR>",          desc = "Close Runner" },
  },
}
