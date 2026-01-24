$(document).ready(function(){

    $('label').click(function(){
        $('.event_year>li').removeClass('current');
        $(this).parent('li').addClass('current');
        var year = $(this).attr('for');
        $('#'+year).parent().prevAll('div').slideUp(800);
        $('#'+year).parent().slideDown(800).nextAll('div').slideDown(800);
    });


    var listCheckBox = $(".list-checkbox");
    var listCheckBoxImg = ["../img/check.png","../img/checked.png"];

    listCheckBox.on("click",function(){
        $(this).attr("src",listCheckBoxImg[1]);
        $(this).parent().parent().siblings().children().children(".list-checkbox").attr("src",listCheckBoxImg[0]);
        console.log($(this).parent().parent().siblings().children().children(".list-checkbox"))
    })

})