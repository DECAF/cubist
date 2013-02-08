var path = require('path');

var APP_FILE = 'cubist';
var COFFEE_SRC = 'lib';
var COFFEE_TARGET = 'src';
var BUILD_TARGET = 'public';

var BUILD_PATH = path.join(__dirname, BUILD_TARGET);
var BUILD_FILE = path.join(BUILD_PATH, APP_FILE + '.js');

var uglifyOptions = {
    mini : {
        files : {}
    }
};

uglifyOptions.mini.files[path.join(__dirname, BUILD_TARGET, APP_FILE + '.min.js')] = BUILD_FILE;

module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg        : '<json:package.json>',
        meta       : {
            banner : '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
                '<%= pkg.homepage ? "* " + pkg.homepage + "\n" : "" %>' +
                '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
                ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */'
        },
        concat     : {
            dist : {
                src  : ['<banner:meta.banner>', '<file_strip_banner:lib/<%= pkg.name %>.js>'],
                dest : 'dist/<%= pkg.name %>.js'
            }
        },
        min        : {
            dist : {
                src  : ['<banner:meta.banner>', '<config:concat.dist.dest>'],
                dest : 'dist/<%= pkg.name %>.min.js'
            }
        },
        test       : {
            files : ['test/**/*.js']
        },
        lint       : {
            files : ['grunt.js', 'lib/**/*.js', 'test/**/*.js']
        },
        watch      : {
            files : '<config:lint.files>',
            tasks : 'lint test'
        },
        jshint     : {
            options : {
                curly   : true,
                eqeqeq  : true,
                immed   : true,
                latedef : true,
                newcap  : true,
                noarg   : true,
                sub     : true,
                undef   : true,
                boss    : true,
                eqnull  : true
            },
            globals : {
                exports : true,
                module  : false
            }
        },
        uglify     : uglifyOptions,
        coffee     : {
            glob_to_multiple : {
                expand  : true,
                cwd     : COFFEE_SRC,
                src     : ['**/*.coffee'],
                dest    : COFFEE_TARGET,
                ext     : '.js',
                options : {
                    bare : true
                }
            }
        },
        watch      : {
            files : COFFEE_SRC + '/**/*',
            tasks : ['default']
        }
        
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');


    // Default task.
    grunt.registerTask('default', ['coffee', 'webmake', 'uglify']);


    grunt.registerTask('webmake', 'stitching commonjs modules for the client.', function () {
        var webmake = require('webmake');
        var fs = require('fs');
        var done = this.async();

        var jsSource = path.join(__dirname, COFFEE_TARGET, APP_FILE + '.js');

        webmake(jsSource, {  }, function (err, content) {
            if (err) {
                grunt.log.writeln('An error occurred processing the commonjs modules')
                return grunt.log.error(err.message);
            }

            if (!fs.existsSync(BUILD_PATH)) {
                fs.mkdirSync(BUILD_PATH);
            }

            fs.writeFile(BUILD_FILE, content, function (err) {
                if (err) console.log("error writing file: ", err);
                grunt.log.writeln('All done!');
                done();
            });
        });


    });
};
