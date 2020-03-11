import subprocess

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
c.content.pdfjs = True
c.tabs.padding = {"top": 8, "bottom": 8, "left": 5, "right": 5}
c.tabs.title.format = '{current_title}'
c.fonts.monospace = 'monospace'
c.fonts.tabs = '9pt monospace'
c.editor.command = ['st', '-e', 'vi', '-f', '{file}', '-c', 'normal {line}G{column0}l'];
c.url.default_page = 'http://127.0.0.1:1234/startpage'
c.url.start_pages = 'http://127.0.0.1:1234/startpage'
c.content.media_capture = True
c.hints.chars = "asdfkl"

c.url.searchengines = {
  "DEFAULT": "https://duckduckgo.com/?q={}",
  "s": 'https://stash.int.openbet.com/plugins/servlet/search?q="{}"',
  "j": 'https://jira.openbet.com/issues/?jql=text~"{}"'
}

proxies = [
  "http://bop.ps.gameop.net:8080",
  "http://custproxy.openbet:8080"
]

def read_xresources(prefix):
  props = {}
  x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
  lines = x.stdout.decode().split('\n')
  for line in filter(lambda l : l.startswith(prefix), lines):
    prop, _, value = line.partition(':\t')
    props[prop] = value
  return props

def exec_userscript(com):
  return 'spawn --userscript /usr/local/bin/dotctl {}'.format(com)

config.bind('<Ctrl-Shift-y>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-p>', 'config-cycle -p content.proxy system {}'.format(" ".join(proxies)))
config.bind('<Ctrl-e>', exec_userscript('qute-textedit'))
config.bind('<Ctrl-Shift-e>', exec_userscript('qute-screenedit'))
config.bind('<Ctrl-Alt-c>', exec_userscript('qute-copy'))
config.bind('<Ctrl-Shift-u>', exec_userscript('qute-url'))
config.bind('<Ctrl-Shift-g>', exec_userscript('qute-clone'))
config.bind('<Ctrl-Shift-t>', exec_userscript('qute-tokens'))
config.bind('<Ctrl-Shift-j>', exec_userscript('qute-jira'))
config.bind('<Ctrl-Shift-s>', exec_userscript('qute-search'))
config.bind('<Shift+Ins>', 'insert-text {primary}', mode='insert')
config.bind('<Ctrl+Ins>', 'insert-text {clipboard}', mode='insert')
config.bind('<Ctrl-i>', 'open-editor', mode='insert')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')

xresources = read_xresources('*')

c.hints.border = "1px solid " + xresources["*background"]
c.colors.completion.category.bg = xresources["*background"]
c.colors.completion.category.border.bottom = xresources["*background"]
c.colors.completion.category.border.top = xresources["*background"]
c.colors.completion.category.fg = xresources["*color7"]
c.colors.completion.even.bg = xresources["*color0"]
c.colors.completion.odd.bg = xresources["*color0"]
c.colors.completion.fg = xresources["*foreground"]
c.colors.completion.item.selected.bg = xresources["*fadeColor"]
c.colors.completion.item.selected.border.bottom = xresources["*fadeColor"]
c.colors.completion.item.selected.border.top = xresources["*fadeColor"]
c.colors.completion.item.selected.fg = xresources["*color15"]
c.colors.completion.match.fg = xresources["*color3"]
c.colors.completion.scrollbar.bg = xresources["*color0"]
c.colors.completion.scrollbar.fg = xresources["*color7"]
c.colors.downloads.bar.bg = xresources["*background"]
c.colors.downloads.error.bg = xresources["*color9"]
c.colors.downloads.error.fg = xresources["*color7"]
c.colors.downloads.stop.bg = xresources["*color13"]
c.colors.downloads.system.bg = 'none'
c.colors.hints.bg = xresources["*background"]
c.colors.hints.fg = xresources["*color7"]
c.colors.hints.match.fg = xresources["*color9"]
c.colors.keyhint.bg = xresources["*color0"]
c.colors.keyhint.fg = xresources["*color7"]
c.colors.keyhint.suffix.fg = xresources["*color3"]
c.colors.messages.error.bg = xresources["*color9"]
c.colors.messages.error.border = xresources["*color9"]
c.colors.messages.error.fg = xresources["*color7"]
c.colors.messages.info.bg = xresources["*color6"]
c.colors.messages.info.border = xresources["*color6"]
c.colors.messages.info.fg = xresources["*color7"]
c.colors.messages.warning.bg = xresources['*color1']
c.colors.messages.warning.border = xresources['*color1']
c.colors.messages.warning.fg = xresources["*color7"]
c.colors.prompts.bg = xresources["*background"]
c.colors.prompts.border = '1px solid ' + xresources["*background"]
c.colors.prompts.fg = xresources["*color7"]
c.colors.prompts.selected.bg = xresources["*fadeColor"]
c.colors.statusbar.caret.bg = xresources["*color13"]
c.colors.statusbar.caret.fg = xresources["*color7"]
c.colors.statusbar.caret.selection.bg = xresources["*color13"]
c.colors.statusbar.caret.selection.fg = xresources["*color7"]
c.colors.statusbar.command.bg = xresources["*background"]
c.colors.statusbar.command.fg = xresources["*color7"]
c.colors.statusbar.command.private.bg = xresources["*background"]
c.colors.statusbar.command.private.fg = xresources["*color7"]
c.colors.statusbar.insert.bg = xresources["*color10"]
c.colors.statusbar.insert.fg = xresources["*color0"]
c.colors.statusbar.normal.bg = xresources["*background"]
c.colors.statusbar.normal.fg = xresources["*color7"]
c.colors.statusbar.passthrough.bg = xresources["*background"]
c.colors.statusbar.passthrough.fg = xresources["*color7"]
c.colors.statusbar.private.bg = xresources["*fadeColor"]
c.colors.statusbar.private.fg = xresources["*color7"]
c.colors.statusbar.progress.bg = xresources["*color7"]
c.colors.statusbar.url.error.fg = xresources["*color9"]
c.colors.statusbar.url.fg = xresources["*color7"]
c.colors.statusbar.url.hover.fg = xresources["*color6"]
c.colors.statusbar.url.success.http.fg = xresources["*color7"]
c.colors.statusbar.url.success.https.fg = xresources["*color10"]
c.colors.statusbar.url.warn.fg = xresources['*color1']
c.colors.tabs.bar.bg = xresources["*background"]
c.colors.tabs.even.bg = xresources["*background"]
c.colors.tabs.even.fg = xresources["*color7"]
c.colors.tabs.indicator.error = xresources["*color9"]
c.colors.tabs.indicator.system = 'none'
c.colors.tabs.odd.bg = xresources["*background"]
c.colors.tabs.odd.fg = xresources["*color7"]
c.colors.tabs.selected.even.bg = xresources["*color8"]
c.colors.tabs.selected.even.fg = xresources["*color7"]
c.colors.tabs.selected.odd.bg = xresources["*color8"]
c.colors.tabs.selected.odd.fg = xresources["*color7"]
