$(function () {
    var cube = new Cubist(document.getElementById('cubist'), {isRotatedVertically : false});

    $('#cube-nav').on('click', 'ul li a', function (e) {
        e.preventDefault();
        i = $('#cube-nav').find('ul li a').index(this);
        cube.goto(i);
    }).on('click', '.next', function (e) {
        e.preventDefault();
        cube.next();
    }).on('click', '.prev', function (e) {
        e.preventDefault();
        cube.previous();
    }).on('click', '.first', function (e) {
        e.preventDefault();
        cube.first();
    }).on('click', '.last', function (e) {
        e.preventDefault();
        cube.last();
    });
}());