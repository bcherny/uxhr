module.exports = (grunt) ->

	grunt.config.init

		uglify:
			options:
				mangle:
					toplevel: true
				compress:
					dead_code: true
					unused: true
					join_vars: true
				comments: false
			standard:
				files:
					'uxhr.min.js': [
						'uxhr.js'
					]

	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.registerTask 'default', ['uglify']