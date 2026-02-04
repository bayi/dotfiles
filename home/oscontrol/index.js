"use strict"
const config        = require('./config')
const MqttSwitch    = require('./switch')
const systemd     = require('./systemd')
const shell       = require('./shell')
const MqttButton = require('./button')

const sleep = ms => new Promise(resolve => setTimeout(resolve, ms))

if (process.env.MQTT_HOST === undefined) {
    console.log('* MQTT_HOST environment variable is not set. Sleeping ...')
    const sleep = ms => new Promise(resolve => setTimeout(resolve, ms))
    setInterval(sleep, config.timeIntervalSec * 1000)
} else {

    console.log(`* Starting oscontrol for: ${config.entityName} : ${config.uniqueId}`)

    let monitor_sides_state = 'ON'
    let monitor3_state = 'ON'

    const monitor_sides = new MqttSwitch(
        'monitor_sides',
        () => monitor_sides_state,
        async(state) => {
            if (state == 'ON') {
                shell.exceCommand(['hyprctl keyword monitor "HDMI-A-2,disable"'])
                await sleep(250)
                shell.exceCommand(['hyprctl keyword monitor "DP-3,2560x1440,0x0,1"'])
                await sleep(250)
                shell.exceCommand(['hyprctl keyword monitor "DP-2,2560x1440,5120x0,1"'])
                await sleep(250)
                shell.exceCommand(['hyprctl keyword monitor "HDMI-A-2,2560x1440,2560x0,1"'])
                await sleep(250)
                shell.exceCommand(['systemctl --user restart waybar'])
                shell.exceCommand(['systemctl --user restart mako'])
                shell.exceCommand(['systemctl --user restart hyprpaper'])
                monitor_sides_state = 'ON'
            } else {
                shell.exceCommand(['hyprctl keyword monitor "DP-3,disable"'])
                shell.exceCommand(['hyprctl keyword monitor "DP-2,disable"'])
                await sleep(250)
                shell.exceCommand(['hyprctl keyword monitor "HDMI-A-2,2560x1440,0x0,1"'])
                shell.exceCommand(['systemctl --user restart waybar'])
                shell.exceCommand(['systemctl --user restart mako'])
                shell.exceCommand(['systemctl --user restart hyprpaper'])
                monitor_sides_state = 'OFF'
            }
        },
        { icon: 'mdi:monitor'}
    )

    const sleepButton = new MqttButton(
        'sleep',
        () => shell.exceCommand(['hyprctl dispatch dpms off']),
        { icon: 'mdi:sleep'}
    )

    function update()
    {
        return new Promise(resolve => {
            monitor_sides.update()
            sleepButton.update()
            return resolve()
        })
    }

    update()
    setInterval(update, config.timeIntervalSec * 1000)

}
