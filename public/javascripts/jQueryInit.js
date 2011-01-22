// AJAX Bindings
function formBinding(where){
  $(where+' .edit_project')
    .bind('ajaxSend', function() {
      showDialogPart(where+" .inline .ajx", "loading");
    })
    .bind('ajaxError', function() {})
    .bind('ajaxSuccess', function() {
      showDialogPart(where+" .inline .ajx", "success");
      setTimeout(function(){
        closeDialog(where+" .inline .ajx");
      }, 1500);
    });
    
    $(where+" .inline .asksubmit").click(function(){
      showDialog(where+" .inline .ajx", "ask");
    });
    $(where+" .inline .ajx .close").click(function(){
      closeDialog(where+" .inline .ajx");
    });
}

// AJAX Dialogs
function showDialogPart(where, what){
  $(where+' .loading, '+where+' .success, '+where+' .ask').hide();
  $(where+' .'+what).show();
}
function showDialog(where, what){
  showDialogPart(where, what);
  $(where).fadeIn(800);
}
function closeDialog(where){
  $(where).fadeOut(400);
}

// style dialog screens
function posDialog(where){
  $(where+" .inline .ajx")
    .css('width',$(where+" .inline").css('width'))
    .css('height',$(where+" .inline").css('height'));
  $top = $(where+" .inline").css('height');
  $top = parseInt($top) / 2 - 24;
  $(where+" .inline .ajx .con").css('marginTop', $top);
}

$(document).ready(function () {
  posDialog('#projectinfo');
  posDialog('#searchingmember');
  posDialog('#teammember');
  posDialog('#projectprogress');
  
  formBinding('#projectinfo');
  formBinding('#searchingmember');
  formBinding('#teammember');
  formBinding('#projectprogress');
  
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
});


// SIDEBAR set active class
$(document).ready(function() {
  $category = "#sidebar .categories";
  $status = "#sidebar .status";
  
  if ($($category).attr("active") == "") $($category + " li:eq(0) a").addClass("active"); 
  else
    $($category + " a").each(function(i){
      if ($(this).html() == $(this).parent().parent().attr("active")) $(this).addClass("active");
    });
  
  if ($($status).attr("active") == "") $($status + " li:eq(0) a").addClass("active"); 
  else
    $($status + " a").each(function(i){
      if ($(this).html() == $(this).parent().parent().attr("active")) $(this).addClass("active");
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
  if($("#projectinfo .inline .category li").size() > 1)
  {
    $value = val;
    $("#formECat option:eq(0)").attr("selected", "selected");
    //alert('#projectinfo.inline .category li.' + $value);
    $('#projectinfo .inline .category li.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
    $("#formECat option[value=" + $value + "]").removeAttr("disabled");
    $("#projectinfo .edit_project .hiddencat[value=" + $value + "]").removeAttr("checked");
  }
}

function catAdd(val, text) {
  catDisable(val);
  $value = val;
  $text = text;
  $('#projectinfo .inline .category').append('<li class="no'+$value+'">'+$text+'<a href="javascript:catDelete(' + $value + ');" class="right del"><img src="/images/delete.png" /></a></li>');
  $("#projectinfo .edit_project .hiddencat[value=" + $value + "]").attr("checked","checked");
}

function catDisable(val) {
  $value = val;
  $("#formECat option[value=" + $value + "]").attr("disabled", "disabled");
}



// *** add/delete JOB
$(document).ready(function () {
  $("#searchingmember .add").click(function () {
    $max = 0;
    for($i = 0; $i < $("#searchingmember .inline .openjobs li").size(); $i++)
    {
      $val = $("#searchingmember .inline .openjobs li").eq($i).attr("class");
      $val = parseInt($val.substring(2));
      if($val > $max) $max = $val;
    }
    $max++;
    jobAdd($max, $("#searchingmember #job.eName").val(), true);
  });
});


function jobDelete(val, nw) {
  $value = val;
  $('#searchingmember .inline .openjobs li.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
  $("#searchingmember .edit_project .hiddenjobs[value=" + $value + "]").removeAttr("checked");
  if(nw) $('#searchingmember .inline .newjobs input[val='+$value+']').remove();
}

function jobAdd(val, text, nw) {
  $value = val; $text = text; $nw = nw;
  if($nw)
  {
    $('#searchingmember .inline .newjobs').append('<input type="text" name="newjobs[]" val="'+$value+'" value="'+$text+'" />');
    $newTag = 'new="new"';
    $delNew = true;
  }
  else { $newTag =''; $delNew = false; }
  $('#searchingmember .inline .openjobs').append('<li '+$newTag+' class="no'+$value+'">» '+$text+'<a href="javascript:jobDelete(' + $value + ','+$delNew+');" class="right del"><img src="/images/delete.png" /></a></li>');
  //$("#searchingmember .inline .hiddencat[value=" + $value + "]").attr("checked","checked");
}

function memberDelete(val) {
  $value = val;
  $('#teammember .inline .member.no'+$value).fadeOut(function () { }, function () { $(this).remove() });
  $('#teammember .inline .hiddenroles[value='+$value+']').removeAttr('checked');
}


// Overlay
function overlay(id){
    $.blockUI({ 
    	css: {
    		cursor: 'default'
    	},
    	overlayCSS:  { 
    		opacity: 0.7,
    		cursor: 'default'
  		}, 
  		themedCSS: {
			width:	'500px',
			top:	'17%',
			left:	'50%'
		},
        theme:     true, 
        message:   $(id), 
        timeout:   0,
	    fadeIn:    400, 
	    fadeOut:   300,
	    focusInput: false
    });     
    $(id+" .close").click(function() {
        $.unblockUI(); 
        return false; 
    });
}


function submitForm(id){
  $id = id;
  $id.click();
}