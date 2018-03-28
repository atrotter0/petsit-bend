function checkPetType(pet) {
  if (pet == "Dog") {
    getDogBreeds();
  } else {
    hideBreedGroup();
    clearBreedField();
  }
}

function getDogBreeds() {
  $.ajax({
    url: "https://dog.ceo/api/breeds/list/all",
    success: function(data) {
      var breedList = createBreedList(data.message);
      enableAwesome(breedList);
      displayBreedField();
    },
    error: function(err) {
      console.log(err);
    }
  })
}

function createBreedList(breeds) {
  var list = [];
  Object.keys(breeds).forEach(function(key) {
    if (breeds[key] != "") {
      fullBreedName(breeds[key], key, list);
    } else {
      list.push(key.capitalize());
    }
  });
  return list;
}

function fullBreedName(subBreedList, breed, list) {
  for(var i = 0; i < subBreedList.length; i++) {
    var name = subBreedList[i].capitalize() + " " + breed.capitalize();
    list.push(name);
  }
}

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

function enableAwesome(list) {
  new Awesomplete('#breed-list', {
    minChars: 2,
    maxItems: 8,
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
