$(function () {
    
    var cube = new Cubist(document.getElementById('cubist'), {isRotatedVertically : false}),
        $pages = $('.page'),
        onResize;

    $pages.css({
        transformOrigin : '0 0'
    });

    onResize = function () {
        $pages.each(function () {
            var $page = $(this),
                $parent = $page.parent(),
                aWidth = $parent.width(),
                aHeight = $parent.height(),
                pageWidth = $page.width(),
                pageHeight = $page.height(),
                scale,
                offsetLeft;

            scale = aWidth / pageWidth;
            if (pageHeight * scale > aHeight) {
                scale = aHeight / pageHeight
            }

            offsetLeft = - (pageWidth / 2);

            $page.css({
                transform  : 'scale(' + scale + ',' + scale + ') translateX(' + offsetLeft + 'px)',
                marginLeft: '50%'
                
            })
        });
    };

    $('#cube-nav').on('click', 'ul li a',function (e) {
        e.preventDefault();
        i = $('#cube-nav').find('ul li a').index(this);
        cube.goto(i);
    }).on('click', '.next',function (e) {
            e.preventDefault();
            cube.next();
        }).on('click', '.prev',function (e) {
            e.preventDefault();
            cube.previous();
        }).on('click', '.first',function (e) {
            e.preventDefault();
            cube.first();
        }).on('click', '.last', function (e) {
            e.preventDefault();
            cube.last();
        });


    $(window).resize(onResize);
    //give prism some time
    window.setTimeout(function(){
        onResize();
    }),500;
}());