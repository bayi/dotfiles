"user strict"
const cp = require('child_process')

function exceCommand(cmd, root = false)
{
    const spawnOptions = { detached: true, stdio: [ 'ignore', 'ignore', 'ignore' ]}
    return new Promise(resolve => {
        if (root)
            cp.spawn('/usr/bin/sudo', cmd, spawnOptions) 
        else
            cp.spawn(`/usr/bin/sh`, [ '-c', ...cmd], spawnOptions) 
        resolve()
    })
}

module.exports = {
    exceCommand,
}
