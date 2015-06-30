var gulp = require("gulp");
var yaml = require("yamljs");
var lightning = require("gulp-lightning");

var config = yaml.load("config.yml");
lightning(gulp, config);
