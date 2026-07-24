-- Hyprland Lua config (migrated from hyprland.conf)
-- https://wiki.hypr.land/Configuring/Start/

require("monitors")


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local mainMod     = "ALT" -- was $mainMod = ALT


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- System services and daemons
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Startup apps
    hl.exec_cmd(terminal, { workspace = "1" })

    -- Special workspace apps
    hl.exec_cmd("spotify",   { workspace = "special:spotify silent" })
    hl.exec_cmd("dolphin",   { workspace = "special:files silent" })
    hl.exec_cmd("discord",   { workspace = "special:discord silent" })
    hl.exec_cmd("keepassxc", { workspace = "special:keepass silent" })
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 0.95,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        vrr                     = 1,
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "us,latam",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Curves
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },  { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },     { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },  { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


---------------
---- INPUT ----
---------------

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


----------------------------
---- WINDOW RULES ----------
----------------------------

hl.window_rule({
    name      = "spotify-special",
    match     = { title = "Spotify" },
    workspace = "special:spotify",
})

hl.window_rule({
    name      = "whatsapp-special",
    match     = { title = "WhatsApp Web" },
    workspace = "special:whatsapp",
})

hl.window_rule({
    name      = "obs-special",
    match     = { class = "com.obsproject.Studio" },
    workspace = "special:obs",
})

hl.window_rule({
    name      = "mail-special",
    match     = { title = "Gmail" },
    workspace = "special:mail",
})

hl.window_rule({
    name      = "keepass-special",
    match     = { class = "org.keepassxc.KeePassXC" },
    workspace = "special:keepass",
})

hl.window_rule({
    name      = "xournal-special",
    match     = { class = "com.github.xoarnalp" },
    workspace = "special:xournal",
})

hl.window_rule({
    name      = "files-special",
    match     = { class = "org.kde.dolphin" },
    workspace = "special:files",
})

hl.window_rule({
    name      = "discord-special",
    match     = { class = "discord" },
    workspace = "special:discord",
})


---------------------
---- KEYBINDINGS ----
---------------------

-- Application launchers
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",             hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=KDE " .. fileManager))
hl.bind(mainMod .. " + SPACE",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + b",             hl.dsp.exec_cmd("~/.config/hypr/scripts/brave-unless-editing.sh"))
hl.bind(mainMod .. " + SHIFT + p",     hl.dsp.exec_cmd("~/.config/rofi/rofi-power.sh"))
hl.bind(mainMod .. " + p",             hl.dsp.exec_cmd("hyprpicker -a"))

-- Window management
hl.bind(mainMod .. " + Q",             hl.dsp.window.close())
hl.bind("CTRL + " .. mainMod .. " + Q", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + F10",           hl.dsp.exec_cmd("swaync-client -d -sw && sleep 0.1 && swaync-client -t -sw"), { description = "Toggle DND" })
hl.bind("F11",                         hl.dsp.window.fullscreen())

-- Focus movement (SUPER_L + hjkl)
hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))

-- Workspace navigation / move window (movetoworkspace follows by default)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspaces
hl.bind(mainMod .. " + SHIFT + a", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.workspace.toggle_special("whatsapp"))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.workspace.toggle_special("keepass"))
hl.bind(mainMod .. " + SHIFT + b", hl.dsp.workspace.toggle_special("obs"))
hl.bind(mainMod .. " + SHIFT + m", hl.dsp.workspace.toggle_special("mail"))
hl.bind(mainMod .. " + SHIFT + d", hl.dsp.workspace.toggle_special("xournal"))
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.workspace.toggle_special("files"))
hl.bind(mainMod .. " + SHIFT + g", hl.dsp.workspace.toggle_special("discord"))

-- OS-X like shortcuts (clipboard & edit)
-- send_shortcut / release binds often leave synthetic keys stuck ("ssss…").
-- Omarchy workaround: down now, up via oneshot timer.
-- https://github.com/hyprwm/Hyprland/discussions/14099
local active = "activewindow"
local function send_once(mods, key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({
            mods = mods,
            key = key,
            state = "down",
            window = active,
        }))
        hl.timer(function()
            hl.dispatch(hl.dsp.send_key_state({
                mods = mods,
                key = key,
                state = "up",
                window = active,
            }))
        end, { timeout = 50, type = "oneshot" })
    end
end

local function bind_send(combo, mods, key, opts)
    hl.bind(combo, send_once(mods, key), opts)
end

bind_send(mainMod .. " + C",         "CTRL",       "C")
bind_send(mainMod .. " + V",         "CTRL",       "V")
bind_send(mainMod .. " + SHIFT + V", "CTRL SHIFT", "V")
bind_send(mainMod .. " + X",         "CTRL",       "X")
bind_send(mainMod .. " + A",         "CTRL",       "A")
bind_send(mainMod .. " + Z",         "CTRL",       "Z")
bind_send(mainMod .. " + S",         "CTRL",       "S")
bind_send(mainMod .. " + O",         "CTRL",       "O")
bind_send(mainMod .. " + SHIFT + O", "CTRL SHIFT", "O")
bind_send(mainMod .. " + N",         "CTRL",       "N")
bind_send(mainMod .. " + W",         "CTRL",       "W")
bind_send(mainMod .. " + F",         "CTRL",       "F")
bind_send(mainMod .. " + K",         "CTRL",       "K")
bind_send(mainMod .. " + T",         "CTRL",       "T")
bind_send(mainMod .. " + R",         "CTRL",       "R")
bind_send(mainMod .. " + SHIFT + R", "CTRL SHIFT", "R")
bind_send(mainMod .. " + U",         "CTRL",       "U")
bind_send(mainMod .. " + Y",         "CTRL",       "Y")
-- bind key is "return" (xkb); old conf used "enter" for both
bind_send(mainMod .. " + return",    "CTRL",       "return")
bind_send(mainMod .. " + SHIFT + T", "CTRL SHIFT", "T")
bind_send(mainMod .. " + L",         "CTRL",       "L")
bind_send(mainMod .. " + backspace", "CTRL SHIFT", "backspace")
bind_send("SUPER + backspace",       "CTRL",       "backspace")

-- Text formatting
bind_send(mainMod .. " + I",         "CTRL",       "I")
bind_send(mainMod .. " + SHIFT + X", "CTRL SHIFT", "X")
bind_send(mainMod .. " + comma",     "CTRL",       "comma")
bind_send(mainMod .. " + period",    "CTRL",       "period")
bind_send(mainMod .. " + backslash", "CTRL",       "backslash")
bind_send(mainMod .. " + SHIFT + 8", "CTRL SHIFT", "8")
bind_send(mainMod .. " + SHIFT + 7", "CTRL SHIFT", "7")

-- Tab navigation (bindel)
-- Trigger holds SHIFT, so keysym lookup happens with SHIFT active; on this
-- layout Shift+Tab resolves to ISO_Left_Tab, not Tab, hence "key not found"
-- when using "tab". https://github.com/hyprwm/Hyprland/pull/15401
bind_send(mainMod .. " + SHIFT + bracketleft",  "CTRL SHIFT", "ISO_Left_Tab", { locked = true, repeating = true })
bind_send(mainMod .. " + SHIFT + bracketright", "CTRL",       "ISO_Left_Tab", { locked = true, repeating = true })

-- Arrow / text navigation
bind_send("SUPER + left",            "CTRL",       "left")
bind_send("SUPER + right",           "CTRL",       "right")
bind_send("SHIFT + SUPER + left",    "CTRL SHIFT", "left")
bind_send("SHIFT + SUPER + right",   "CTRL SHIFT", "right")
bind_send(mainMod .. " + up",        "CTRL",       "up")
bind_send(mainMod .. " + down",      "CTRL",       "down")
bind_send(mainMod .. " + left",      "",           "HOME")
bind_send(mainMod .. " + right",     "",           "END")

-- Selection shortcuts (same keys as in original conf — both binds fire)
bind_send(mainMod .. " + SHIFT + left",  "SHIFT",      "home")
bind_send(mainMod .. " + SHIFT + right", "SHIFT",      "end")
bind_send(mainMod .. " + SHIFT + left",  "CTRL SHIFT", "left")
bind_send(mainMod .. " + SHIFT + right", "CTRL SHIFT", "right")
bind_send(mainMod .. " + SHIFT + up",    "CTRL SHIFT", "up")
bind_send(mainMod .. " + SHIFT + down",  "CTRL SHIFT", "down")

-- Mouse bindings
bind_send(mainMod .. " + mouse:272", "CTRL", "mouse:272")

-- Media keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshots
hl.bind("PRINT",         hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/screenshots"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard"))
