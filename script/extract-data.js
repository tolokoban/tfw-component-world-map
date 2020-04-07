"use strict"

const FS = require("fs")
const Readline = require('readline')

const reader = Readline.createInterface({
    input: FS.createReadStream('./world.svg'),
    output: null,
    console: false
})

const currentCountry = {
    id: '',
    name: ''
}
const countries = []

reader.on('line', fullline => {
    const line = fullline.trim()
    if (line.startsWith("data-id=")) {
        currentCountry.id = JSON.parse(line.substr("data-id=".length))
    } else if (line.startsWith("data-name=")) {
        currentCountry.name = JSON.parse(line.substr("data-name=".length))
    } else if (line.startsWith("d=")) {
        const d = JSON.parse(line.substr("d=".length))
        const path = d.substr(1, d.length - 2).trim()
        const result = path
            .split(/[ \t]+/)
            .map(pair => {
                const list = pair.split(",")
                if (list.length !== 2) return pair
                return list
                    .map(x => (parseFloat(x) * 10).toFixed(0))
                    .join(",")
            })
            .join(" ")
        countries.push(`${currentCountry.id}: ["${currentCountry.name}", "${result}"]`)
    }
})
reader.on('close', () => {
    console.log("const COUNTRIES = {")
    console.log(`    ${countries.join(",\n    ")}`)
    console.log("}")
})
