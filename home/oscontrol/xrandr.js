"user strict"
const cp = require('child_process')

function checkMonitorState(name)
{
    return new Promise(resolve => cp.exec(
        `cat /sys/class/drm/card1-${name}/enabled`,
        (error, stdout, stderr) => stdout.trim() == 'enabled' ? resolve('ON') : resolve('OFF'))
    )
}

function setMonitorState(name, state, extra = '')
{
    return new Promise(resolve => state == 'OFF' ?
        cp.exec(`DISPLAY=:0 xrandr --output ${name} --off`, () => resolve()) :
        cp.exec(`DISPLAY=:0 xrandr --output ${name} --auto ${extra}`, () =>
            cp.exec('DISPLAY=:0 i3-msg restart', () => resolve())
        )
    )
    /* Wayland
    return new Promise(resolve => state == 'OFF' ?
        cp.exec(`swaymsg output ${name} disable`, () => resolve()) :
        cp.exec(`swaymsg output ${name} enable`, () =>
            cp.exec(`swaymsg reload`, () => resolve() )
        )
    )
    */
}

module.exports = {
    checkMonitorState,
    setMonitorState,
}
