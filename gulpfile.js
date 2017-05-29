
var gulp = require('gulp');
var gutil = require('gulp-util');
var jade = require('gulp-jade');
var stylus = require('gulp-stylus');
var riot = require('gulp-riot');
var ext_replace = require('gulp-ext-replace');
var concat = require('gulp-concat'); 
var clean = require('gulp-clean');
var replace = require('gulp-replace');
var coffeelint = require('gulp-coffeelint');
var fs = require('fs');
var jetpack = require('fs-jetpack');
var glob = require("glob");
var plumber = require('gulp-plumber');
var karmaServer = require('karma').Server;
var nodemon = require('gulp-nodemon');
var browserSync = require('browser-sync');
var coffee = require('gulp-coffee');
var utils = require('./utils/utils');
var destDir = jetpack.cwd('./app');

//task to delete app/temp directory(before creating single js)
gulp.task('initialClean', function(){
  return gulp.src('./app/temp',{read:false})
  .pipe(clean());
});

//task to delete app/temp directory(after creating single js)
gulp.task('finalClean', ['concateJS'], function(){
  return gulp.src('./app/temp',{read:false})
  .pipe(clean());
});

gulp.task('environment', function () {
    var configFile = 'config/env_' + utils.getEnvName() + '.json';
    console.log(configFile)
    jetpack.copy(configFile, destDir.path('env.json'), { overwrite: true });
});

//task to delete temp .js from app/temp directory(after creating single js)
gulp.task('deleteTempJS', ['concateJS','concateLibJs'], function(){
  return gulp.src(['./app/temp/*.js'],{read:false})
  .pipe(clean());
});

//task to compile jade files in /src/spec to HTML
gulp.task('jadeSpecTemplates', function() {
  var YOUR_LOCALS = {}; 
  return gulp.src('./src/spec/*.jade')
  .pipe(jade({
    locals: YOUR_LOCALS
  }))
  .pipe(gulp.dest('./app/spec/'))
});

//task to compile index.jade file in /src to index.html in /app directory
gulp.task('jadeIndexTemplate', function() {
 var YOUR_LOCALS = {}; 
 return gulp.src('./src/index.jade')
 .pipe(jade({
   locals: YOUR_LOCALS
 }))
 .pipe(gulp.dest('./app/'))
});

//protoTypeGulp
gulp.task('protoTypeGulp', function() {
 var YOUR_LOCALS = {}; 
 return gulp.src('./src/prototype/index.jade')
 .pipe(jade({
   locals: YOUR_LOCALS
 }))
 .pipe(gulp.dest('./app/prototype/'));
});

//todo temp folder should not be app. this applies to all uses of the temp folder

//task to compile .tag files in /src/components/ to .js
gulp.task('jadeRiotComponents', function() {
  return gulp.src('./src/components/*.tag')
  .pipe(plumber({}))
  .pipe(riot({    
    template:'jade'
  }))
  .pipe(gulp.dest('./app/temp'));
});

// gulp.watch(['./src/lib/*.coffee'],['coffeeToJs']);

gulp.task('coffeeToJs' , function(){
  return gulp.src('./src/lib/*.coffee')
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('./app/temp/lib/'));
})


gulp.task('coffeeMainToJs' , function(){
    return gulp.src('./src/main.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('./app/'));
})

gulp.task('coffeeRendererToJs' , function(){
    return gulp.src('./src/renderer.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('./app/'));
})

gulp.task('envToJs' , function(){
    return gulp.src('./src/env.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('./app/'));
})

gulp.task('coffeeHelpersToJs' , function(){
    return gulp.src('./src/helpers/*.coffee')
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest('./app/helpers'));
})

gulp.task('concateLibJs' , ['coffeeToJs'] , function(){
  return gulp.src(['./src/lib/*.js','./app/temp/lib/*.js'])
  //.pipe(clean({force: true}))
  .pipe(concat('lib.js'))
  .pipe(gulp.dest('./app/lib/'));
})


// task to merge all js files in single js file
gulp.task('concateJS',['jadeRiotComponents'], function() {
  return gulp.src('./app/temp/*.js')
  .pipe(concat('components.js'))
  .pipe(gulp.dest('./app/components/'));
});

//task to lint coffeescripts files in src/spec and coffee portions from .jade and .tag files
gulp.task('coffeelint', ['coffeeFromJadeFile', 'coffeeFromTagFile'], function () {
  gulp.src(['./src/spec/*.coffee', './app/temp/*.coffee' , './src/lib/helpers.coffee',
      './src/main.coffee', './src/renderer.coffee'])
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())
});


//task to extract coffee from tag files and cretae coffee file in app/temp directory
gulp.task('coffeeFromTagFile', function(){
  extractCoffee('src/components/*.tag', './app/temp');
});

//task to extract coffee from jade files in src and cretae coffee file in app/temp directory
gulp.task('coffeeFromJadeFile', function(){
  extractCoffee('src/**/*.jade', './app/temp');
});


//task to watch for changes in .tag files and .coffee files created form .tag files
//gulp.task('tag_changes',['coffeeFromTagFile', 'coffeelint', 'jadeRiotComponents', 'concateJS', 'finalClean']);
gulp.task('tag_changes',['coffeeFromTagFile', 'coffeelint', 'jadeRiotComponents', 'concateJS', 'deleteTempJS']);

//task to watch for changes in .coffee files created form .jade files
//gulp.task('jade_changes',['coffeeFromJadeFile', 'coffeelint', 'finalClean']);
gulp.task('jade_changes',['coffeeFromJadeFile', 'coffeelint']);

gulp.task('lib_changes',['coffeeToJs','concateLibJs','deleteTempJS'])
//gulp.task('watch', ['finalClean'], function(){
gulp.task('watch', function(){
  gulp.watch(['./src/*.jade'],['jadeIndexTemplate']);
  gulp.watch(['./src/spec/*.jade'],['jadeSpecTemplates']);
  gulp.watch(['./src/prototype/*.jade'] ,['protoTypeGulp']);
  gulp.watch(['./src/components/*.tag'],['tag_changes']);
  // gulp.watch(['./src/spec/*.coffee'],['coffeelint', 'finalClean']);
  // gulp.watch(['./src/**/*.jade'],['jade_changes', 'finalClean']); //for coffeelint
  gulp.watch(['./src/spec/*.coffee','./src/lib/*.coffee', './src/main.coffee',
      './src/renderer.coffee', './src/helpers/*.coffee'],['coffeelint']);
  gulp.watch(['./src/**/*.jade'],['jade_changes']); //for coffeelint
  gulp.watch(['./src/lib/*.js','./src/lib/*.coffee'] ,['lib_changes']);
  gulp.watch(['./src/lib/*.js','./src/lib/main.coffee'] ,['coffeeMainToJs']);
  gulp.watch(['./src/lib/*.js','./src/lib/renderer.coffee'] ,['coffeeRendererToJs']);
  gulp.watch(['./src/lib/*.js','./src/lib/helpers/*.coffee'] ,['coffeeHelpersToJs']);
  gulp.watch(['./src/prototype/*.styl'] ,['stylusCompile']);
});

//Run Test
gulp.task('test', function (done) {
  new karmaServer({
    configFile: __dirname + '/karma.conf.js',
    //singleRun: true
  }, done).start();
});

gulp.task('browserSync', ['start'], function() {
  browserSync.init(null, {
    proxy: "http://localhost:3000",
        files: ["app/**/*.*"],
        browser: "google chrome",
        port: 7000,
  });
});

//Start Server
gulp.task('start', function (cb) {
  nodemon({
      script: 'bin/www',
      watch : ['app.js','bin/www','routes/*.js']
  });
})

//Stylus Compliation
gulp.task('stylusCompile', function () {
  return gulp.src('./src/prototype/*.styl')
    .pipe(stylus({}))
    .pipe(gulp.dest('./app/prototype/'));
});


//gulp.task('default',['jadeSpecTemplates', 'jadeIndexTemplate', 'jadeRiotComponents', 'coffeelint', 'coffeeMainToJs', 'coffeeRendererToJs',
// coffeeHelpersToJs, 'concateJS', 'finalClean', 'watch']);
var gulpTaskList = [ 'jadeSpecTemplates'
                    ,'jadeIndexTemplate'
                    ,'jadeRiotComponents'
                    ,'coffeelint'
                    ,'coffeeMainToJs'
                    ,'coffeeRendererToJs'
                    ,'coffeeHelpersToJs'
                    ,'envToJs'
                    ,'concateLibJs'
                    ,'concateJS'
                    ,'deleteTempJS'
                    ,'watch'
                    ,'test'
                    ,'start'
                    ,'protoTypeGulp'
                    ,'stylusCompile'
                    ,'environment'
                    //,'browserSync'
                  ];
gulp.task('default',gulpTaskList);


function extractCoffee(directoryPath, destDirectoryPath){
  var files = glob.sync(directoryPath);
  var promiseArr=[];
  files.forEach(function(file){
    promiseArr.push(createCoffeeFile(file, destDirectoryPath));
  });

  return Promise.all(promiseArr).then(function(result){
  });  
};

function createCoffeeFile(filePath, destDirectoryPath){
  return new Promise(function(resolve, reject){
    fs.readFile(filePath, function(err, data){
      if(!err){
        var fileName = filePath.substring(filePath.lastIndexOf('/')+1);
        fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase(),
        searchString = null,       
        stringData = data.toString();

        switch(fileExtension){
          case '.tag':
          searchString = 'script(type="text/coffeescript").';
          break;
          case '.jade':
          searchString = ':coffee-script';
          break;
          default:
          searchString = null;
          break;
        }  
        var index = stringData.indexOf(searchString);
        if(index>-1){
        //take all data after this searchString index
        var coffeeScriptCode = stringData.substring(index);
        coffeeScriptCode = coffeeScriptCode.replace(searchString, '');
        // inserts line breaks in coffeeScriptCode
        var subStringsArray = stringData.split(searchString);
        var numberOfLineBreaks= subStringsArray[0].split(/\r\n|\r|\n/).length;
        for (i=0; i < numberOfLineBreaks-1; ++i){
          coffeeScriptCode = '\n'+coffeeScriptCode;
        }
          // removes leading indent from starting of each coffeeScriptCode line
          coffeeScriptCode = coffeeScriptCode.replace(/\n    |\r    /g,'\n');
          var coffeeFileName = fileName.replace(fileExtension,'-coffee.coffee');
          if (!fs.existsSync(destDirectoryPath)){
            fs.mkdirSync(destDirectoryPath);
          }
          fs.writeFile(destDirectoryPath +'/'+ coffeeFileName, coffeeScriptCode, function(err){
            if(err){
              console.log(err);
              reject(err);
            } 
            resolve('success');         
          });
        }
      }else{
        console.log(err);
        reject(err);
      }
    })
  })
};

