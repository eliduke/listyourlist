// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

  $("#list_title").focus();

  $("#bullets").click(function(){
    $("#bullets").addClass("selected");
    $("#numbers").removeClass("selected");
    $("#list ol").replaceWith($('<ul id="list_items">'+$("#list ol").html()+'</ul>'));
    return false;
  });

  $("#numbers").click(function(){
    $("#bullets").removeClass("selected");
    $("#numbers").addClass("selected");
    $("#list ul").replaceWith($('<ol id="list_items">'+$("#list ul").html()+'</ol>'));
    return false;
  });

  $("#comments_on").click(function(){
    $("#comments_on").addClass("selected");
    $("#comments_off").removeClass("selected");
    return false;
  });

  $("#comments_off").click(function(){
    $("#comments_off").addClass("selected");
    $("#comments_on").removeClass("selected");
    return false;
  });

  $("form").keydown(function (e) {
    if (e.keyCode == 13) {
      return false;
    }
  });

  $("form").keydown(function (e) {
    if (e.keyCode == 13) {
      inputs = $("#list_items li");
      new_input = '<li><input class="form-control input-lg" placeholder="Type and Press ENTER" type="text" name="list[item]" id="list_item_' + (inputs.length + 1) + '" /></li>';
      $("#list_items").append(new_input);
      $("#list_item_" + inputs.length).attr("placeholder", "Item " + inputs.length);
      $("#list_item_" + (inputs.length + 1)).focus();
      return false;
    }
  });

});