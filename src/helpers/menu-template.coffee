electron = require('electron')
app = electron.app
BrowserWindow = electron.BrowserWindow
dialog = electron.dialog
pythonManager = require("./python-manager")
module.exports = [
  {
    label: 'Files',
    submenu: [{
      label: 'Open File',
      click: () ->
        properties = ['openFile', 'openDirectory']

        if(process.platform == 'darwin')
          parentWindow = null
        else
          parentWindow = BrowserWindow.getFocusedWindow()

        dialog.showOpenDialog(parentWindow, properties, (f) ->
          pythonManager.executeScript(f).then((result) ->
            console.log result
          )
        )
        return
    },{
      label: 'Quit',
      accelerator: 'CmdOrCtrl+Q',
      click: () ->
        app.quit()
        return
    }],
  }
  {
    label: 'Development',
    submenu: [{
      label: 'Reload',
      accelerator: 'CmdOrCtrl+R',
      click: () ->
        BrowserWindow.getFocusedWindow().webContents.reloadIgnoringCache()
        return
    },{
        label: 'Toggle DevTools',
        accelerator: 'Alt+CmdOrCtrl+I',
        click: () ->
          BrowserWindow.getFocusedWindow().toggleDevTools();
          return
    }]
}]