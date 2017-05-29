electron = require('electron')
# Module to control application life.
app = electron.app
# Module to create native browser window.
BrowserWindow = electron.BrowserWindow
path = require('path')
url = require('url')
Menu = electron.Menu
menus = require("./helpers/menu-template")
#Do not call setFeedURL. electron-builder automatically creates app-update.yml
# file for you on build in the resources (this file is internal,
# you don't need to be aware of it).
autoUpdater = require("electron-updater").autoUpdater

env = require("./env")
# Keep a global reference of the window object, if you don't, the window will
# be closed automatically when the JavaScript object is garbage collected.
mainWindow = undefined



setApplicationMenu = ->
  Menu.setApplicationMenu(Menu.buildFromTemplate(menus))

sendStatusToWindow = (text)->
  mainWindow.webContents.send('message', text)

autoUpdater.on 'checking-for-update', () ->
  sendStatusToWindow('Checking for update...')

autoUpdater.on 'update-available', (ev, info) ->
  sendStatusToWindow('Update available.')

autoUpdater.on 'update-not-available', (ev, info) ->
  sendStatusToWindow('Update not available.')

autoUpdater.on 'error', (ev, err) ->
  sendStatusToWindow('Error in auto-updater.')

autoUpdater.on 'download-progress', (progressObj) ->
  log_message = "Download speed: " + progressObj.bytesPerSecond
  log_message = log_message + ' - Downloaded ' + progressObj.percent + '%'
  log_message = log_message + ' (' + progressObj.transferred + "/" + progressObj.total + ')'
  sendStatusToWindow(log_message)

autoUpdater.on 'update-downloaded', (ev, info) ->
  sendStatusToWindow('Update downloaded; will install in 5 seconds')

# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
# Some APIs can only be used after this event occurs.

createWindow = ->
  setApplicationMenu()
# Create the browser window.
  mainWindow = new BrowserWindow(
    width: 800
    height: 600)
  # and load the index.html of the app.
  mainWindow.loadURL url.format(
    pathname: path.join(__dirname, 'index.html')
    protocol: 'file:'
    slashes: true)
  # Open the DevTools.
  # mainWindow.webContents.openDevTools()
  # Emitted when the window is closed.
  mainWindow.on 'closed', ->
# Dereference the window object, usually you would store windows
# in an array if your app supports multi windows, this is the time
# when you should delete the corresponding element.
    mainWindow = null
    return
  return




app.on 'ready', createWindow
# Quit when all windows are closed.
app.on 'window-all-closed', ->
# On OS X it is common for applications and their menu bar
# to stay active until the user quits explicitly with Cmd + Q
  if process.platform != 'darwin'
    app.quit()
  return

app.on 'activate', ->
# On OS X it's common to re-create a window in the app when the
# dock icon is clicked and there are no other windows open.
  if mainWindow == null
    createWindow()
  return
# In this file you can include the rest of your app's specific main process
# code. You can also put them in separate files and require them here.

autoUpdater.on 'update-downloaded', (ev, info) ->
  autoUpdater.quitAndInstall()

app.on 'ready', () ->
  if (env.name != 'development')
    autoUpdater.checkForUpdates()
  return
