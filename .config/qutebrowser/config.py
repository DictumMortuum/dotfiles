config.bind('<Ctrl-Shift-y>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-p>', 'set content.proxy http://bop.ps.gameop.net:8080"')

c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.128 Safari/537.36"
c.tabs.padding = {"top": 10, "bottom": 10, "left": 10, "right": 10}
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
