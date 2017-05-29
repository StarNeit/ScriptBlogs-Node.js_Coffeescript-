# in this module, you will create a bridge to cpython. 
# see https://www.fyears.org/2017/02/electron-as-gui-of-python-apps-updated.html
fs = require('fs')
path = require('path')

class PythonManager
  @pyProc = null
  @sessionStack = []
  @guessPackaged = (path) ->
    return fs.existsSync(path)

  @executeScript = (script) ->
    dataString = ""
    promise = new Promise((resolve, reject) =>
      if(process.platform != 'darwin')
        @pyProc = require('child_process').spawn(process.resourcesPath+'\\python\\python.exe', [script])
      else
        @pyProc = require('child_process').spawn('python', [script])
      if (@pyProc != null)
        console.log 'child process success'

        @pyProc.stdout.on 'data',(data) ->
          dataString += data.toString();

        @pyProc.stdout.on 'end', () =>
          console.log(dataString)
          resolve(dataString)
      return
    )
    return promise

  @closeSession = () ->
    @sessionStack = []

  @runPython = (code)->
    promise = new Promise((resolve, reject) =>
      dataString = ""
      child_process = null
      @sessionStack.push(code)
      exec = "exec(\""+@sessionStack.join("\\n")+"\")"
      if(process.platform != 'darwin')
        child_process = require('child_process').spawn(process.resourcesPath+'\\python\\python.exe', [script])
      else
        child_process = require('child_process').spawn('python', [script])

      child_process.stderr.on('data', (data) =>
          reject(data.toString());
      )
      child_process.stdout.on 'data',(data) ->
        dataString += data.toString();

      child_process.stdout.on 'end', () =>
        resolve(dataString)
    )
    return promise

module.exports = PythonManager
