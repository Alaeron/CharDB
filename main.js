// Modules to control application life and create native browser window
const { app, BrowserWindow } = require("electron");
const path = require("path");
const windowStateKeeper = require("electron-window-state");

function createWindow() {
  app.allowRendererProcessReuse = true;
  // Load the previous state with fallback to defaults
  let mainWindowState = windowStateKeeper({
    defaultWidth: 1280,
    defaultHeight: 720
  });

  // Create the browser window.
  const mainWindow = new BrowserWindow({
    x: mainWindowState.x,
    y: mainWindowState.y,
    width: mainWindowState.width,
    height: mainWindowState.height,
    webPreferences: {
      preload: path.join(__dirname, "preload.js")
    },
    backgroundColor: "#202020",
    frame: false,
    minWidth: 800,
    minHeight: 800
  });
  mainWindow.setMenu(null)

  // Let us register listeners on the window, so we can update the state
  // automatically (the listeners will be removed when the window is closed)
  // and restore the maximized or full screen state
  mainWindowState.manage(mainWindow);

  // and load the index.html of the app.
  mainWindow.loadFile("app/character_select.html");

  // Open the DevTools.
  mainWindow.webContents.openDevTools();
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on("ready", createWindow);

// Quit when all windows are closed.
app.on("window-all-closed", function() {
  app.quit();
});

app.on("activate", function() {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.

// Enable live reload for Electron too
require("electron-reload")(__dirname, {
  electron: require(`${__dirname}/node_modules/electron`)
});

// Init Database
const sqlite = require('sqlite3').verbose();
let db = new sqlite.Database("app/data/character_database.db");
db.serialize(() => {
  let result = db.all(`SELECT name FROM sqlite_master WHERE type='table'`, (err, result) => {
    // Populate database if empty
    if (result.length === 0) {
      const fs = require("fs");
      var data = fs.readFileSync('app/data/db_default.sql');
      db.exec(data.toString())
    } 
  })
  db.close()
});

// Init IPC
ipc = require('./ipc_service')