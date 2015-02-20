module.exports = {
	/* Main settings */

	//Global configuration
	"global": {
		//Notifications options
		"notifications": {
			//Optional: you may add the link to a logo image that will appear in the browser sync configuration
			"logo": "http://tcheu.be/assets/images/logo-no-tagline-400px.png",
			//How many milliseconds should the notifications be shown
			"timeout": 2000,
			//Same thing but when showing error notifications
			"errorTimeout": 5000
		}
	},

	//Tasks lists
	"tasks": {
		"default": ["dev"],
		"dev": ["compileStyles", "compileScripts", "startStaticServer", "startBrowserSync", "watchFiles"]
	},

	//Watch files configuration
	"watchFiles": {
		"./assets/css/*.scss": ["compileStyles"],
		"./assets/js/src/**/*.js": ["compileScripts"],
		"*.html,./assets/js/dist/*.js": ["reloadBrowserSync"]
	},

	/* Plugins and task settings */

	//Autoprefixer
	"autoprefixer": [
		'last 3 versions',
		'ie >= 8',
		'ios >= 7',
		'android >= 4.4',
		'bb >= 10'
	],
	//BrowserSync config
	"browserSync": {
		"baseDir": "./",
		"port": 3000
	},
	//ESLint config
	"eslint": {
		"rules": {
			"quotes": 0,
			"no-console": 1
		},
		"globals": {
			"$": true,
			"angular": true,
			"jQuery": true,
			"console": true
		}
	},
	//Scripts compilation
	"js": {
		//Path or pattern match one or more JS files
		"src": "./assets/js/src/**/*.js",
		//Bundle file name
		"bundleFileName": "bundle.js",
		//Destination folder for the bundle
		"dest": "./assets/js/dist"
	},
	//Styles compilation
	"css": {
		//Path or pattern match one or more SCSS files
		"src": "./assets/css/main.scss",
		//Destination folder for the compiled CSS
		"dest": "./assets/css"
	},
	//Image optimization
	"img": {
		"src": "./assets/img/**/*.{jpg,png,gif}",
		"dest": "./assets/img"
	},
	//Imagemin options
	"imagemin": {
        "progressive": true,
        "interlaced": true
    },
	//Static server config
	"staticServer": {
		"baseDir": "./",
		"port": 8080
	}
};