import subprocess
from pathlib import Path

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
c.content.pdfjs = True
c.tabs.padding = {"top": 5, "bottom": 5, "left": 0, "right": 0}
c.fonts.monospace = 'Hack'
c.fonts.tabs = '10pt monospace'
c.editor.command = ['st', '-e', 'vi', '-f', '{file}', '-c', 'normal {line}G{column0}l'];
c.url.default_page = 'http://127.0.0.1:1234/startpage'
c.url.start_pages = 'http://127.0.0.1:1234/startpage'

home = str(Path.home())

c.url.searchengines = {
  "DEFAULT": "https://duckduckgo.com/?q={}",
  "s": 'https://stash.int.openbet.com/plugins/servlet/search?q="{}"',
  "j": 'https://jira.openbet.com/issues/?jql=text~"{}"'
}

proxies = [
  "http://bop.ps.gameop.net:8080",
  "http://custproxy.openbet:8080"
]

allowed_content = [
  "*://meet.google.com/*",
  "*://hangouts.google.com/*",
  "*://bluejeans.com/*"
]

trusted_SSL = [
  "*://*sportsbook.sgdigital.com/*"
]

def read_xresources(prefix):
  props = {}
  x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
  lines = x.stdout.decode().split('\n')
  for line in filter(lambda l : l.startswith(prefix), lines):
    prop, _, value = line.partition(':\t')
    props[prop] = value
  return props

def allow_media(p):
  with config.pattern(p) as p:
    p.content.media_capture = True

def disable_SSL(p):
  with config.pattern(p) as p:
    p.content.ssl_trusted = False

def exec_userscript(com):
  return 'spawn --userscript {}/.local/bin/dotctl.sh {}'.format(home, com)

xresources = read_xresources('*')

config.bind('<Ctrl-Shift-y>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-p>', 'config-cycle -p content.proxy system {}'.format(" ".join(proxies)))
config.bind('<Ctrl-e>',       exec_userscript('qute-textedit'))
config.bind('<Ctrl-Shift-e>', exec_userscript('qute-screenedit'))
config.bind('<Ctrl-Alt-c>',   exec_userscript('qute-copy'))
config.bind('<Ctrl-Shift-c>', exec_userscript('qute-select-copy'))
config.bind('<Ctrl-Shift-u>', exec_userscript('qute-url'))
config.bind('<Ctrl-Shift-g>', exec_userscript('qute-clone'))
config.bind('<Ctrl-Shift-t>', exec_userscript('qute-tokens'))
config.bind('<Ctrl-Shift-j>', exec_userscript('qute-jira'))
config.bind('<Shift+Ins>', 'insert-text {primary}', mode='insert')
config.bind('<Ctrl+Ins>', 'insert-text {clipboard}', mode='insert')
config.bind('<Ctrl-i>', 'open-editor', mode='insert')

map(allow_media, allowed_content)
map(disable_SSL, trusted_SSL)

config.source('nord-qutebrowser.py')

c.colors.tabs.bar.bg = xresources["*background"]
c.colors.tabs.even.bg = xresources["*background"]
c.colors.tabs.even.fg = xresources["*text"]
c.colors.tabs.odd.bg = xresources["*background"]
c.colors.tabs.odd.fg = xresources["*text"]
c.colors.tabs.selected.even.bg = xresources["*color8"]
c.colors.tabs.selected.even.fg = xresources["*text"]
c.colors.tabs.selected.odd.bg = xresources["*color8"]
c.colors.tabs.selected.odd.fg = xresources["*text"]
c.hints.chars = "asdfkl"
c.hints.border = "1px solid " + xresources["*background"]
c.colors.hints.bg = xresources["*background"]
c.colors.hints.fg = xresources["*text"]
c.colors.hints.match.fg = xresources["*color9"]
