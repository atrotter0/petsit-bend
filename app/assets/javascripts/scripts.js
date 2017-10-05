function characterCounter(inputFieldId, maxChars, charDisplayDivId) {
  $(inputFieldId).keyup(function() {
    var length = $(this).val().length;
    $(charDisplayDivId).html(length + " / " + maxChars + " characters");
  });
}

$(document).ready(function() {
  characterCounter("#reservation_special_instructions", 250, "#instructions-count");
  characterCounter("#testimonial_body", 800, "#testimonials-count");

  $('#pet-list').multiSelect({
    selectionHeader: 'Selected',
    selectableHeader: 'Available'
  });
});