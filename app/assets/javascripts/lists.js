// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

  $("#bullets").click(function(){

    $("#bullets").addClass("selected");
    $("#numbers").removeClass("selected");
    $("#list ol").replaceWith($('<ul>'+$("#list ol").html()+'</ul>'));

    return false;
  });

  $("#numbers").click(function(){

    $("#bullets").removeClass("selected");
    $("#numbers").addClass("selected");
    $("#list ul").replaceWith($('<ol>'+$("#list ul").html()+'</ol>'));

    return false;
  });

});