$(document).ready(function() {
	$('.delete_post').bind('ajax:success', function() {
	  $(this).closest('div').fadeOut(500);
	});
});


$(document).ready(function () {
  // hide editing fields
  //$("#projectinfo .inline, #searchingmember .inline, #teammember .inline").hide();
  
  // project media slider
    if($(".mediaslider li").size() >= 5){
      $(".mediaslider").jCarouselLite({
          btnNext: ".next",
          btnPrev: ".prev"
      });
    }
    
  // lightbox
  $('.mediaslider li a').lightBox({
    maxHeight: document.body.clientHeight * 0.6,
    maxWidth: document.body.clientWidth * 0.6
  });
  $('#mediaall li a').lightBox({
    maxHeight: document.body.clientHeight * 0.6,
    maxWidth: document.body.clientWidth * 0.6
  });


  // calculate Stages
  $cur = $("#stagebar").attr("currentstage") - 1;
  $("#stagebar li:eq("+$cur+")").addClass("atwork");
  for($i = $cur-1; $i>=0; $i--)
   $("#stagebar li:eq("+$i+")").addClass("finished"); 
  

  // FORM PLACEHOLDER
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



  // Editing animation
  /*$(".edit").hover(function () {
    $(this).find(".editBtn").animate({ width: '27px' }, 300);
    $(this).find(".editBtnHor").animate({ height: '25px' }, 300);
  }, function(){
    $(this).find(".editBtn").animate({ width: '2px' }, 300);
    $(this).find(".editBtnHor").animate({ height: '0' }, 300);
  });
*/


  // status
  /*var nr = 0;
  switch ($("#projectprogress .status").attr("rel")) {
	case 'idea': nr = 1; break;
	case 'inprogress': nr = 2; break;
	case 'finished': nr = 3; break;
  };
  nr--;
  $("#projectprogress .status li:eq(" + nr + ")").addClass("active");
*/


  // fixes
});

function placeholder() {
  $("input[type=text], input[type=password], textarea").each(function () {
    if ($(this).attr("value") == "") {
      var phvalue = $(this).attr("placeholder");
      $(this).val(phvalue);
    }
  });
}


/*
function editing(isOpen, what) {
  $what = what;
  if(isOpen)
  {
    $($what+" .inline").fadeToggle(300,function(){
      $($what+" .edit").fadeToggle();
    });
    
  }
  else
  {
    $($what+" .edit").fadeToggle(300,function(){
      $($what+" .inline").fadeToggle();
    });
  }
}
*/


// *** add/delete CATEGORY
$(document).ready(function () {

  $("#formECat").change(function () {
    $value = $(this).val();
    $text = $("#formECat option[value=" + $value + "]").html();
    catAdd($value, $text);
  });

  $("#formECat option:first-child").attr("disabled", "disabled");
});


function catDelete(val) {
  $value = val;
  $("#formECat option:eq(0)").attr("selected", "selected");
  //alert('#projectinfo.inline .category li.' + $value);
  $('#projectinfo .inline .category li.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
  $("#formECat option[value=" + $value + "]").removeAttr("disabled");
}

function catAdd(val, text) {
  catDisable(val);
  $value = val;
  $text = text;
  $('#projectinfo .inline .category').append('<li class="no'+$value+'">'+$text+'<a href="javascript:catDelete(' + $value + ');" class="right del"><img src="/images/delete.png" /></a></li>');
}

function catDisable(val) {
  $value = val;
  $("#formECat option[value=" + $value + "]").attr("disabled", "disabled");
}



// *** add/delete JOB
$(document).ready(function () {
  $("#searchingmember .stdBtn.add").click(function () {
    jobAdd($("#searchingmember #job.eName").val());
  });
});


function jobDelete(val) {
  $value = val;
  $('#searchingmember .inline .openjobs li.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
}

$i = 0;
function jobAdd(val) {
  $value = val;
  $('#searchingmember .inline .openjobs').append('<li class="no'+$i+'">» '+$value+'<a href="javascript:jobDelete(' + $i + ');" class="right del"><img src="/images/delete.png" /></a></li>');
  $i++;
}

function memberDelete(val) {
  $value = val;
  $('#teammember .inline .member.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
}