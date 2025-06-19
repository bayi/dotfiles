"use strict"
const config        = require('./config')
const MqttSwitch    = require('./switch')
// const xrandr        = require('./xrandr')
// const process       = require('./process')
const systemd     = require('./systemd')
const shell       = require('./shell')
const MqttButton = require('./button')

console.log(`* Starting oscontrol for: ${config.entityName} : ${config.uniqueId}`)

let monitor_sides_state = 'ON'
let monitor3_state = 'ON'

const monitor_sides = new MqttSwitch(
    'monitor_sides',
    // () => xrandr.checkMonitorState('VGA-1'),
    () => monitor_sides_state,
    // (state) => xrandr.setMonitorState('VGA1', state, '--left-of HDMI2'),
    (state) => {
        if (state == 'ON') {
            shell.exceCommand(['hyprctl keyword monitor "DP-2,2560x1440,5120x0,1"'])
            shell.exceCommand(['hyprctl keyword monitor "DP-3,2560x1440,0x0,1"'])
            monitor_sides_state = 'ON'
        } else {
            shell.exceCommand(['hyprctl keyword monitor "DP-2,disable"'])
            shell.exceCommand(['hyprctl keyword monitor "DP-3,disable"'])
            monitor_sides_state = 'OFF'
        }
    },
    { icon: 'mdi:monitor'}
)

/*
const win = new MqttSwitch(
    'windows',
    () => systemd.checkState('virtctl@windows', true),
    (state) => {
        systemd.setState(state, 'virtctl@windows', true)
        // if (state == 'OFF') systemd.setState('ON', 'default.target')
        // else systemd.setState('ON', 'win.target')
    },
    { icon: 'mdi:microsoft-windows'}
)
*/

/*
const kodi = new MqttSwitch(
    'kodi',
    () => systemd.checkState('kodi.service'),
    (state) => {
        systemd.setState(state, 'kodi.service')
    },
    { icon: 'mdi:kodi'}
)
*/

const sleep = new MqttButton(
    'sleep',
    // () => shell.exceCommand(['dbus-send --session --dest=org.gnome.ScreenSaver --type=method_call /org/gnome/ScreenSaver org.gnome.ScreenSaver.SetActive boolean:true']),
    // () => shell.exceCommand(['xset dpms force off']),
    () => shell.exceCommand(['hyprctl dispatch dpms off']),
    { icon: 'mdi:sleep'}
)

/*
const browser = new MqttSwitch(
    'firefox',
    () => process.checkProcessState('firefox'),
    (state) => process.setProcessState(state, 'firefox'),
    { icon: 'mdi:firefox' }
)
*/

function update()
{
    return new Promise(resolve => {
        monitor_sides.update()
        // browser.update()
        // win.update()
        // kodi.update()
        sleep.update()
        return resolve()
    })
}

update()
setInterval(update, config.timeIntervalSec * 1000)
