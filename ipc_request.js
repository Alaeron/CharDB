// Handles the renderer side requests available

const { ipcRenderer } = require('electron')

module.exports = {
    sendRequest: function sendRequest(channel, data, callback) {
        ipcRenderer.once(channel, callback)
        ipcRenderer.send(channel, {data:data, channel:channel})

    }, 
    on: function(channel, listener) {
        ipcRenderer.on(channel, listener)
    },
    off: function(channel, listener) {
        ipcRenderer.off(channel, listener)
    }
}
