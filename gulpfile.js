const gulp = require('gulp');
const coffee = require('gulp-coffee');
const handlebars = require('gulp-handlebars');
const wrap = require('gulp-wrap');
const declare = require('gulp-declare');

const paths = {
  coffee: 'scripts/**/*.coffee',
  templates: 'templates/**/*.handlebars',
  dist: 'dist'
};

function scripts() {
  return gulp.src(paths.coffee)
    .pipe(coffee())
    .pipe(gulp.dest(paths.dist));
}

function templates() {
  return gulp.src(paths.templates)
    .pipe(handlebars())
    .pipe(wrap('Handlebars.template(<%= contents %>)'))
    .pipe(declare({
      namespace: 'Handlebars.templates',
      noRedeclare: true
    }))
    .pipe(gulp.dest(paths.dist));
}

function html() {
  return gulp.src('index.html')
    .pipe(gulp.dest(paths.dist));
}

function watch() {
  gulp.watch(paths.coffee, scripts);
  gulp.watch(paths.templates, templates);
}

const build = gulp.parallel(scripts, templates, html);

exports.scripts = scripts;
exports.templates = templates;
exports.html = html;
exports.build = build;
exports.watch = gulp.series(build, watch);
exports.default = build;
