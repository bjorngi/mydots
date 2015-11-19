# Note that since qtile configs are just python scripts, you can check for
# syntax and runtime errors by just running this file as is from the command
# line, e.g.:
#
# python config.py

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
#from libqtile.widget.ping import Ping
#from libqtile.widget.wlan import Wlan
import subprocess,re,glob,os,random
import multiprocessing as mp

# The screens variable contains information about what bars are drawn where on
# each screen. If you have multiple screens, you'll need to construct multiple
# Screen objects, each with whatever widgets you want.
#
# Below is a screen with a top bar that contains several basic qtile widgets.
screens = [Screen(top = bar.Bar([
        # This is a list of our virtual desktops.
        widget.GroupBox(urgent_alert_method='text', fontsize=11, this_current_screen_border='7b5830'),
        widget.sep.Sep(foreground='7b5830'), #add separator bars where deemed necessary

        # A prompt for spawning processes or switching groups. This will be
        # invisible most of the time.
        widget.Prompt(fontsize=10),

        # Current window name.
        widget.Battery(
            energy_now_file='charge_now',
            energy_full_file='charge_full',
            power_now_file='current_now',
            update_delay = 5,
            foreground = "7070ff",),
        widget.sep.Sep(foreground='7b5830'),
        widget.windowtabs.WindowTabs(),
        widget.CurrentLayout(foreground='7b5830'),
        widget.sep.Sep(foreground='7b5830'),
        #NetworkStatus(theme_path='/home/deewakar/.config/qtile/icons/'),
        widget.Volume(theme_path='/usr/share/icons/AwOkenWhite/clear/24x24/status/'),
        widget.Backlight(foreground="ff3300"),
        widget.sep.Sep(foreground='7b5830'),
        widget.Systray(),
        #widget.Clock('%H:%M', foreground='00ff00'),
        widget.sep.Sep(foreground='7b5830'),
        #Ping(word='ping',foreground="7070ff"),
        #Ping(word='mem',foreground="7070ff"),
        #Ping(word='cpu',foreground="7070ff"),
        widget.sep.Sep(foreground='7b5830'),
        #Wlan(foreground="ff3300")
    ], 22, opacity=0.1)),

    Screen(top = bar.Bar([
        widget.GroupBox(urgent_alert_method='text', fontsize=11, this_current_screen_border='7b5830'),
        widget.sep.Sep(foreground='7b5830'), #add separator bars where deemed necessary
        widget.Prompt(fontsize=10),
        widget.windowtabs.WindowTabs(),
        widget.CurrentLayout(foreground='7b5830'),
        widget.sep.Sep(foreground='7b5830'),
        widget.Systray(),
        #widget.Clock('%H:%M', foreground='00ff00'),
    ], 22, opcacity=0.1)) ]

# Super_L (the Windows key) is typically bound to mod4 by default, so we use
# that here.
mod = "mod4"
terminal = "urxvt"
home = os.path.expanduser("~")


# The keys variable contains a list of all of the keybindings that qtile will
# look through each time there is a key pressed.
keys = [
    # Log out; note that this doesn't use mod4: that's intentional in case mod4
    # gets hosed (which happens if you unplug and replug your usb keyboard
    # sometimes, or on system upgrades). This way you can still log back out
    # and in gracefully.
    Key(["shift", "mod1"], "q", lazy.shutdown()),
    Key(["shift", "mod1"], 'r', lazy.restart()),

    # toggle between windows just like in unity with 'alt+tab'
    Key(["mod1","shift"], "Tab", lazy.layout.down()),
    Key(["mod1"], "Tab", lazy.layout.up()),

    Key([mod], "h", lazy.layout.previous().when('tile'),lazy.layout.up().when('xmonad-tall')),
    Key([mod], "l", lazy.layout.previous()),

    # swap tile positions,(works only on tiles)
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    Key([mod, "shift"], "Return",lazy.layout.toggle_split()),

    # change the layout
    Key([mod], "space", lazy.nextlayout()),

    # quit the program "qtile way"
    Key([mod], "c", lazy.window.kill()),

    # move to the adjacent screen
    Key([mod], "Left", lazy.screen.prevgroup()),
    Key([mod], "Right", lazy.screen.nextgroup()),

    # interact with prompts
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "g", lazy.switchgroup()),

    # start specific apps
    Key([mod], "q", lazy.spawn("firefox")),

    Key([mod], "Return", lazy.spawn(terminal)),
    #Key([mod,'shift'], "Return", lazy.spawn(terminal+" -x mosh syrric")),
    #Key([mod,'control'], "Return", lazy.spawn(terminal+"-x ssh drift2")),
    #Key(['mod1'], "Return", lazy.spawn(terminal+" -x mosh flash")),
    #Key([mod], "1", lazy.spawn("uzbl-tabbed")),
    #Key([mod], "2", lazy.spawn("firefox")),
    #Key(["control", "mod1"],"t", lazy.spawn("mate-terminal")),
    #Key([mod], "3", lazy.spawn("vlc")),
    #Key([mod], "4", lazy.spawn("evince")),
    #Key([mod], "5", lazy.spawn("idle-python2.7")),
    #Key([mod], "6", lazy.spawn("emacs")),
    #Key([mod], "7", lazy.spawn("wine /mnt/windows/Program Files/utorrent/utorrent.exe")),
    #Key([mod], "8", lazy.spawn("radiotray")),

    Key([], "XF86MonBrightnessUp", lazy.spawn('xbacklight -inc 10')),
    Key([], "XF86MonBrightnessDown",lazy.spawn('xbacklight -dec 10')),


    # Change the volume if your keyboard has special volume keys.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),

    # Also allow changing volume the old fashioned way.
    Key([mod], "equal", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([mod], "minus", lazy.spawn("amixer -c 0 -q set Master 2dB-")),

    # for Monadtall layout
    Key([mod], "q", lazy.layout.grow()),
    Key([mod], "w", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "f", lazy.layout.flip()),

    # for Tile layout
    Key([mod, "shift"], "i", lazy.layout.increase_ratio()),
    Key([mod, "shift"], "d", lazy.layout.decrease_ratio()),
]


# This allows you to drag windows around with the mouse if you want.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Next, we specify group names, and use the group name list to generate an appropriate
# set of bindings for group switching.
groups = []
for i in ["1", "2", "3", "4", "5", "6", "7", "8"]:
    groups.append(Group(i))
    # add some more key bindigns
    # go to a specific screen
    keys.append(
        Key([mod], i, lazy.group[i].toscreen())
    )
    # take the current window to a specific screen
    keys.append(
        Key(["control", "mod1"], i, lazy.window.togroup(i))
    )

# layout instances
# I've not included 'Tile' and 'RatioTile',
# they didn't appeal to me much.
layouts = [
    layout.Max(),
    #layout.Stack(stacks=2, border_width=1),
    layout.xmonad.MonadTall(ratio=0.50),

    # splits screen into equal parts
    # ideal for four splitted windows in each corner
    layout.Tile(ratio=0.50, masterWindows=2),
    # a layout just for gimp
    layout.Slice('left', 192, name='gimp', role='gimp-toolbox',
         fallback=layout.Slice('right', 256, role='gimp-dock',
         fallback=layout.Stack(stacks=1, border_width=1))),
    #other useful layouts
    #layout.TreeTab(),
    #layout.zoomy.Zoomy(),
]

# Automatically float these types. This overrides the default behavior (which
# is to also float utility types), but the default behavior breaks our fancy
# gimp slice layout specified later on.
floating_layout = layout.Floating(auto_float_types=[
  "notification",
  "toolbar",
  "splash",
  "dialog",
])

# vim: tabstop=4 shiftwidth=4 expandtab
@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True

@hook.subscribe.client_new
def idle_dialogues(window):
    if((window.window.get_name() == 'Search Dialog') or
      (window.window.get_name() == 'Module') or
      (window.window.get_name() == 'Goto') or
      (window.window.get_name() == 'IDLE Preferences')):
        window.floating = True


def is_running(process):
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
        return False

def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())

#def rand_backround():
#  files = glob.glob(home+"/backrounds/*")
#  return files[random.randint(0,len(files)-1)]

@hook.subscribe.startup
def autostart():
    pass    
    #execute_once('feh --bg-fill %s'%(rand_backround()))
    #os.chdir(home)

