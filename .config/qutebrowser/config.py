c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 0, "right": 0}
c.fonts.monospace = 'Hack'
c.fonts.tabs = '10pt monospace'
config.source('nord-qutebrowser.py')
foreground = "#ffffff"
background = "#2e3440"
selected = "#4c566a"
c.colors.tabs.bar.bg = background
c.colors.tabs.even.bg = background
c.colors.tabs.even.fg = foreground
c.colors.tabs.odd.bg = background
c.colors.tabs.odd.fg = foreground
c.colors.tabs.selected.even.bg = selected
c.colors.tabs.selected.even.fg = foreground
c.colors.tabs.selected.odd.bg = selected
c.colors.tabs.selected.odd.fg = foreground
c.hints.chars = "asdfkl"
c.hints.border = "1px solid #2e3440"
c.colors.hints.bg = background
c.colors.hints.fg = foreground
c.colors.hints.match.fg = "#bf616a"

c.url.searchengines = {
  "DEFAULT": "https://duckduckgo.com/?q={}",
  "s": "https://stash.int.openbet.com/plugins/servlet/search?q=\"{}\"",
  "j": "https://jira.openbet.com/issues/?jql=text~\"{}\""
}

config.bind('<Ctrl-Shift-y>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-p>', 'set content.proxy http://bop.ps.gameop.net:8080')
config.bind('<Ctrl-Shift-p>', 'set content.proxy http://custproxy.openbet:8080')

def content_persist(p):
  with config.pattern(p) as p:
    p.content.media_capture = True

content_persist('*://meet.google.com/')
content_persist('*://bluejeans.com/')

