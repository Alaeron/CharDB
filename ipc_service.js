// Handles the main process retrieval of data for ipcRequests

const { ipcMain } = require("electron");
const sqlite = require("sqlite3").verbose();

// Routes
ipcMain.on("get-character-list", getCharacterList);
setCharacterAppearance();


function getAppearance() {
// temp store blob image
  const fs = require('fs')
  const bitmap = fs.readFileSync('warforged.bmp')
  const buff = Buffer.from(bitmap)
  return buff
}


// Functions
function setCharacterAppearance(event, arg) {
  let db = new sqlite.Database("app/data/character_database.db");
    db.serialize(() => {
      var image64 = getAppearance().toString('base64');
      db.exec(`
        UPDATE Character
        SET Appearance = '` + image64 + `'
        WHERE ID=1;
      `, (err, result) => {
          if (err) {
              console.log(err)
          } else {
            console.log('done')
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

