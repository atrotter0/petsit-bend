function getPrefix(id) {
  var splitString = id.split('-');
  var value = splitString[0];
  console.log(value);
  return value;
}

function showTimeBox(day) {
  var timeBoxId = '#' + day + '-time-select-box';
  console.log('toggling: ' + timeBoxId);
  $(timeBoxId).toggle('fast');
}

function addToSchedule(day) {
  var currentVal = $('#sunday-schedule').text();
  console.log(currentVal);
  $('#sunday-schedule').text(currentVal + 'noob');
}

$(document).ready(function() {
  $('#sunday-button, #monday-button').click(function() {
    showTimeBox(getPrefix(this.id));
    $(this).toggleClass('btn-toggle-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-plus').toggleClass('glyphicon glyphicon-minus');
  });

  $('#sunday-visit-1-btn, #sunday-visit-2-btn').click(function() {
    addToSchedule(getPrefix(this.id));
    $(this).toggleClass('btn-primary').toggleClass('add-time-clicked');
    $(this).children('span').toggleClass('glyphicon glyphicon-ok').toggleClass('glyphicon glyphicon-remove');
  });
});