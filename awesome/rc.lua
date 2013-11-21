-- print contents of a table, with keys sorted. second parameter is optional, used for indenting subtables
table.inspect = require 'inspect'

function dump(t,indent)
    local names = {}
    if not indent then indent = "" end
    for n,g in pairs(t) do
        table.insert(names,n)
    end
    table.sort(names)
    for i,n in pairs(names) do
        local v = t[n]
        if type(v) == "table" then
            if(v==t) then -- prevent endless loop if table contains reference to itself
                print(indent..tostring(n)..": <-")
            else
                print(indent..tostring(n)..":")
                dump(v,indent.."   ")
            end
        else
            if type(v) == "function" then
                print(indent..tostring(n).."()")
            else
                print(indent..tostring(n)..": "..tostring(v))
            end
        end
    end
end
-- Use this function to perform your initial setup
function setup()
    dump(_G) -- _G is the globals table in lua
end

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")        -- Theme handling library
require("naughty")          -- Notification library

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/igaray/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
home        = os.getenv("HOME")
terminal    = "urxvtc"
editor      = os.getenv("EDITOR") or "vim"
editor_cmd  = terminal .. " -e " .. editor

dzenwidth   = 210
screenwidth = screen[screen.count()].workarea.width
wibarwidth  = screenwidth - dzenwidth
wibarheight = 16

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{ awful.layout.suit.tile
, awful.layout.suit.tile.left
, awful.layout.suit.tile.bottom
, awful.layout.suit.tile.top
, awful.layout.suit.fair
, awful.layout.suit.fair.horizontal
, awful.layout.suit.spiral
, awful.layout.suit.spiral.dwindle
, awful.layout.suit.max.fullscreen
, awful.layout.suit.magnifier
, awful.layout.suit.floating
, awful.layout.suit.max
}
-- }}}

-- {{{ Tags
--theme.taglist_font = "DejaVu Sans 10"
--theme.taglist_font = "Inconsolata 10"
--theme.taglist_font = "Terminus 10"
  theme.taglist_font = "Elder Futhark 10"

-- Define a tag table which hold all screen tags.
--names  = { "♨", "⌨", "⚡", "✉", "☕", "❁", "☃", "☄", "⚢" }
--names  = { "☠", "⌥", "✇", "⌤", "⍜", "✣", "⌨", "⌘", "☕" }
--names  = { "☭", "⌥", "✇", "⌤", "☼", "⌘", "⌨", "⌘", "☕" }
  names  = { "a", "b", "c", "e", "f", "p", "r", "s", "t" }
--names  = { "α", "δ", "ε", "θ", "λ", "μ", "π", "τ", "ψ" }
--names  = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
--names  = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }

tags     = {}
for screen = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[screen] = awful.tag(names, screen, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = 
{ { "manual",  terminal .. " -e man awesome"                                        }
, { "help",    terminal .. " -e less /home/igaray/.config/awesome/awesome.keys.txt" }
, { "config",  editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"        }
, { "restart", awesome.restart                                                      }
, { "quit",    awesome.quit                                                         }
}

musicmenu = 
{ { "ncmpcpp",   terminal .. " -e " .. "ncmpcpp" }
, { "grip",      "grip"                          }
, { "kid3",      "kid3"                          }
}

internetmenu = 
{ { "weechat",      terminal .. " -e " .. "weechat-curses"  }
, { "skype",        "skype"                                 }
, { "torrent",      "transmission-gtk"                      }
, { "thunder",      "thunderbird"                           }
, { "firefox",      "firefox"                               }
, { "chromium",     "chromium"                              }
}

sublime2_cmd = "/home/igaray/bin/sublime_text/sublime_text"
sublime3_cmd = "/home/igaray/bin/sublime_text_3/sublime_text"
othermenu = 
{ { "xmind",     "XMind"                    }
, { "dia",       "dia"                      }
, { "office",    "libreoffice"              }
, { "pyrenamer", "pyrenamer"                }
, { "thunar",    "thunar"                   }
, { "st2",       sublime2_cmd               }
, { "st3",       sublime3_cmd               }
, { "wiki",      "uzbl-browser 127.0.0.1"   }
}

mymainmenu = awful.menu(
    { items = 
        { { "awesome",   myawesomemenu          }
        , { "music",     musicmenu              }
        , { "internet",  internetmenu           }
        , { "other",     othermenu              }
        , { "mc",        terminal .. " -e mc"   }
        , { "htop",      terminal .. " -e htop" }
        , { "tmux",      terminal .. " -e tmux" }
        }
    })

mylauncher = awful.widget.launcher(
    { image = image(beautiful.awesome_icon)
    , menu  = mymainmenu 
    })
-- }}}

-- {{{ Wibox
-- Create a textclock widget

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox     = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist   = {}
mytasklist  = {}

mytaglist.buttons = awful.util.table.join(
                    awful.button({        }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({        }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({        }, 4, awful.tag.viewnext),
                    awful.button({        }, 5, awful.tag.viewprev)
                    )
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = wibarheight })

    -- Add widgets to the wibox - order matters
    mywibox[s].width = wibarwidth
    mywibox[s].widgets = 
        { { 
            mylayoutbox[s]
          , mytaglist[s]
          , mypromptbox[s]
          , layout = awful.widget.layout.horizontal.leftright
          }
        , s == 1 and mysystray or nil
        , mytasklist[s]
        , layout = awful.widget.layout.horizontal.rightleft
        }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ conky | dzen status bar
-- dzen accepts a couple of options:
--    -fg     foreground color
--    -bg     background color
--    -fn     font 
--    -ta     alignement of title window content 
--            l(eft), c(center), r(ight)
--    -tw     title window width
--    -sa     alignment of slave window, see "-ta"
--    -l      lines, see (1)
--    -e      events and actions, see (2)
--    -m      menu mode, see (3)
--    -u      update contents of title and 
--            slave window simultaneously, see (4)
--    -p      persist EOF (optional timeout in seconds)
--    -x      x position
--    -y      y position
--    -h      line height (default: fontheight + 2 pixels)
--    -w      width
--    -xs     number of Xinerama screen
--    -v      version information
function getResolution()
    res_height = 0
    res_width = 0
    for s = 1, screen.count() do
        res_height = math.max(res_height, screen[s].workarea.height)
        res_width = res_width + screen[s].workarea.width
    end
    return res_width .. "x" .. res_height
end

dzencommand = "killall conky; killall dzen2; (conky | dzen2 -x $(echo $(xrandr | grep current | cut -d ' ' -f 8) '-' " .. dzenwidth .. " | bc) -e '' -fg '#FFFFFF' -bg '#000000' -h '16' -w " .. dzenwidth .. " -ta r -sa r -fn '-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-1' -p)"
awful.util.spawn_with_shell(dzencommand)
-- }}}

-- {{{ Startup programs
function run_once(prg,arg_string,screen)
    if not prg then
        do return nil end
    end
    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("urxvtd","-q -o -f")
run_once("mpd")
run_once("dropboxd")
-- }}}
