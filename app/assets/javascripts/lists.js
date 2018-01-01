function flexText(element) {
  // Grabs existing textarea height
  textAreaHeight = $(element).css("height").split("px")[0]

  // Resizes if the scroll height exceeds existing textarea height
  if (element.scrollHeight > textAreaHeight) {
    $(element).css('height', element.scrollHeight + 'px');
  }
}

function flexTextAll() {
  $("textarea.flex-text").each(function(index, element) {
    // Resizes all existing textareas with current text
    flexText(element);

    // Sets listener on all existing textareas for future text increases
    $(element).on('input', function() {
      flexText(this);
    });
  });
}

function setListenersForAddingNewItem() {
  $(".links").on('cocoon:after-insert', function(e, newItemFields) {
    // Sets correctly incremented placeholder text and moves focus
    textArea = newItemFields.find("textarea");
    textArea.attr("placeholder", "List Item " + $(".js-list-item").length);
    textArea.focus();

    // Sets flexText listener on new textarea
    textArea.on('input', function() {
      flexText(this);
    });
  });
}

$(function(){
  flexTextAll();
  setListenersForAddingNewItem();

  $(".js-switch-list-type").change(function() {
    existingItems = []

    $('.js-list-item').each(function() {
      existingItems.push(this.value);
    });

    if (this.value === "false") {
      $("#list ol").replaceWith($('<ul id="items">'+$("#list ol").html()+'</ul>'));
    } else {
      $("#list ul").replaceWith($('<ol id="items">'+$("#list ul").html()+'</ol>'));
    }

    $('.js-list-item').each(function(index) {
      $(this).val(existingItems[index]);
    });

    // Switching out the entire list contents removes all listeners
    // This resets all the necessary listeners
    flexTextAll();
    setListenersForAddingNewItem();
  });

  $("form.js-list-form").keydown(function (e) {
    // && !e.altKey gives us two awesome things:
    // -> option + enter for line breaks in description
    // -> option + enter submits form in title or items
    if (e.which == 13) {
      e.preventDefault();

      itemInputs = $(".js-list-item");

      if (document.activeElement === document.getElementById("list_title")) {
        document.getElementById("list_description").focus();
      } else if (document.activeElement === document.getElementById("list_description")) {
        $(".js-list-item").first().focus();
      } else if (itemInputs.last().is(":focus")) {
        if (itemInputs.last().val().length > 0) {
          $("a.add_fields")[0].click();
        }
      } else {
        current_position = $(".js-list-item").index(document.activeElement);
        $(".js-list-item")[current_position + 1].focus();
      }
    }
  });


  // Moves cursor to the end of a flex text when clicking or hitting enter
  // This doesn't work for tabbing in for some reason. TODO figure that out
  $("textarea.flex-text").focus(function() {
    input = $(this);
    var tmpStr = input.val();
    input.val('');
    input.val(tmpStr);
  });

  // Highlights all text in a field when tabbing into it because the above
  // function isn't working for tabbing. Figured this was better than nothing.
  $("form.js-list-form").keyup(function (e) {
    if (e.which == 9) {
      $(document.activeElement).select();
    }
  });

  // Toggles form help info 🤔
  $(".js-form-help").click(function(e) {
    e.preventDefault();
    $(".form-help").toggle();
  });
});

// TODO I want smarter item delete confirmation dialogues.
// This was an attempt but didn't work quite well
//
// function setItemDeleteConfirmation(element) {
//   $(element).click(function() {
//     if ($(element).siblings().find("textarea").val().length > 0) {
//       response = confirm("Are you sure you want to delete this item?");
//       if (response == false) {
//         return false;
//       }
//     }
//   });
// }
//
// function setItemDeleteConfirmationAll() {
//   $("a.remove_fields").each(function(index, element) {
//     setItemDeleteConfirmation(element);
//   });
// }
