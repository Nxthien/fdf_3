// This is a manifest file that"ll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin"s vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It"s not advisable to add code directly here, but if you do, it"ll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

var popup = function(){
  $(".td-atm").on("click", function(){
    $(".atm-cart").addClass("block");
  });
  $(".icon").on("click", function(){
    $(".atm-cart").removeClass("block");
  });
};

$(document).ready(popup);
$(document).on("page:load", popup);

var nice = function(){
  $("html").niceScroll({
    cursorwidth: "8px",
  });
};

$(document).ready(nice);
$(document).on("page:load", nice);
$(window).ready(nice);

var box = function(){
  $(".box").on("click", function(){
    $(".suggestion-box").toggleClass("filout");
  });
};

$(document).ready(box);
$(document).on("page:load", box);

var hover = function(){
  $("#rate-2").hover(function(){
    $("#rate-2 .star").before().toggleClass("color-hover");
    $("#rate-1 .star").before().toggleClass("color-hover");
  });
  $("#rate-3").hover(function(){
    $("#rate-2 .star").before().toggleClass("color-hover");
    $("#rate-1 .star").before().toggleClass("color-hover");
    $("#rate-3 .star").before().toggleClass("color-hover");
  });
  $("#rate-4").hover(function(){
    $("#rate-2 .star").before().toggleClass("color-hover");
    $("#rate-1 .star").before().toggleClass("color-hover");
    $("#rate-3 .star").before().toggleClass("color-hover");
    $("#rate-4 .star").before().toggleClass("color-hover");
  });
  $("#rate-5").hover(function(){
    $("#rate-2 .star").before().toggleClass("color-hover");
    $("#rate-1 .star").before().toggleClass("color-hover");
    $("#rate-3 .star").before().toggleClass("color-hover");
    $("#rate-4 .star").before().toggleClass("color-hover");
    $("#rate-5 .star").before().toggleClass("color-hover");
  });
};
$(document).ready(hover);
$(document).on("page:load", hover);
