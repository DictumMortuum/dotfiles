config.bind('<Ctrl-Shift-y>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-p>', 'set content.proxy http://bop.ps.gameop.net:8080"')

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 0, "right": 0}
c.fonts.monospace = 'Hack'
c.fonts.tabs = '10pt monospace'
config.source('nord-qutebrowser.py')
c.colors.tabs.bar.bg = "#2E3440"
c.colors.tabs.even.bg = "#2E3440"
c.colors.tabs.even.fg = "#ffffff"
c.colors.tabs.odd.bg = "#2E3440"
c.colors.tabs.odd.fg = "#ffffff"
c.colors.tabs.selected.even.bg = "#4c566a"
c.colors.tabs.selected.even.fg = "#ffffff"
c.colors.tabs.selected.odd.bg = "#4c566a"
c.colors.tabs.selected.odd.fg = "#ffffff"
