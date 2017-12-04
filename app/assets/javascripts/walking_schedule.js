function getPrefix(id) {
  var splitString = id.split('-');
  var value = splitString[0];
  return value;
}

function getSection(id, arrayPos) {
  var splitString = id.split('-');
  var section = splitString[arrayPos];
  return section;
}

function getTimeFromSelect(day, section) {
  var timeId = '#' + day + '-' + section + '-time-select-box';
  var periodId = '#' + day + '-' + section + '-period-select-box';
  var timeSelect = $(timeId).children('select');
  var periodSelect = $(periodId).children('select');
  var formattedTimeVal = timeSelect[0].value + ' ' + periodSelect[0].value;
  return formattedTimeVal;
}

function showTimeSelection(day) {
  var timeBoxId = '#' + day + '-time-select-box';
  $(timeBoxId).toggle('fast');
}

function displaySelectedTime(day, time, section, btnObject) {
  var check_one = $(btnObject).hasClass('add-time-clicked');
  var timeItemId = '#' + day + '-visit-' + section + '-schedule';
  if (check_one) {
    $(timeItemId).text(time).toggle('fast');
  } else {
    $(timeItemId).text('').toggle('fast');
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
  var petList = getValuesByClass('pet-name-selected');
  $('#walking_schedule_pet_list').val(petList);
  $('#reservation_pet_list').val(petList);
}

function getValuesByClass(className) {
  var elements = document.getElementsByClassName(className);
  var list = [];
  for (i = 0; i < elements.length; i++) {
    list.push($('#' + elements[i].id).text());
  }
  list = list.join(', ')
  return list;
}

function addTimeToInputField(day) {
  var timeList = getTimesByDay(day);
  $('#' + 'walking_schedule_' + day + '_times').val(timeList);
}

function getTimesByDay(day) {
  var time1 = $('#' + day + '-visit-1-schedule').text();
  var time2 = $('#' + day + '-visit-2-schedule').text();
  var time3 = $('#' + day + '-visit-3-schedule').text();
  var list = [];
  if (time1 != '') list.push(time1);
  if (time2 != '') list.push(time2);
  if (time3 != '') list.push(time3);
  list = list.join(', ')
  return list;
}

function stripAndDisableInputFields() {
  var idList = hiddenInputFields();
  for (i = 0; i < idList.length; i++) {
    $('#' + idList[i]).val('').addClass('disabled').attr('disabled', 'disabled');
  }
}

function enableHiddenFields() {
  var idList = hiddenInputFields();
  for (i = 0; i < idList.length; i++) {
    $('#' + idList[i]).removeClass('disabled').removeAttr('disabled');
  }
}

function hiddenInputFields() {
  var list = ["walking_schedule_pet_list", "reservation_pet_list", "walking_schedule_sunday_times", "walking_schedule_monday_times",
    "walking_schedule_tuesday_times", "walking_schedule_wednesday_times", "walking_schedule_thursday_times", "walking_schedule_friday_times",
      "walking_schedule_saturday_times"];
  return list;
}

$(document).ready(function() {
  stripAndDisableInputFields();

  $('.schedule-day-select-btn').click(function() {
    showTimeSelection(getPrefix(this.id));
    $(this).toggleClass('btn-toggle-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-plus').toggleClass('glyphicon glyphicon-minus');
  });

  $('.schedule-add-time-btn').click(function() {
    var day = getPrefix(this.id);
    var section = getSection(this.id, 2);
    var time = getTimeFromSelect(day, section);
    toggleBtnGlyphs(this);
    disableTimeSelect(day, section);
    displaySelectedTime(day, time, section, this);
    addTimeToInputField(day);
  });

  $('.schedule-add-pet-btn, .reservation-add-pet-btn').click(function() {
    var section = getSection(this.id, 0);
    toggleBtnGlyphs(this);
    highlightPetName(section);
    addPetsToInputField();
  });

  $('#dog-walking-submit, #reservation-submit').click(function() {
    enableHiddenFields();
  });
});
