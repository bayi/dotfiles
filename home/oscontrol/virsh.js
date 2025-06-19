"user strict"
const cp = require('child_process')

function checkState(name)
{
    return new Promise(
        resolve => cp.exec(`sudo virsh list --state-running | grep ${name}`, (error, stdout, stderr) => { !stdout.trim() ? resolve('OFF') : resolve('ON') })
    )
}

function setState(state, name)
{
    return new Promise(resolve => state == 'ON' ? 
            cp.exec(`sudo virsh start ${name}`, () => resolve()) :
            cp.exec(`sudo virsh shutdown ${name}`, () => resolve())
    )
}

module.exports = {
    checkState,
    setState,
}