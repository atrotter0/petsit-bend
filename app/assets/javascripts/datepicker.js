$(document).on('ready page:load', function() {
  $('.datepicker').datepicker({
    dateFormat: 'mm/dd/yy',
    minDate: 0,
    maxDate: '+1Y'
  });
});
