"use strict"

gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
nodeunit = require  'gulp-nodeunit'
nodemon = require 'nodemon'
filter = require 'gulp-filter'
react = require 'gulp-react'

SRC_PATH = './src/**/*.*'
SRC_TEST_PATH = './test/**/*.coffee'


gulp.task 'default', ->
    coffee_filter = filter "**/*.coffee"

    gulp.src(SRC_PATH)
        .pipe(coffee_filter)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(coffee_filter.restore())
        .pipe(gulp.dest('./build'))


gulp.task 'test', ->
    gulp.src(SRC_TEST_PATH)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
        .pipe(nodeunit({reporter: "tap"}))


gulp.task 'serve', ['watch'], ->
    nodemon(
        delay: 1000
        script: './build/server/server.js'
        ext: 'js'
    )


gulp.task 'watch', ['default'], ->
    gulp.watch SRC_PATH, ['default']
    gulp.watch SRC_TEST_PATH, ['test']