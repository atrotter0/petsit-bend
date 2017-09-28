$(document).ready(function() {
  $("#reservation_special_instructions").keyup(function() {
    var length = $(this).val().length;
    $("#instructions-count").html(length + " / 250 characters");
  });
});