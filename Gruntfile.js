module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      files: ['Gruntfile.js'],
      options: {
        globals: {
          jQuery: true,
          console: true,
          module: true,
          document: true
        }
      }
    },
    csslint: {
      strict: {
        options: {
        },
        src: ['css/*.css']
      },
      lax: {
        options: {
          import: false
        },
        src: ['path/to/**/*.css']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-csslint');

  // Default task(s).
  grunt.registerTask('default', ['jshint', 'csslint']);

};