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

  $(".recipe-order-new__items").on("mouseover", function() {
    $(".recipe-order-new__bean-tit", this).css("color", "#fff");
  }).on("mouseout", function() {
    $(".recipe-order-new__bean-tit", this).css("color", "black");
  });

  $(".recipe-rank-items__items").on("mouseover", function() {
    $(".recipe-rank-items__bean-tit", this).css("color", "#fff");
  }).on("mouseout", function() {
    $(".recipe-rank-items__bean-tit", this).css("color", "black");
  });

  $('.header__menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('.nav').fadeToggle();
    event.preventDefault();
  });

  $('.recipe-contents__search-icon-wrapper').on('click', function(event) {
    $('.recipe-contents__search-bar').toggleClass('active');
    $('.header__overlay-search').toggleClass('open');
     $('.recipe-contents__search-icon-wrapper').fadeOut();
  });

  $('.header__overlay-search').on('click',function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('.recipe-contents__search-bar').removeClass('active');
      $('.recipe-contents__search-icon-wrapper').fadeIn();
    }
  });

   $('.recipe-show__profile-icon-wrapper').on('click', function(event) {
    $('.profile').toggleClass('active');
    $('.header__overlay-profile').toggleClass('open');
  });

  $('.header__overlay-profile').on('click',function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('.profile').removeClass('active');
    }
  });
});
