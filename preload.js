// All of the Node.js APIs are available in the preload process.
// It has the same sandbox as a Chrome extension.
currentWindow = require('electron').remote.getCurrentWindow()
const fs = require("fs");

// Enable IPC in renderer process
window.ipcRequest = require('./ipc_request');

// Run window ready steps
window.addEventListener('DOMContentLoaded', () => {
    loadCustomComponents()
})

function loadCustomComponents() {
    // Load custom components
    Array.from(document.getElementsByClassName("component")).forEach(element => {
        var data = fs.readFileSync('app/components/' + element.getAttribute("data-component") + '.html');
        var fragment = document.createRange().createContextualFragment(data.toString())
        element.replaceWith(fragment);
    })

    // Custom Component Event Listeners

    // Window Controls
    document.getElementById("btn-min").addEventListener("click", function() {
        currentWindow.minimize()
    })
    document.getElementById("btn-max").addEventListener("click", function() {
        if (currentWindow.isMaximized()) {
            currentWindow.unmaximize()
        } else {
            currentWindow.maximize()
        }
    })
    document.getElementById("btn-close").addEventListener("click", function() {
        currentWindow.close()
    })  
}
