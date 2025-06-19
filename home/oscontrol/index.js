"use strict"
const config        = require('./config')
const MqttSwitch    = require('./switch')
const systemd     = require('./systemd')
const shell       = require('./shell')
const MqttButton = require('./button')

console.log(`* Starting oscontrol for: ${config.entityName} : ${config.uniqueId}`)

let monitor_sides_state = 'ON'
let monitor3_state = 'ON'

const monitor_sides = new MqttSwitch(
    'monitor_sides',
    () => monitor_sides_state,
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

const sleep = new MqttButton(
    'sleep',
    () => shell.exceCommand(['hyprctl dispatch dpms off']),
    { icon: 'mdi:sleep'}
)

function update()
{
    return new Promise(resolve => {
        monitor_sides.update()
        sleep.update()
        return resolve()
    })
}

update()
setInterval(update, config.timeIntervalSec * 1000)
