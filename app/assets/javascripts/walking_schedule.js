function getPrefix(id) {
  var splitString = id.split('-');
  var value = splitString[0];
  //console.log(value);
  return value;
}

function getSection(id, arrayPos) {
  var splitString = id.split('-');
  var section = splitString[arrayPos];
  //console.log(section);
  return section;
}

function getTimeFromSelect(day, section) {
  var timeId = '#' + day + '-' + section + '-time-select-box';
  var periodId = '#' + day + '-' + section + '-period-select-box';
  var timeSelect = $(timeId).children('select');
  var periodSelect = $(periodId).children('select');
  var formattedTimeVal = timeSelect[0].value + ' ' + periodSelect[0].value;
  console.log(formattedTimeVal);
  return formattedTimeVal;
}

function showTimeSelection(day) {
  var timeBoxId = '#' + day + '-time-select-box';
  console.log('toggling: ' + timeBoxId);
  $(timeBoxId).toggle('fast');
}

function addTime(day, time, section, btnObject) {
  var check_one = $(btnObject).hasClass('add-time-clicked');
  var timeItemId = '#' + day + '-visit-' + section + '-schedule';
  if (check_one) {
    $(timeItemId).text(time).toggle('fast');
  } else {
    $(timeItemId).toggle('fast');
  }
}

function disableTimeSelect(day, section) {
  var timeId = '#' + day + '-' + section + '-time-select-box';
  var periodId = '#' + day + '-' + section + '-period-select-box';
  if ($(timeId).children('select').hasClass('disabled')) {
    $(timeId).children('select').removeClass('disabled').removeAttr('disabled');
    $(periodId).children('select').removeClass('disabled').removeAttr('disabled');
  } else {
    $(timeId).children('select').addClass('disabled').attr('disabled', 'disabled');
    $(periodId).children('select').addClass('disabled').attr('disabled', 'disabled');
  }
}

function toggleBtnGlyphs(btnObject) {
  $(btnObject).toggleClass('btn-primary').toggleClass('add-time-clicked');
  $(btnObject).children('span').toggleClass('glyphicon glyphicon-plus-sign').toggleClass('glyphicon glyphicon-remove');
}

function highlightPetName(section) {
  var nameId = '#' + section + '-pet-name';
  $(nameId).toggleClass('pet-name-selected');
}

function addPetsToInputField() {
  var petList = getPetNames();
  $('#walking_schedule_pet_list').val(petList);
}

function getPetNames() {
  var elements = document.getElementsByClassName('pet-name-selected');
  var list = [];
  for (i = 0; i < elements.length; i++) {
    list.push($('#' + elements[i].id).text());
  }
  list = list.join(', ')
  return list;
}

$(document).ready(function() {
  $('#sunday-button, #monday-button').click(function() {
    showTimeSelection(getPrefix(this.id));
    $(this).toggleClass('btn-toggle-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-plus').toggleClass('glyphicon glyphicon-minus');
  });

  $('#sunday-visit-1-btn, #sunday-visit-2-btn, #sunday-visit-3-btn').click(function() {
    var day = getPrefix(this.id);
    var section = getSection(this.id, 2);
    var time = getTimeFromSelect(day, section);
    toggleBtnGlyphs(this);
    disableTimeSelect(day, section);
    addTime(day, time, section, this);
  });

  $('#0-btn-add-pet, #1-btn-add-pet, #2-btn-add-pet, #3-btn-add-pet, #4-btn-add-pet, #5-btn-add-pet, #6-btn-add-pet, #7-btn-add-pet, #8btn-add-pet, #9-btn-add-pet').click(function() {
    var section = getSection(this.id, 0);
    toggleBtnGlyphs(this);
    highlightPetName(section);
    addPetsToInputField();
  });
});
