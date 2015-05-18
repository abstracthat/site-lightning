var gulp = require("gulp");
var lightning = require("gulp-lightning");

var config = {};
config.server = "projects:/var/www/sitelightning.co";

lightning(gulp, config);
