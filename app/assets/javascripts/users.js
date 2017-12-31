// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  $('#remember_me').change(function() {
    if(this.checked) {
      $(".js-remember-me-unchecked").hide();
      $(".js-remember-me-checked").show();
    } else {
      $(".js-remember-me-unchecked").show();
      $(".js-remember-me-checked").hide();
    }
  });
});
