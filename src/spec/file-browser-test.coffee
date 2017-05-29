# we will add this in the future

# describe 'file browser', ->
#   tag = null
#   beforeAll ->
#     fixture.load 'file-browser.html'
#     tag = riot.mount "file-browser", fileManager.buildFileModel("file-system-model")

#   afterAll ->
#     fixture.cleanup()

#   it 'should mount', ->
#     expect(tag.length).toBeGreaterThan(0)
#     element = $("file-browser")
    
#     expect(element.length).toBeGreaterThan(0)
#     expect(element.children().length).toBeGreaterThan(0)

#   it "should load a project folder's contents", ->
#     tag[0].openProject 'images'
#     # expect to find an image file in the treeview

#   it 'should update when the file system changes', ->
#     #load project folder, we have a special folder in this repo for this purpose,  /file-system-test
#     #create a temp file, expect it to add a node in the treeview
#     #rename temp file, expect it to change in treeview
#     #delete temp file, expect it to delete in the treeview
#     #create a temp folder, expect it to add in the treeview
#     #delete temp folder, expect it to delete in treeview
#     #create temp file and folder, expect them to be in the treeview...
#     #then move the file into the folder, expect treeview to update accordingly
#     #if this test is too big, break it into multiple tests


#   describe 'context menu', ->
#     it 'should show a context menu on right click', ->
#       #right click and expect the context menu to appear
#       #verify with jquery

#     it 'should create new files', ->
#       #simulate right click root node
#       #simulate click "Create File"
#       #simulate type test.txt and enter
#       #expect node in tree
#       #expect file to exist
#       #repeat in /images

#     it 'should rename files', ->
#       #simulate right click test.txt
#       #simulate click "rename"
#       #simulate type good.txt and enter
#       #expect node in tree
#       #expect file to exist

#     it 'should create folders', ->
#       #simulate right click root node
#       #simulate click "Create Folder"
#       #simulate type test and enter
#       #expect node in tree
#       #expect folder to exist
#       #repeat in /images

#     it 'should rename folders', ->
#       #simulate right click test (the folder)
#       #simulate click "rename"
#       #simulate type good and enter
#       #expect node in tree
#       #expect folder to exist
#       #repeat in /images

#     it 'should copy files', ->
#       #simulate right click "good.txt"
#       #simulate click copy
#       #verify in clipboard

#     it 'should paste files', ->
#       #simulate right click root node
#       #simulate click "paste"
#       #expect node in tree
#       #expect file to exist
#       #repeat in /images

#     it 'should copy folders', ->
#       #simulate right click "good" (folder)
#       #simulate click copy
#       #verify in clipboard

#     it 'should paste folders', ->
#       #simulate right click root node
#       #simulate click "paste"
#       #expect node in tree
#       #expect file to exist
#       #repeat in /images

#     it 'should delete files', ->
#       #simulate right click "test.txt"
#       #simulate click "delete"
#       #expect node to not exist in tree
#       #expect file to not exist
#       #repeat for all remaining extra files added in this test suit


#     it 'should delete folders', ->
#       #simulate right click "test" (folder)
#       #simulate click "delete"
#       #expect node to not exist in tree
#       #expect folder to not exist
#       #repeat for all remaining extra folders added in this test suit

#   describe 'keyboard controls', ->

#     it 'should create a file', ->
#       # select /images
#       #simulate ctrl-n
#       #in new file name field (explained in file-browser.tag) simulate type "test.txt" and enter
#       #expect file to exist

#     it 'should copy files', ->
#       #select file file-system-test/somewhere.js
#       #jquery simulate ctrl-c
#       #expect file in clipboard

#     it 'should paste files', ->
#       #select folder file-system-test/images
#       #jquery simulate ctrl-v
#       #expect node to exist in jstree
#       #expect file to exist in new location


#     it 'should delete files', ->
#       #select file file-system-test/images/somewhere.js
#       #jquery simulate delete key
#       #select file file-system-test/images/test.txt
#       #jquery simulate delete key
#       #expect nodes to not exist in jstree
#       #expect files to not exist

