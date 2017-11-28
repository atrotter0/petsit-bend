function getPrefix(id) {
  var splitString = id.split('-');
  var value = splitString[0];
  //console.log(value);
  return value;
}

function getSection(id) {
  var splitString = id.split('-');
  var section = splitString[2];
  //console.log(section);
  return section;
}

function getTimeFromSelect(day, section) {
  var timeId = '#' + day + '-' + section + '-time-select-box';
  var periodId = '#' + day + '-' + section + '-period-select-box';
  var timeSelect = $(timeId).children('select');
  var periodSelect = $(periodId).children('select');
  var finalTimeVal = timeSelect[0].value + ' ' + periodSelect[0].value;
  console.log(finalTimeVal);
  return finalTimeVal;
}

function showTimeBox(day) {
  var timeBoxId = '#' + day + '-time-select-box';
  console.log('toggling: ' + timeBoxId);
  $(timeBoxId).toggle('fast');
}

function addToSchedule(day, time, object) {
  if (object.hasClass('add-time-clicked')) {
    console.log('do smething');
  } else {
    console.log('do something else');
  }
}

$(document).ready(function() {
  $('#sunday-button, #monday-button').click(function() {
    showTimeBox(getPrefix(this.id));
    $(this).toggleClass('btn-toggle-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-plus').toggleClass('glyphicon glyphicon-minus');
  });

  $('#sunday-visit-1-btn, #sunday-visit-2-btn').click(function() {
    var day = getPrefix(this.id);
    var section = getSection(this.id);
    var time = getTimeFromSelect(day, section);
    addToSchedule(day, time, this);
    $(this).toggleClass('btn-primary').toggleClass('add-time-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-ok').toggleClass('glyphicon glyphicon-remove');
  });
});
