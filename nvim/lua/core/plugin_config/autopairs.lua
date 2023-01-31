local status_ok, nvim_pairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  return
end

nvim_pairs.setup {
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' }
  },
  disable_filetype = { 'TelescopePrompt' }
}

local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done() )
