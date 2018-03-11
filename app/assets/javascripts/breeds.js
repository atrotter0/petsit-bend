function hideBreedGroup() {
  $('#pet-breed-group').css('display', 'none');
}

function checkPetType(pet) {
  if (pet == "Dog") {
    $('#pet-breed-group').css('display', 'block');
  } else {
    hideBreedGroup();
  }
}

$(document).ready(function() {
  hideBreedGroup();

  $('#pet_pet_type').change(function() {
    var selected = $(this).val();
    checkPetType(selected);
  });

});