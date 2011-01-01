// FORM PLACEHOLDER
$(document).ready(function () {
  placeholder();
  $("input[type=text], input[type=password], textarea").focusin(function () {
    var phvalue = $(this).attr("placeholder");
    if (phvalue == $(this).val()) {
      $(this).val("");
    }
  });
  $("input[type=text], input[type=password], textarea").focusout(function () {
    var phvalue = $(this).attr("placeholder");
    if ($(this).val() == "") {
      $(this).val(phvalue);
    }
  });

  // Tooltip
  xOffset = 15;
  yOffset = -15;
  var t;
  $(".tooltip").mouseover(function (e) {
    t = this.title;
    this.title = "";
    $("body").append("<p id='stdTooltip'>" + t + "</p>");
    $("#stdTooltip")
      .css("top", (e.pageY - yOffset) + "px")
      .css("left", (e.pageX + xOffset) + "px")
      .show();
  });
  $(".tooltip").mouseout(function (e) {
    this.title = t;
    $("#stdTooltip").remove();
  });
  $(".tooltip").mousemove(function (e) {
    $("#stdTooltip")
      .css("top", (e.pageY - yOffset) + "px")
      .css("left", (e.pageX + xOffset) + "px");
  });
});


function placeholder() {
  $("input[type=text], input[type=password], textarea").each(function () {
    if ($(this).attr("value") == "") {
      var phvalue = $(this).attr("placeholder");
      $(this).val(phvalue);
    }
  });
}