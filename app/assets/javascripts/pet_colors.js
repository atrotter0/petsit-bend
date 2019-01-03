var DEACTIVE_SECONDARY_COLOR = 'E240E4';

function checkPetSecondaryColor() {
  if ($('#pet_secondary_color').val() === DEACTIVE_SECONDARY_COLOR) {
    deactivatePetColor();
  } else {
    activatePetColor();
  }
}

function activatePetColor() {
  $('.secondary-color-block').show();
  $('.secondary-color-btn')
    .addClass('active-color')
    .addClass('glyphicon glyphicon-minus')
    .removeClass('glyphicon glyphicon-plus')
    .text(' Remove Secondary Color');
}

function deactivatePetColor() {
  $('.secondary-color-block').hide();
  $('.secondary-color-btn')
    .removeClass('active-color')
    .addClass('glyphicon glyphicon-plus')
    .removeClass('glyphicon glyphicon-minus')
    .text(' Add Secondary Color');
  $('#pet_secondary_color').val(DEACTIVE_SECONDARY_COLOR);
}

$(document).ready(function() {
  checkPetSecondaryColor();

  $('.secondary-color-btn').click(function(e) {
    e.preventDefault();

    if ($(this).hasClass('active-color')){
      deactivatePetColor();
    } else {
      activatePetColor();
      // Explicitly setting css styles to override inline-styles of color picker.
      $('#pet-color-btn-two').css('background-color', 'rgb(255,255,255)').css('color', '#ffffff');
    }
  });
});
