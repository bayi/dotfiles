"use strict"
const config      = require('./config')
const mqtt        = require('mqtt')

class MqttSwitch {

    constructor(name, stateCb, setCb, defaults = {})
    {
        this.config = Object.assign({}, {
            name: name,
            icon: 'mdi:switch',
            topics: {
                command: `${config.rootTopic}/${name}/set`,
                state: `${config.rootTopic}/${name}/state`,
                config: `${config.rootTopic}/${name}/config`,
                available: `${config.rootTopic}/${name}/available`,
            }
        }, defaults)
        this.stateCb = stateCb
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
            console.log(`* (${this.config.name}) Setting initial state: `, this.state)
            this.client.publish(this.config.topics.command, this.state)
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
            stat_t: this.config.topics.state,
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
        if (msg != this.state)
        {
            console.log(`* (${this.config.name}) Set State: `, msg)
            this.setCb(msg)
            this.state = msg
            this.publishState()
            this.update()
        }
    }

    publishState()
    {
        // console.log(`* (${this.config.name}) Publishing state: ${this.state}`)
        this.client.publish(this.config.topics.available, 'online')
        this.client.publish(this.config.topics.state, this.state, { retain: true })
    }

    async update()
    {
        this.state = await this.stateCb()
        this.publishState()
    }

}

module.exports = MqttSwitch
