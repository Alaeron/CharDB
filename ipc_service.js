// Handles the main process retrieval of data for ipcRequests

const { ipcMain } = require("electron");
const sqlite = require("sqlite3").verbose();
const fs = require('fs')

// Routes
ipcMain.on("get-character-list", getCharacterList);
ipcMain.on("set-character-appearance", setCharacterAppearance);


// Functions
function setCharacterAppearance(event, arg) {
  let bitmap = fs.readFileSync(arg.data.path)
  let buff = Buffer.from(bitmap)

  let db = new sqlite.Database("app/data/character_database.db");
    db.serialize(() => {
      var image64 = buff.toString('base64');
      db.exec(`
        UPDATE Character
        SET Appearance = '` + image64 + `'
        WHERE ID=` + arg.data.id + `;
      `, (err, result) => {
          if (err) {
              console.log(err)
          }
        }
      );
    db.close();
  });
}

function getCharacterList(event, arg) {
  queryAll(event, arg, `
        SELECT 
            ch.ID, 
            ch.Name, 
            ch.Race, 
            ch.Appearance,
            GROUP_CONCAT(cl.Name || ' ' || cl.Level, ', ') AS Class
        FROM Character ch
        LEFT JOIN Class cl ON ch.ID = cl.Character_ID
        GROUP BY ch.ID;
    `)
}

// Database helpers
function queryAll(ipcRequest, arg, SQL) {
    let db = new sqlite.Database("app/data/character_database.db");
    db.serialize(() => {
    db.all(SQL, (err, result) => {
          if (err) {
              console.log(err)
          } else {
            ipcRequest.reply(arg.channel, result)
          }
      }
    );
    db.close();
  });
}

function queryOne(ipcRequest, arg,  SQL) {
    let db = new sqlite.Database("app/data/character_database.db");
    db.serialize(() => {
    db.get(SQL, (err, result) => {
          if (err) {
              console.log(err)
              return false
          } else {
            ipcRequest.reply(arg.channel, result)
          }
      }
    );
    db.close();
  });
}

