var path = require('path');

var APP_FILE = 'cubist';
var COFFEE_SRC = 'lib';
var COFFEE_TARGET = 'src';
var BUILD_TARGET = 'public';

var BUILD_PATH     = path.join(__dirname, BUILD_TARGET);
var BUILD_FILE     = path.join(BUILD_PATH, APP_FILE + '.js');
var BUILD_MIN_FILE = path.join(__dirname, BUILD_TARGET, APP_FILE + '.min.js')
var uglifyOptions = {
    mini : {
        files : {}
    }
};

uglifyOptions.mini.files[BUILD_MIN_FILE] = BUILD_FILE;

module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg     : '<json:package.json>',
        meta    : {
            banner : '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
                '<%= pkg.homepage ? "* " + pkg.homepage + "\n" : "" %>' +
                '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
                ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */'
        },
        concat  : {
            dist : {
                src  : ['<banner:meta.banner>', '<file_strip_banner:lib/<%= pkg.name %>.js>'],
                dest : 'dist/<%= pkg.name %>.js'
            }
        },
        min     : {
            dist : {
                src  : ['<banner:meta.banner>', '<config:concat.dist.dest>'],
                dest : 'dist/<%= pkg.name %>.min.js'
            }
        },
        test    : {
            files : ['test/**/*.js']
        },
        lint    : {
            files : ['grunt.js', 'lib/**/*.js', 'test/**/*.js']
        },
        watch   : {
            files : '<config:lint.files>',
            tasks : 'lint test'
        },
        jshint  : {
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
        uglify  : uglifyOptions,
        coffee  : {
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
        watch   : {
            coffee  : {
                files : COFFEE_SRC + '/**/*',
                tasks : ['default']
            },
            compass : {
                files : [ 'scss/**/*' ],
                tasks : [ 'compass' ]
            }
        },
        compass : {
            dev  : {
                src            : 'scss',
                dest           : 'public/css',
                linecomments   : true,
                forcecompile   : true,
                require        : [],
                debugsass      : true,
                relativeassets : true
            },
            prod : {
                src            : 'scss',
                dest           : 'public/css/min',
                outputstyle    : 'compressed',
                linecomments   : false,
                forcecompile   : true,
                require        : [],
                debugsass      : false,
                relativeassets : true
            }
        },
        concat  : {
            options : {
                separator : ';'
            },
            min    : {
                src  : ['vendor/jquery-1.9.1.min.js','vendor/jquery.transit.min.js',BUILD_MIN_FILE],
                dest : path.join(BUILD_PATH,APP_FILE + '.all.min.js')
            },
            normal    : {
                src  : ['vendor/jquery-1.9.1.min.js','vendor/jquery.transit.min.js',BUILD_FILE],
                dest : path.join(BUILD_PATH,APP_FILE + '.all.js')
            }
        }

    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-compass');


    // Default task.
    grunt.registerTask('default', ['coffee', 'webmake', 'uglify','concat']);


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
