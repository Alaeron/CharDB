
window.ipcRequest.sendRequest('get-character-list', null, loadCharacters)
//window.ipcRequest.sendRequest('set-character-appearance', {id: 2, path: 'warlock.jpg'}, function() {})

function loadCharacters(event, result) {
    var charGrid = document.getElementById("character-grid");
    while (charGrid.firstChild) {
        charGrid.firstChild.remove()
    }
    result.forEach(element => {
        var card = document.createRange().createContextualFragment(`
            <a class="character-card" id="character-` + element.ID + `" href='character_info.html?id=` + element.ID + `'>
                <div class="character-info">
                  <h2>` + element.Name + `</h2>
                  <label>` + element.Race + `</label>
                  <label>` + element.Class + `</label>
                </div>
            </a>
        `)
        document.getElementById("character-grid").appendChild(card)
        var cardElement = document.getElementById("character-" + element.ID)
        cardElement.style.backgroundImage = "url('data:image/bmp;base64," + element.Appearance + "')";
    });
}
