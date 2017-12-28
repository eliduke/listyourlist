// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $(".js-switch-list-type").change(function() {
    existingItems = []

    $('.list-item').each(function() {
      existingItems.push(this.value);
    });

    if (this.value === "false") {
      $("#list ol").replaceWith($('<ul id="items">'+$("#list ol").html()+'</ul>'));
    } else {
      $("#list ul").replaceWith($('<ol id="items">'+$("#list ul").html()+'</ol>'));
    }

    $('.list-item').each(function(index) {
      $(this).val(existingItems[index]);
    });
  });

  $("form.js-list-form").keydown(function (e) {
    // !e.altKey gives us two awesome things:
    // -> option + enter for line breaks in description
    // -> option + enter submits form in title or items
    if (e.which == 13 && !e.altKey) {
      e.preventDefault();

      itemInputs = $(".list-item");

      if (document.activeElement === document.getElementById("list_title")) {
        document.getElementById("list_description").focus();
      } else if (document.activeElement === document.getElementById("list_description")) {
        $(".list-item").first().focus();
      } else if (itemInputs.last().is(":focus")) {
        if (itemInputs.last().val().length > 0) {
          $("a.add_fields")[0].click();
          $(".list-item").last().focus();
        }
      } else {
        current_position = $(".list-item").index(document.activeElement);
        $(".list-item")[current_position + 1].focus();
      }
    }
  });

  // TODO I don't know why this does what it does, but it makes
  // the 'after-insert' callback work. Figure it out.
  $(".links").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $(".links").on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find(".list-item").attr("placeholder", "List Item " + $(".list-item").length);
  });
});
