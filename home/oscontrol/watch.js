"use strict"
const config      = require('./config')
const mqtt        = require('mqtt')
const fs          = require('fs')
const path        = require('path')

// Feliratkozik egy MQTT topicra, és az utolsó értéket fájlba írja:
//   $XDG_RUNTIME_DIR/oscontrol/<name>
// hogy shell scriptek (pl. waybar modul) jelszó nélkül olvashassák.
class MqttWatch {

    constructor(name, topic, onValue = null)
    {
        this.name = name
        this.topic = topic
        this.onValue = onValue
        this.dir = path.join(process.env.XDG_RUNTIME_DIR || '/tmp', 'oscontrol')
        fs.mkdirSync(this.dir, { recursive: true })
        this.file = path.join(this.dir, name)

        console.log(`* (${this.name}) Connecting to MQTT broker ...`)
        this.client = mqtt.connect('mqtt://10.0.0.8', {
            username: config.mqttUser,
            password: config.mqttPassword,
        })

        this.client.on('connect', () => {
            console.log(`* (${this.name}) Connected, watching ${this.topic}`)
            this.client.subscribe(this.topic)
        })

        this.client.on('message', (topic, message) => {
            if (topic != this.topic) return
            const value = message.toString()
            fs.writeFileSync(this.file, value + '\n')
            if (this.onValue) this.onValue(value)
        })
    }
}

module.exports = MqttWatch
