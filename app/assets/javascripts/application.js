// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(".recipe-contents__items").on("mouseover", function() {
    $(".recipe-contents__bean-tit", this).css("color", "#fff");
  }).on("mouseout", function() {
    $(".recipe-contents__bean-tit", this).css("color", "black");
  });

  $('.header__menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('.nav').fadeToggle();
    event.preventDefault();
  });

  $('.header__search').on('click', function(event) {
    $('.recipe-contents__search-bar').toggleClass('active');
    $('.header__overlay').toggleClass('open');
  });

  $('.header__overlay').on('click',function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('.recipe-contents__search-bar').removeClass('active');
    }
  });

});


