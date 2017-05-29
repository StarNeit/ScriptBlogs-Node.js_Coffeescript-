//- we will add this in the future

//- file-browser
//-   img(src="images/file-browser.png")

//-   script(type="text/coffeescript").

//-     # this component should look and work very similarly to atom's file browser
//-     # we will use js tree for this component
//-     #we will use the following plugins:
//-     #  drag and drop
//-     #  search
//-     #  context menu
//-     #  types
//-     #  wholerow
//-     #  rename

//-     @selectedFile = null #this should always have the selected file
//-     @fileSelected = (file)->
//-       #when a file is selected, trigger an event
//-       trigger "fileSelected", file

//-     @fileDoubleClick = (file)->
//-       #when a file is selected, trigger an event
//-       trigger "fileChosen", file

//-     @keyDown = (e)->
//-       #keyboard controls
//-       #for any key that changes the selection, make sure that "fileSelected" is triggered
//-       #enter triggers "fileChosen"
//-       #jstree probably has its own events for selecting/choosing files. use those. there's no need to necessarily hook keydown for those.
//-       #delete runs fileManager.delete

//-     @createFile = ->
//-       #this should create a new file node in the currently selected folder, and immediately put it in rename mode. when rename mode is exited, the file should be created.
//-     @openProject = (path)->
//-       @update fileManager.buildFileModel

//-     @closeProject = ->

//-     #we need an event to trigger whenever the file system changes