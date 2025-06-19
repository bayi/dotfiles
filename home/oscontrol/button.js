"use strict"
const config      = require('./config')
const mqtt        = require('mqtt')

class MqttButton {

    constructor(name, setCb, defaults = {})
    {
        this.config = Object.assign({}, {
            name: name,
            icon: 'mdi:lightning-bolt',
            topics: {
                command: `${config.btnRootTopic}/${name}/set`,
                config: `${config.btnRootTopic}/${name}/config`,
                available: `${config.btnRootTopic}/${name}/available`,
            }
        }, defaults)
        this.setCb = setCb
        console.log(`* (${this.config.name}) Connecting to MQTT broker ...`)
        this.client = mqtt.connect('mqtt://10.4.1.212', {
            username: config.mqttUser,
            password: config.mqttPassword,
            will: {
                topic: this.config.topics.available,
                payload: 'offline',
                qos: 2,
                retain: true
            }
        })

        this.client.on('connect', async() => {
            console.log(`* (${this.config.name}) Connected.`)
            await this.update()
            this.client.subscribe(this.config.topics.command)
            this.publishConfig()
            this.update()
        })

        this.client.on('message', (topic, message) => {
            if (topic == this.config.topics.command)
                this.command(topic, message)
        })
    }

    publishConfig()
    {
        this.client.publish(this.config.topics.config, JSON.stringify({
            name: `${config.entityName}-${this.config.name}`,
            cmd_t: this.config.topics.command,
            avty_t: this.config.topics.available,
            uniq_id: `${config.uniqueId}_${this.config.name}`,
            icon: this.config.icon,
            qos: 1,
        }), { retain: true })
    }

    command(topic, message)
    {
        const msg = message.toString()
        this.setCb(msg)
        this.update()
    }

    publishState()
    {
        // console.log(`* (${this.config.name}) Publishing state: ${this.state}`)
        this.client.publish(this.config.topics.available, 'online')
    }

    async update()
    {
        this.publishState()
    }

}

module.exports = MqttButton
