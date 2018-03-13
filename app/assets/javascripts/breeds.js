function checkPetType(pet) {
  if (pet == "Dog") {
    getPetData();
  } else {
    hideBreedGroup();
    clearBreedField();
  }
}

function getPetData() {
  $.ajax({
    url: "https://dog.ceo/api/breeds/list",
    success: function(data) {
      var dogList = data.message;
      capitalizeList(dogList);
      enableAwesome(dogList);
      displayBreedField();
    },
    error: function(err) {
      console.log(err);
    }
  })
}

function capitalizeList(list) {
  for(var i = 0; i < list.length; i++) {
    list[i] = list[i].capitalize();
  }
}

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function enableAwesome(list) {
  new Awesomplete('#breed-list', {
    minChars: 2,
    maxItems: 5,
    list: list
  });
}

function displayBreedField() {
  $('#breed-list').addClass('form-control');
  $('#pet-breed-group').css('display', 'block');
}

function hideBreedGroup() {
  $('#pet-breed-group').css('display', 'none');
}

function clearBreedField() {
  $('#pet_breed').val('');
}

$(document).ready(function() {
  hideBreedGroup();
  checkPetType($('#pet_pet_type').val());

  $('#pet_pet_type').change(function() {
    var selected = $(this).val();
    checkPetType(selected);
  });
});
