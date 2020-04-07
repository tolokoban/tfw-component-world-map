import React from "react"
import Tfw from 'tfw'
import Date from '../data'

import "./svg-map.css"

const Button = Tfw.View.Button
const _ = Tfw.Intl.make(require("./svg-map.yaml"))

interface ISvgMapProps {
    className?: string[]
}
interface ISvgMapState {}

export default class SvgMap extends React.Component<ISvgMapProps, ISvgMapState> {
    state = {}

    render() {
        const classes = [
            'SvgMap',
            ...Tfw.Converter.StringArray(this.props.className, [])
        ]

        return (<div className={classes.join(' ')}>
            <Button label={_('ok')} />
        </div>)
    }
}
