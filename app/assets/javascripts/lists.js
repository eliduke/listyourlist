function flexText(element) {
  if ($(element).is(".description") && (element.scrollHeight > 100)) {
    $(element).css('height', element.scrollHeight + 'px');
  }

  textAreaHeight = $(element).css("height").split("px")[0];

  if (!$(element).is(".description") && element.scrollHeight != textAreaHeight) {
    $(element).css('height', element.scrollHeight + 'px');
  }
}

function flexTextAll() {
  $("textarea.flex-text").each(function(index, element) {
    // Resizes all existing textareas with current text
    flexText(element);

    // Sets listener on all existing textareas for future text adjustments
    $(element).on('input', function() {
      flexText(this);
    });
  });
}

function setListenersForAddingNewItem() {
  $(".links").on('cocoon:after-insert', function(e, newItemFields) {
    // Sets incremented placeholder text and moves focus
    textArea = newItemFields.find("textarea");
    textArea.attr("placeholder", "List Item " + $(".js-list-item").length);
    textArea.focus();

    // Sets flexText listener on the new textarea
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
      $(".list ol").replaceWith($('<ul id="items">'+$(".list ol").html()+'</ul>'));
    } else {
      $(".list ul").replaceWith($('<ol id="items">'+$(".list ul").html()+'</ol>'));
    }

    $('.js-list-item').each(function(index) {
      $(this).val(existingItems[index]);
    });

    // Switching out the entire list contents removes all listeners
    // This resets all the necessary listeners
    flexTextAll();
    setListenersForAddingNewItem();
  });

  $(".js-switch-list-status").change(function() {
    if (this.value === "publik") {
      $(".status-help-text-publik").show();
      $(".status-help-text-secret").hide();
      $(".status-help-text-priv8").hide();
      $(".secret-link").hide();
    } else if (this.value === "secret") {
      $(".status-help-text-publik").hide();
      $(".status-help-text-secret").show();
      $(".status-help-text-priv8").hide();
      $(".secret-link").show();
    } else if (this.value === "priv8") {
      $(".status-help-text-publik").hide();
      $(".status-help-text-secret").hide();
      $(".status-help-text-priv8").show();
      $(".secret-link").hide();
    }
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
  $("form.js-list-form").keyup(function(e) {
    if (e.which == 9) {
      $(document.activeElement).select();
    }
  });

  // Toggles form help info 🤔
  $(".js-form-help").click(function(e) {
    e.preventDefault();
    $(".form-help").toggle();
  });

  $("#private_link").keydown(function(e) {
    e.preventDefault();
  });

  $('#secret_link').click(function() {
    input = this
    iOS = navigator.userAgent.match(/ipad|iphone/i);

    if (iOS) {
      editable = input.contentEditable;
      readOnly = input.readOnly;

      input.contentEditable = true;
      input.readOnly = false;

      range = document.createRange();
      range.selectNodeContents(input);

      selection = window.getSelection();
      selection.removeAllRanges();
      selection.addRange(range);

      input.setSelectionRange(0, 999999);
      input.contentEditable = editable;
      input.readOnly = readOnly;
    } else {
      input.select();
    }

    document.execCommand('copy');
    $(input).next().text("COPIED! 👍🏼 Share wisely.");
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
