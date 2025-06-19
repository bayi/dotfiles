"user strict"
const cp = require('child_process')

function checkState(unit, root = false)
{
    return new Promise(
        resolve => cp.exec(`/usr/bin/systemctl ${root ? '' : '--user'} is-active --quiet ${unit}`).on('exit', code => resolve(code == 0 ? 'ON' : 'OFF'))
    )
}

function setState(state, unit, root = false)
{
    const spawnOptions = { detached: true, stdio: [ 'ignore', 'ignore', 'ignore' ]}
    return new Promise(resolve => {
        if (root)
            cp.spawn('/usr/bin/sudo', [ '/usr/bin/systemctl', state == 'ON' ? 'start' : 'stop', unit ], spawnOptions) 
        else
            cp.spawn(`/usr/bin/systemctl`, ['--user', state == 'ON' ? 'start' : 'stop', unit ], spawnOptions) 
        resolve()
    })
}

module.exports = {
    checkState,
    setState,
}