"use strict"
const os                    = require('os')
const machineId             = require('node-machine-id')
const entityName            = `host-${process.env.HOSTNAME || os.hostname()}`

module.exports = {
    mqttHost: process.env.MQTT_HOST || undefined,
    mqttUser: process.env.MQTT_USER || 'anonymous',
    mqttPassword: process.env.MQTT_PASSWORD || 'anonymous',
    entityName: entityName,
    rootTopic: `homeassistant/switch/${entityName}`,
    btnRootTopic: `homeassistant/button/${entityName}`,
    uniqueId: `${machineId.machineIdSync()}${process.env.UID ? '-' + process.env.UID : ''}`,
    timeIntervalSec: 10
}
