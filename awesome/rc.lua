-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
wibox = require("wibox")
vicious = require("vicious")

-- Theme handling library
beautiful = require("beautiful")

-- Notification library
naughty = require("naughty")
menubar = require("menubar")


local awmodoro  = require("awmodoro")

--pomodoro wibox
pomowibox = awful.wibox({ position = "top", screen = 1, height=4})
pomowibox.visible = false
local pomodoro = awmodoro.new({
  minutes             = 25,
  do_notify           = true,
  active_bg_color     = '#313131',
  paused_bg_color     = '#7746D7',
  fg_color            = {type = "linear", from = {0,0}, to = {pomowibox.width, 0}, stops = {{0, "#AECF96"},{0.5, "#88A175"},{1, "#FF5656"}}},
  width               = pomowibox.width,
  height              = pomowibox.height, 

  begin_callback = function()
    for s = 1, screen.count() do
      mywibox[s].visible = false
    end
    pomowibox.visible = true
  end,

  finish_callback = function()
    for s = 1, screen.count() do
      mywibox[s].visible = true
    end
    pomowibox.visible = false
  end})
  pomowibox:set_widget(pomodoro)



  --{{---| Font |-----------------------------------------------------------------
  awesome.font = "Soruce Code Pro 10"



  --awful.util.spawn_with_shell("wmname LG3D")
  --{{---| Error handling |-------------------------------------------------------

  if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
  end

  do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
      if in_error then return end
      in_error = true
      naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = err })
      in_error = false
    end)
  end

  --{{---| Theme |------------------------------------------------------------------------------------

  config_dir = (".config/awesome/")
  themes_dir = (config_dir .. "/themes")
  beautiful.init(themes_dir .. "/powerarrow/theme.lua")
  if beautiful.wallpaper then
    gears.wallpaper.maximized(beautiful.wallpaper, 1, true)
  end

  --{{---| Variables |--------------------------------------------------------------------------------

  modkey         = "Mod4"
  terminal       = "urxvt"
  taskwarrior    = "urxvt -e vim -c TW"
  volume         = "urxvt -T 'vol' -hold -geometry 95x20-30+20 -e alsamixer"
  musicplr       = "urxvt -T 'music' -hold -geometry 90x20-30+20 -e ncmpcpp"
  wicdcurses     = "urxvt -T 'wireless' -geometry 90x20-20+20 -e wicd-curses"
  diskusage      = "urxvt -T 'disk usage' -hold -geometry 65x11-30+20 -e df"
  htop           = "urxvt -T 'processes' -hold -geometry 90x30-10+20 -e htop"
  calendar       = "urxvt -T 'calendar' -hold -geometry 21x9-5+20 -e cal"
  editor         = os.getenv("EDITOR") or "vim"
  editor_cmd     = terminal .. " -e " .. editor
  browser        = "firefox"
  mail           = "urxvt -e 'mutt'"
  altkey         = "Mod1"
  filesystem     = "urxvt -e 'ranger'"
  skylabs        = "urxvt -e 'skylabs'"
  goprogram      = "urxvt -e 'vimg'"
  graphics       = "inkscape"


  --{{---| Table of layouts |-------------------------------------------------------------------------

  layouts =
  {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top
  }

  --{{---| Tags |-------------------------------------------------------------------------------------

  tags = {}
  for s = 1, screen.count() do
    tags[s] = awful.tag({ "1:workon", "2:web", "3:terms", "4:web", "5:web", "6:refs", "7:terms", "8:irc", "9:mail"}, s, layouts[3])
  end

  ---------------------------------------------------------------------------------------------------
  --{{---| Solarized Colors|-------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------
  base03   = "#002b36"
  base02   = "#073642"
  base01   = "#586e75"
  base00   = "#657b83"
  base0    = "#839496"
  base1    = "#93a1a1"
  base2    = "#eee8d5"
  base3    = "#fdf6e3"
  yellow   = "#b58900"
  orange   = "#cb4b16"
  red      = "#dc322f"
  magenta  = "#d33682"
  violet   = "#6c71c4"
  blue     = "#268bd2"
  cyan     = "#2aa198"
  green    = "#859900"

  ---------------------------------------------------------------------------------------------------
  --{{---| WIDGETS |---------------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------

  --------------------------------------
  --{{-- |Powerline symbol variables |--
  larrow 		= "⮂"
  rarrow 		= "⮀"
  lthinsep 	= "⮃"
  rthinsep 	= "⮁"
  --------------------------------------
  --{{-- |Widget text icons |-----------
  musicicon 	= "♫"
  chargingicon 	= "⚡"
  battery_full 	= "♥"
  battery_notfull = "♡"
  weather 	= "☁"
  hdd 		= "⊚"
  cpu 		= "⊡"
  mem 		= "⌂"
  wifi            = "✲"

  --{{---| Volume |--------------------------------------------------------------------
  volwidget = wibox.widget.textbox()
  vicious.register(volwidget, vicious.widgets.volume, '<span background="'..base3..'" font="Source Code Pro 12"><span color="'..yellow..'"></span></span><span background="'..base03..'" font="Source Code Pro 12"><span font="Soruce Code Pro 10" color="'..base1..'">$2 $1% </span></span><span background="'..violet..'"><span color="'..blue..'" font="Soruce Code Pro 12"></span></span>', .5, "Master")
  volwidget:buttons(awful.util.table.join(awful.button({ }, 1,
  function () awful.util.spawn_with_shell(volume) end)))
  --{{---| Clock |---------------------------------------------------------------------
  clockwidget = wibox.widget.textbox()
  vicious.register(clockwidget, vicious.widgets.date, '<span background="'..base03..'" font="Soruce Code Pro 12" color="'..base01..'"></span><span background="'..base03..'" font="Soruce Code Pro 10" color="'..base1..'"> %b %d <span font="Mensh 12"></span> %R </span>', 60)
  clockwidget:buttons(awful.util.table.join(awful.button({ }, 1,
  function () awful.util.spawn_with_shell(calendar) end)))

  --{{---| CPU / sensors widget |---------------------------------------------------------------------

  cpuwidget = wibox.widget.textbox()
  cpuwidget.width, cpuwidget.align = 50, "right"
  vicious.register(cpuwidget, vicious.widgets.cpu,
  '<span background="'..base03..'" font="Soruce Code Pro 12"> <span font="Soruce Code Pro 10" color="'..base1..'"><span font="Soruce Code Pro 12">'..cpu..'</span> $2% <span color="'..base03..'">·</span> $3% <span color="'..orange..'" font="Soruce Code Pro 12"></span></span></span>', 5)

  cpuicon = wibox.widget.imagebox()
  cpuicon:set_image(beautiful.widget_cpu)

  --{{---| FS's widget / udisks-glue menu |-----------------------------------------------------------

  fsicon = wibox.widget.imagebox()
  fsicon:set_image(beautiful.widget_hdd)

  fswidget = wibox.widget.textbox()
  vicious.register(fswidget, vicious.widgets.fs,
  '<span background="'..orange..'" font="Soruce Code Pro 12"> <span font="Soruce Code Pro 10" color="'..base1..'"><span font="Soruce Code Pro 12">'..hdd..'</span> ${/home avail_gb}GB <span color="'..violet..'" font="Soruce Code Pro 12">'..larrow..'</span></span></span>', 8)
  fswidget:buttons(awful.util.table.join(awful.button({ }, 1,
  function () awful.util.spawn_with_shell(diskusage) end)))

  --{{---| Battery widget |---------------------------------------------------------------------------

  batwidget = wibox.widget.textbox()
  vicious.register(batwidget, vicious.widgets.bat, '<span background="'..base03..'" font="Soruce Code Pro 12"> <span font="Soruce Code Pro 10" color="'..base1..'">$1 $2% <span color="'..cyan..'" font="Soruce Code Pro 12"></span></span></span>', 5, 'BAT0')

  --{{---| MEM widget |-------------------------------------------------------------------------------

  memwidget = wibox.widget.textbox()
  vicious.register(memwidget, vicious.widgets.mem, '<span background="'..base03..'" font="Soruce Code Pro 12"> <span font="Soruce Code Pro 10" color="'..base1..'" background="'..base03..'"><span font="Soruce Code Pro 12">'..mem..'</span> $2MB </span></span>', 3)
  memwidget:buttons(awful.util.table.join(awful.button({ }, 1,
  function () awful.util.spawn_with_shell(htop) end)))
  --memicon = wibox.widget.imagebox()
  --memicon:set_image(beautiful.widget_mem)

  --{{---| Wibox |------------------------------------------------------------------------------------

  --mysystray = wibox.widget.systray()
  mywibox = {}
  mypromptbox = {}
  mylayoutbox = {}
  mytaglist = {}
  mytaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
  )
  mytasklist = {}
  mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function ()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width=450 })
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
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end


    right_layout:add(volwidget)
    right_layout:add(cpuwidget)
    right_layout:add(batwidget)

    -- memory
    right_layout:add(memwidget)
    right_layout:add(clockwidget)


    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
  end

  --{{---| Key bindings |-----------------------------------------------------------------------------

  globalkeys = awful.util.table.join(
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
  awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end end),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end end),
      awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
      awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
      awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
      awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
      awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
      awful.key({ modkey,           }, "Tab", function () awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end end),
        -- Awmodoro
        awful.key({ modkey, }, "F12", function () pomodoro:toggle() end),
        awful.key({ modkey, "Control" }, "F12", function () pomodoro:finish() end),


        --{{---| Hotkeys |--------------------------------------------------------------

        -- ALSA volume control
        awful.key({ altkey }, "Up",
        function ()
          awful.util.spawn("amixer -q set Master 1%+")
        end),
        awful.key({ altkey }, "Down",
        function ()
          awful.util.spawn("amixer -q set Master 1%-")
        end),
        awful.key({ altkey }, "m",
        function ()
          awful.util.spawn("amixer -q set Master playback toggle")
        end),
        awful.key({ altkey, "Control" }, "m",
        function ()
          awful.util.spawn("amixer -q set Master playback 100%")
        end),

        -- User programs
        awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
        awful.key({ modkey }, "e", function () awful.util.spawn(taskwarrior) end),
        awful.key({ modkey }, "t", function () awful.util.spawn(skylabs) end),
        awful.key({ modkey }, "w", function () awful.util.spawn(mail) end),
        awful.key({ modkey }, "i", function () awful.util.spawn(filesystem) end),
        awful.key({ modkey }, "g", function () awful.util.spawn(goprogram) end),
        awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
        awful.key({ modkey }, "x", function () awful.util.spawn('slimlock') end),



        --{{---| Terminals, shells und multiplexors |-----------------------------------
        --
        awful.key({ modkey,           }, "Return",   function () awful.util.spawn(terminal) end),                 --
        ----{{--------------------------------------------------------------------------
        awful.key({ modkey, "Control" }, "r",        awesome.restart),
        awful.key({ modkey, "Shift",     "Control"}, "r", awesome.quit),
        awful.key({ modkey, "Control" }, "n",        awful.client.restore),
        awful.key({ modkey },            "r",        function () mypromptbox[mouse.screen]:run() end),
        awful.key({ modkey,           }, "l",        function () awful.tag.incmwfact( 0.05)    end),
        awful.key({ modkey,           }, "h",        function () awful.tag.incmwfact(-0.05)    end),
        awful.key({ modkey, "Shift"   }, "h",        function () awful.tag.incnmaster( 1)      end),
        awful.key({ modkey, "Shift"   }, "l",        function () awful.tag.incnmaster(-1)      end),
        awful.key({ modkey, "Control" }, "h",        function () awful.tag.incncol( 1)         end),
        awful.key({ modkey, "Control" }, "l",        function () awful.tag.incncol(-1)         end),
        awful.key({ modkey,           }, "space",    function () awful.layout.inc(layouts,  1) end),
        awful.key({ modkey, "Shift"   }, "space",    function () awful.layout.inc(layouts, -1) end)
        )

        clientkeys = awful.util.table.join(
        awful.key({ modkey,           }, "f",        function (c) c.fullscreen = not c.fullscreen  end),
        awful.key({ modkey, "Shift"          }, "c",        function (c) c:kill()                         end),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
        awful.key({ modkey, "Control" }, "Return",   function (c) c:swap(awful.client.getmaster()) end),
        awful.key({ modkey,           }, "o",        awful.client.movetoscreen                        ),
        awful.key({ modkey, "Shift"   }, "r",        function (c) c:redraw()                       end),
        awful.key({ modkey,           }, "n",        function (c) c.minimized = true end),
        awful.key({ modkey,           }, "m",        function (c) c.maximized_horizontal = not c.maximized_horizontal
          c.maximized_vertical   = not c.maximized_vertical end)
          )

          keynumber = 0
          for s = 1, screen.count() do keynumber = math.min(9, math.max(#tags[s], keynumber))
          end

          for i = 1, keynumber do globalkeys = awful.util.table.join(globalkeys,
            awful.key({ modkey }, "#" .. i + 9, function () local screen = mouse.screen
              if tags[screen][i] then awful.tag.viewonly(tags[screen][i]) end end),
              awful.key({ modkey, "Control" }, "#" .. i + 9, function () local screen = mouse.screen
                if tags[screen][i] then awful.tag.viewtoggle(tags[screen][i]) end end),
                awful.key({ modkey, "Shift" }, "#" .. i + 9, function () if client.focus and
                  tags[client.focus.screen][i] then awful.client.movetotag(tags[client.focus.screen][i]) end end),
                  awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus and
                    tags[client.focus.screen][i] then awful.client.toggletag(tags[client.focus.screen][i]) end end)) end
                    clientbuttons = awful.util.table.join(
                    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                    awful.button({ modkey }, 1, awful.mouse.client.move),
                    awful.button({ modkey }, 3, awful.mouse.client.resize))

                    --{{---| Set keys |---------------------------------------------------------------------------------

                    root.keys(globalkeys)

                    --{{---| Rules |------------------------------------------------------------------------------------

                    awful.rules.rules = {
                      { rule = { },
                      properties = { size_hints_honor = false,
                      border_width = beautiful.border_width,
                      border_color = beautiful.border_normal,
                      focus = true,
                      keys = clientkeys,
                      buttons = clientbuttons } },
                      { rule = { class = "gimp" },
                      properties = { floating = true } },

                    }

                    --{{---| Signals |----------------------------------------------------------------------------------

                    client.connect_signal("manage", function (c, startup)
                      -- Add a titlebar
                      -- awful.titlebar.add(c, { modkey = modkey })
                      c:connect_signal("mouse::enter", function(c) if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                        and awful.client.focus.filter(c) then client.focus = c end end)
                        if not startup then if not c.size_hints.user_position and not c.size_hints.program_position then
                          awful.placement.no_overlap(c) awful.placement.no_offscreen(c) end end end)
                          client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
                          client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

                          --{{Xx----------------------------------------------------------------------------------------------
