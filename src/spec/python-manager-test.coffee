PythonManager = require("../helpers/python-manager")
pythonManager = PythonManager
describe 'python manager', ->
  it 'should run python and return a result', ->
    pythonManager.runPython("print('hello')").then (result) ->
      expect(result).toEqual("hello")

  it 'should run python and send variable and print result', ->
    pythonManager.closeSession()
    pythonManager.runPython("a=1").then () ->
        pythonManager.runPython("print(a)").then (result) ->
          expect(result).toEqual("1")