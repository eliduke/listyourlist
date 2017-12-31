function flexText(element) {
  textAreaHeight = $(element).css("height").split("px")[0]
  if (element.scrollHeight > textAreaHeight) {
    $(element).css('height', element.scrollHeight + 'px');
  }
}

function flexTextAll() {
  $("textarea.flex-text").each(function(index, element) {
    flexText(element);

    $(element).on('input', function() {
      flexText(this);
    });
  });
}

function setCocoonCallback() {
  $(".links").on('cocoon:after-insert', function(e, insertedItem) {
    textArea = insertedItem.find(".js-list-item");
    textArea.attr("placeholder", "List Item " + $(".js-list-item").length);
    textArea.focus();
    textArea.on('input', function() {
      flexText(this);
    });
  });
}

$(function(){
  setCocoonCallback();
  flexTextAll();

  $("textarea.flex-text").focus(function() {
    // hack for putting cursor at the end when clicking or hitting enter
    // doesn't work for tabbing in for some reason. TODO figure that out
    input = $(this);
    var tmpStr = input.val();
    input.val('');
    input.val(tmpStr);
  });

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

    flexTextAll();
    setCocoonCallback();
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

  $("form.js-list-form").keyup(function (e) {
    if (e.which == 9) {
      $(document.activeElement).select();
    }
  });

  $(".js-form-help").click(function(e) {
    e.preventDefault();
    $(".form-help").toggle();
  });
});
