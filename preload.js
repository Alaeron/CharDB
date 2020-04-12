// All of the Node.js APIs are available in the preload process.
// It has the same sandbox as a Chrome extension.

const fs = require("fs");
const { remote } = require("electron");

currentWindow = remote.getCurrentWindow();

// Enable IPC in renderer process
window.ipcRequest = require("./ipc_request");
window.loadFile = currentWindow.loadFile;

// Run window ready steps
window.addEventListener("DOMContentLoaded", initDOM);

function initDOM() {
  loadCustomComponents();
}

function loadCustomComponents() {
  // Load custom components
  Array.from(document.getElementsByClassName("component")).forEach(
    (element) => {
      var data = fs.readFileSync(
        "app/components/" + element.getAttribute("data-component") + ".html"
      );
      var fragment = document
        .createRange()
        .createContextualFragment(data.toString());
      element.replaceWith(fragment);
    }
  );

  // Custom Component Event Listeners

  // Window Controls
  document.getElementById("btn-min").addEventListener("click", function () {
    currentWindow.minimize();
  });
  document.getElementById("btn-max").addEventListener("click", function () {
    if (currentWindow.isMaximized()) {
      currentWindow.unmaximize();
    } else {
      currentWindow.maximize();
    }
  });
  document.getElementById("btn-close").addEventListener("click", function () {
    currentWindow.close();
  });

  // toolbar selection
  pathArray = window.location.pathname.split("/");
  switch (pathArray[pathArray.length - 1]) {
    case "character_info.html":
      document.getElementById("img-character-info").classList.add("selected");
      break;
    case "character_combat.html":
      document.getElementById("img-combat").classList.add("selected");
      break;
    case "character_spells.html":
      document.getElementById("img-spells").classList.add("selected");
      break;
    case "character_inventory.html":
      document.getElementById("img-inventory").classList.add("selected");
      break;
    case 'character_notes.html':
      document.getElementById("img-character-notes").classList.add("selected")
      break;
  }
}
