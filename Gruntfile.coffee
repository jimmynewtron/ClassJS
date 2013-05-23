module.exports = (grunt)->
	strBanner = '''
/**
 * ClassJS
 * Author: Darlan Alves <darlan@moovia.com>
 * Built on <%= grunt.template.today("yyyy-mm-dd") %>
 */


'''

	pkg = grunt.file.readJSON('package.json')
	buildmap = require('./buildmap')
	testmap = require('./testmap')

	uglify = buildmap(pkg)
	uglify.options = banner: strBanner

	grunt.initConfig
		pkg: pkg
		clean:
			dist: 'dist/'

		uglify: uglify
		jasmine: testmap(pkg)

	for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
		grunt.loadNpmTasks name

	grunt.registerTask('build', [
		'clean:dist',
		'uglify:release',
	])

	grunt.registerTask('build-demo',	['uglify:demo'])
	grunt.registerTask('release', 		['build', 'jasmine'])
	grunt.registerTask('test', 			['jasmine'])
	grunt.registerTask('default', 		['release']);
