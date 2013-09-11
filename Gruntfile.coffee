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
					'dist/uxhr.min.js': [
						'src/uxhr.js'
					]

		autowrap:
			standard:
				options:
					wrapType: 'amd'
					ext: 'js'
				files: 'dist/uxhr.amd.min.js': ['dist/uxhr.min.js']

	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-autowrap'

	grunt.registerTask 'default', ['uglify', 'autowrap']