# we will add this in the future

# describe 'file manager', ->
#   # we have a special folder in this repo for this test suite, /file-system-test
    
  it 'should build a file model', ->
    model = fileManager.openProject("/file-system-test")
    expect(model).to equal
    {
      name: "file-system-test"
      type: "root"
      path: ""
      children:[
        {
          name: "images",
          type: "folder",
          path: "images",
          children: [{
            name: "thumbs",
            type: "folder",
            path: "images/thumbs"
            children: [
              {
                name: "thumb.png",
                type: "file",
                extension: "png"
              },
              {
                path: "images/thumbs.png",
                name: "img.gif",
                type: "file",
                extension: "gif"
              },
              {
                path: "images/img.gif",
                name: "pic.png",
                type: "file",
                extension: "png",
                path: "images/cat002.jpg"
              }
            ]
          }]
        },
        {
          name: "something.js"
          type: "file"
          extension: "js"
          path: "something.js"
        },
        {
          name: "somewhere.html"
          type: "file"
          extension: "html"
          path: "somewhere.html"
        }
        ]
    }


#   it 'should create a folder', ->
#     fileManager.createFolder("test-folder")
#     #expect folder to exist

#   it 'should save a file', ->
#     fileManager.save "file-system-test/test.txt", "hello"
#     #expect file to exist

#   it 'should open a file', ->
#     content = fileManager.open "file-system-test/test.txt"
#     expect(content).toBe "hello"

#   it 'should copy a file', ->
#     fileManager.copy "file-system-test/test.txt"
#     #expect clipboard to contain file

#   it 'should paste a file', ->
#     fileManager.paste "file-system-test/test-folder/"
#     #expect file to exist 

#   it 'should add a number to a pasted a file if a file of the same name exists', ->
#     fileManager.paste "file-system-test/test-folder/"
#     #expect "file-system-test/images/test0.txt" to exist
#     #open the file and verify contents

#   it 'should copy a folder', ->
#     fileManager.copy "file-system-test/images"
#     #expect clipboard to contain file

#   it 'should paste a folder', ->
#     fileManager.paste "file-system-test/test-folder/"
#     #expect folder to exist 
#     #expect correct files to exist in pasted folder

#   it 'should add a number to a pasted a folder if a folder of the same name exists', ->
#     fileManager.paste "file-system-test/test-folder/"
#     #expect "file-system-test/images/images0" to exist
#     #open the file and verify contents

#     fileManager.paste "file-system-test/test-folder/"
#     #expect "file-system-test/images/images1" to exist 

#   it "should delete a file", ->
#     fileManager.delete "file-system-test/test.txt"
#     #expect file to not exist

#   it "should delete a folder", ->
#     fileManager.delete "test-folder"

