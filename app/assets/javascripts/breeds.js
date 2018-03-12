function hideBreedGroup() {
  $('#pet-breed-group').css('display', 'none');
}

function checkPetType(pet) {
  if (pet == "Dog") {
    $('#pet-breed-group').css('display', 'block');
    getPetData();
  } else {
    hideBreedGroup();
  }
}

function getPetData() {
  $.ajax({
    url: "https://dog.ceo/api/breeds/list",
    success: function(data) {
      var dogList = data.message;
      addDogs(dogList);
    },
    error: function(err) {
      console.log(err);
    }
  })
}

function addDogs(list) {
  for(var i = 0; i < list.length; i++) {
    $('#dogDataList').append('<option>' + list[i].capitalize() + '</option>');
  }
}

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).ready(function() {
  checkPetType($('#pet_pet_type').val());

  $('#pet_pet_type').change(function() {
    var selected = $(this).val();
    checkPetType(selected);
  });

});