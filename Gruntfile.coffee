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

		bytesize:
			all:
				src: [
					'uxhr.js'
					'uxhr.min.js'
				]

	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-bytesize'

	grunt.registerTask 'default', ['uglify', 'bytesize']