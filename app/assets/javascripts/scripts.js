function characterCounter(inputFieldId, maxChars, charDisplayDivId) {
  $(inputFieldId).keyup(function() {
    var length = $(this).val().length;
    $(charDisplayDivId).html(length + " / " + maxChars + " characters");
  });
}

function phoneNumberFormatter(inputFieldId) {
  $(inputFieldId).keyup(function(evt) {
    if (keyCodeValid(evt) == true) {
      var input = formatPhone(this);
      $(inputFieldId).val(input);
    }
  });
}

function keyCodeValid(event) {
  //check for backspace or delete keys pressed
  if (event.keyCode == 8 || event.keyCode == 46) {
    return false;
  } else {
    return true;
  }
}

function formatPhone(target) {
  var input = $(target).val();
  var length = $(target).val().length
  input = input.replace(/\D/g,'');

  if (length == 0) {
    input = input;
  } else if (length < 4) {
    input = '(' + input;
  } else if (length < 6) {
    input = '(' + input.substring(0,3) + ') ' + input.substring(3,6);
  } else {
    input = '('+ input.substring(0,3) + ') ' + input.substring(3,6) + '-' + input.substring(6,10);
  }
  return input;
}

function flashDisplay() {
  $('#flash').fadeOut(10).delay(1100).slideDown(900).delay(5000).fadeOut(3000);
}

$(document).ready(function() {
  characterCounter("#reservation_special_instructions", 250, "#instructions-count");
  characterCounter("#testimonial_body", 800, "#testimonials-count");
  characterCounter("#lead_message", 300, "#contact-count");
  phoneNumberFormatter("#user_phone");
  phoneNumberFormatter("#lead_phone");
  flashDisplay();

  $('#pet-list, #user-list').multiSelect({
    selectionHeader: 'Selected',
    selectableHeader: 'Available'
  });

  $('.faq-slide-click, .faq-open-close-icon').click(function() {
    $('.faq-slide').slideToggle('slow');
    $('.faq-open-close-icon').children('span').toggleClass('glyphicon glyphicon-plus').toggleClass('glyphicon glyphicon-minus');
  });
});
