"use strict"
const os                    = require('os')
const machineId             = require('node-machine-id')
const entityName            = `host-${process.env.HOSTNAME || os.hostname()}`

module.exports = {
    mqttHost: 'mqtt://10.4.1.212',
    mqttUser: 'bayi',
    mqttPassword: 'asstor',
    entityName: entityName,
    rootTopic: `homeassistant/switch/${entityName}`,
    btnRootTopic: `homeassistant/button/${entityName}`,
    uniqueId: `${machineId.machineIdSync()}${process.env.UID ? '-' + process.env.UID : ''}`,
    timeIntervalSec: 10
}
