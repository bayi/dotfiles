"user strict"
const cp = require('child_process')

function checkProcessState(name)
{
    return new Promise(
        resolve => cp.exec(`pgrep -x "${name}"`, (error, stdout, stderr) => { !stdout.trim() ? resolve('OFF') : resolve('ON') })
    )
}

function setProcessState(state, name, onCommand = undefined)
{
    onCommand = onCommand ? onCommand : `DISPLAY=:0 nohup ${name} </dev/null 1>/dev/null 2>/dev/null & disown`
    spawnOptions = { detached: true, stdio: [ 'ignore', 'ignore', 'ignore' ]}
    return new Promise(resolve => {
        state == 'ON' ? 
            cp.spawn('/bin/sh', [ '-c', onCommand ], spawnOptions) :
            cp.spawn('/bin/sh', [ '-c', `pkill ${name}` ], spawnOptions)
        resolve()
        }
    )
}

module.exports = {
    checkProcessState,
    setProcessState,
}