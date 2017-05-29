module.exports = ->
  #http://stackoverflow.com/questions/11194287/convert-a-directory-structure-in-the-filesystem-to-json-with-node-js
  #all files and folders in the file model should be watched and the file model should be updated with any changes
  @fileModel = {}

  @buildFileModel = (path)->
    #build model from path
    @fileModel

  @createFolder = (path)->

  @save = (file, data)->

  @open = (file)->

  @delete = (file)->

  @copy = (file)->

  @paste = (path)->
    #return name of pasted file or folder.
    # if a file or folder of the same name already exists in the folder, add a 0 to the end. 
    # if a file or folder with a 0 on the end exists, add a 1 on the end, etc etc