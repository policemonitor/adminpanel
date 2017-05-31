$(function () {
    $('#crews').dataTable();
    $('#crews').removeClass('display').addClass('table table-striped table-bordered');

    $('.dataTables_filter input[type="search"]').attr('class', 'form-control').attr('placeholder', 'Введіть інформацію для пошуку').css({
        'width': '450px',
        'height': '45px',
        'display': 'inline-block',
        'border-radius': '0px'
    });

    $('[data-toggle="popover"]').popover();

    $("#search-icon").click(function(){
        $(".search-panel").animate({width:'toggle'},450);
    });
});

