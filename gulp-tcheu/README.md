# gulp-tcheu

## About the script

This gulp file contains the tasks that we often use for our projects.
The idea here is to take away the particular settings of any project in a configuration file,
so that we are able to re-use the same tasks and update the gulp file from project to project,
without having to change the file paths each time.

## Installation

Simply run `npm install` from the command line, all the needed dependencies will be downloaded.

## Configuration

Every information related to your project should be stored in the `gulp-config.js` file.
Once you have completed that file with all the relevant information, you will be ready to build.

Let's review all the configuration sections and their options.

### global

We store here general-purpose settings for the gulp file. It can be useful to tweak the behaviour
of the script, but you will generally want to leave this section unchanged.

+ `notifications` - Used to tweak the notifications sent to the console and browser-sync
	+ `logo` - Image URL to your logo. If this option is defined, it will display the logo in the browser-sync notifications. Strictly useless, but fun nevertheless.
	+ `timeout` - How many time should browser-sync display the notifications?
	+ `errorTimeout` - Same as timeout, but for errors. You might want to put a little more time here in order to have time to decipher the gibberish returned by gulp-sass :)

### tasks

This section allows you to create groups of tasks. It is hashmap where the key represents the name of the task, and the value is an array containing the tasks that should be launched. The available tasks in the build file are the following:

+ `startBrowserSync` - Start a new browser-sync server
+ `reloadBrowserSync` - Ask browser-sync to reload all browsers
+ `startStaticServer` - Start a new static server - useful in the early days of the project where you want to only design templates or when you are working with a static website generator like Jekyll
+ `compileStyles` - Use SASS to compile your SCSS files
+ `compressStyles` - Create a minified version of a compiled CSS file
+ `checkScripts` - Check the syntax of your JavaScript files
+ `compileScripts` - Bundle all your JavaScript files into one file
+ `compressScripts` - Create a minified version a compiled JS file
+ `optimizeImages` - Optimize all jpg, gif and png in a defined folder
+ `clean` - Empty the content of all js and css dist folders
+ `watchFiles` - Monitor your files for any changes. The files you monitor and their associated tasks can be configured from the watchFiles section of the configuration file

### watchFiles

Define here what files pattern should be monitored (using glob syntax) and what tasks should be run when one of these files is modified. watchFiles is an hashmap where the keys represents the files pattern(s) to watch. Multiple patterns can be used if they are separated by a comma. The value should be an array of task names to be executed when the files changes.

For example, using the following key/value:

	"*.html,./assets/js/dist/*.js": ["reloadBrowserSync"]

1. All HTML files in the current folder and all the JS files in the assets/js/dist folder will be monitored
2. The reloadBrowserSync task will be executed when there is a change

### js

+ `src` - Pattern matching all the JS files that need to be concatenated
+ `bundleFileName` - Name of the concatenated (non-minified) JS file
+ `dest` - Destination folder for the concatenated and minified files

### css

+ `src` - Pattern matching all the SCSS files that need to be compiled (using gulp-sass)
+ `bundleFileName` - Name of the concatenated (non-minified) CSS file
+ `dest` - Destination folder for the compiled and minified files

### img

+ `src` - Pattern matching all images files that need to be optimized
+ `dest` - Folder where to store the optimized images

### staticServer

+ `baseDir` - Specify here the directory of the static web server's root
+ `port` - The number of the port that should be used for the server (e.g. 8080)

### Other configuration sections

The other sections are used to configure individual plugins. For information regarding these options, it is best
to directly read the documentation of each plugin.

## Special thanks

This gulp file is largely inspired by [a blog post](http://www.webstoemp.com/blog/gulp-setup/) from our friend @jeromecoupe from [Webstoemp](http://www.webstoemp.com/).