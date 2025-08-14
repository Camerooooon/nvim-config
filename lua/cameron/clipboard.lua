-- set clipboard=unnamed
--
-- let g:clipboard = {
--        'copy': {
--            '+': ['wl-copy', '--trim-newline'],
--            '*': ['wl-copy', '--trim-newline'],
--        },
--        'paste': {
--            '+': ['wl-paste', '--no-newline'],
--            '*': ['wl-paste', '--no-newline'],
--        },
--      }
--

-- WSL clipboard support
let g:clipboard = {
  \   'name': 'WslClipboard',
  \   'copy': {
  \      '+': 'clip.exe',
  \      '*': 'clip.exe',
  \    },
  \   'paste': {
  \      '+': 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \      '*': 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \   },
  \   'cache_enabled': 0,
  \ }
