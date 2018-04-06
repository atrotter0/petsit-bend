var DEACTIVE_COLOR_VAL = 'E240E4';

function checkPetSecondaryColor() {
  if ($('#pet_secondary_color').val() != DEACTIVE_COLOR_VAL) {
    activatePetColor();
  } else {
    deactivatePetColor();
  }
}

function activatePetColor() {
  $('.secondary-color-block').css('display', 'block');
  $('.add-secondary-color-btn').addClass('active-color').addClass('glyphicon glyphicon-minus')
    .removeClass('glyphicon glyphicon-plus').text(' Remove Secondary Color');
}

function deactivatePetColor() {
  $('.secondary-color-block').css('display', 'none');
  $('.add-secondary-color-btn').removeClass('active-color').addClass('glyphicon glyphicon-plus')
    .removeClass('glyphicon glyphicon-minus').text(' Add Secondary Color');
  $('#pet_secondary_color').val(DEACTIVE_COLOR_VAL);
}

$(document).ready(function() {
  checkPetSecondaryColor();

  $('.add-secondary-color-btn').click(function(e) {
    e.preventDefault();
    if ($(this).hasClass('active-color')){
      deactivatePetColor();
    } else {
      activatePetColor();
      $('#pet-color-btn-two').css('background-color', 'rgb(0,0,0)').css('color', '#ffffff').val('000000');
    }
  });
});
