module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'


  grunt.registerTask 'build', ['coffeelint', 'coffee', 'uglify']
  grunt.registerTask 'default', ['build']

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    meta:
      banner: '/* <%= pkg.name %> v<%= pkg.version %>\n' +
              '   <%= pkg.repository.url.replace(/^git/, "http") %>\n' +
              '   The MIT License */\n'

    watch:
      dist:
        files: ['src/*.coffee']
        tasks: ['build']

    coffeelint:
      dist:
        src: ['src/coffee/**/*.coffee']

    coffee:
      dist:
        options:
          bare: true
        files:
          'jquery.swapper.js': ['src/*.coffee']

    uglify:
      options:
        banner: "<%= meta.banner %>"
      dist:
        files:
          'jquery.swapper.js': ['jquery.swapper.js']
