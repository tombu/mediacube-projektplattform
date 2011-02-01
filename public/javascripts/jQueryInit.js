// AJAX Bindings
function formBinding(where){
  $(where+' .edit_project')
    .bind('ajaxSend', function() {
      showDialogPart(where+" .inline .ajx", "loading");
    })
    .bind('ajax:error', function() {})
    .bind('ajax:success', function() {
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
    .css('width',$(where+" .inline").width())
    .css('height',$(where+" .inline").height());
  $top = $(where+" .inline").height();
  $top = parseInt($top) / 2 - 24;
  $(where+" .inline .ajx .con").css('marginTop', $top);
}

$(document).ready(function () {
  
  // Positioning Dialogs for AJAX response
  posDialog('#projectinfo');
  posDialog('#projectcover');
  posDialog('#searchingmember');
  posDialog('#teammember');
  posDialog('#projectprogress');
  posDialog('#projectstate');
  
  // AJAX bindings
  formBinding('#projectinfo');
  formBinding('#projectcover');
  formBinding('#searchingmember');
  formBinding('#teammember');
  formBinding('#projectprogress');
  formBinding('#projectstate');
  $('.delete_notification').bind('ajax:success', function() {
    $(this).closest("li").fadeOut( 200, function () { $(this).remove() });
  });
  
  // new positioning on height changes
  $('#projectinfo').live('click', function(e){setTimeout(function(){posDialog('#projectinfo');}, 310);});
  $('#searchingmember').live('click', function(e){setTimeout(function(){posDialog('#searchingmember');}, 310);});
  $('#teammember').live('click', function(e){setTimeout(function(){posDialog('#teammember');}, 310);});
  $('#projectprogress').live('click', function(e){setTimeout(function(){posDialog('#projectprogress');}, 310);});
  $('#projectstate').live('click', function(e){setTimeout(function(){posDialog('#projectstate');}, 310);
  });
  
  
  
  $(".inline #stagebar").dragsort({ 
    dragSelector: "div",
    placeHolderTemplate: "<li class='placeholder'><div></div></li>" 
  });
  
  
  // project media slider
    if($(".mediaslider li").size() > 5){
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
  
  $("input[type=submit]").click(function(){
    $(this).closest("form").find("textarea, input[type=text], input[type=password]").each(function(){
      if($(this).val() == $(this).attr("placeholder")) $(this).val("");
    });
  });
  
  // Textarea AUTO-resize
  $('#statusupdate_content').elastic();



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


$(document).ready(function() {
  // SIDEBAR set active class
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

  // show notices/warnings
  if($(".notice").html() != "")
  {
    $(".notice").show();
    setTimeout(function(){$(".notice").fadeOut(500);}, 5000);
  }
  
  // show project tooltips
  $(".projectover").hover(function(){
    $div = $(this).parent().parent().children(".project");
    $offset = $(this).position().left;
    $div.css("left", $offset).fadeIn(300);
  }, function(){
     $(this).parent().parent().children(".project").fadeOut(300);
  });
});


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
  if($("#projectinfo .inline .category li, #npformular .category li").size() > 1)
  {
    $value = val;
    $("#formECat option:eq(0)").attr("selected", "selected");
    //alert('#projectinfo.inline .category li.' + $value);
    $('#projectinfo .inline .category li.no'+$value+', #npformular .category li.no'+$value).fadeOut(300, function () { $(this).remove() });
    $("#formECat option[value=" + $value + "]").removeAttr("disabled");
    $("#projectinfo .edit_project .hiddencat[value=" + $value + "], #npformular .edit_project .hiddencat[value=" + $value + "]").removeAttr("checked");
  }
}

function catAdd(val, text) {
  catDisable(val);
  $value = val;
  $text = text;
  $('#projectinfo .inline .category, #npformular .category').append('<li class="no'+$value+'">'+$text+'<a href="javascript:catDelete(' + $value + ');" class="right del"><img src="/images/delete.png" /></a></li>');
  $("#projectinfo .edit_project .hiddencat[value=" + $value + "], #npformular .hiddencat[value=" + $value + "]").attr("checked","checked");
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
  $('#searchingmember .inline .openjobs li.no'+$value).fadeOut(300, function () { $(this).remove() });
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
  
  $("#searchingmember .inline .eName").val("");
}

function memberDelete(val) {
  $value = val;
  $('#teammember .inline .member.no'+$value).fadeOut(300, function () { $(this).remove() });
  $('#teammember .inline .hiddenroles[value='+$value+']').removeAttr('checked');
}







$(document).ready(function(){
  $('#projectprogress .inline .delete').live('click', function(){
    $e = parseInt($(this).parent().attr("data-itemidx"));
    $nw = ($(this).parent().attr("new") == "new") ? true : false;
    $id = $(this).parent().attr("sid");
    
    // uncheck box for removed element OR remove hidden new stage entry
    if(!$nw) $("#projectprogress .inline .hiddenstages[value="+$id+"]").removeAttr("checked");
    else 
    {
      $('#projectprogress .inline .newstages div[sid="'+$id+'"]').remove();
    }
    $("#crrent option[sid='"+$id+"']").remove();
    
    // <li> fades out and is removed
    $(this).parent().fadeOut(300, function () { 
      $(this).remove();
      
      // set new position for all elements
      $('#projectprogress .inline #stagebar').children().each(function(j) {
        $(this).attr("data-itemIdx", j); 
        var value = $(this).attr("sid");
        $("#projectprogress .inline li[data-itemidx="+j+"] .pos").attr("value", j+1);
        $("#crrent option[sid='"+value+"']").attr("value", j+1);
      });
      
      // set new position for all HIDDEN elements
      $('#projectprogress .inline #stagebar li[new="new"]').each(function(k) {
        var value = $(this).attr("sid");
        var from = "#projectprogress .inline .newstages .hidd[sid='"+value+"']";
        $to = $(this).find('.pos').val();
        $(from).attr("value", $to);
      });
    });
  });
  
  $("#projectprogress .add").live('click', function () {
    $max = 0;
    for($i = 0; $i < $("#projectprogress .inline #stagebar li").size(); $i++)
    {
      $val = $("#projectprogress .inline #stagebar li:eq("+$i+") .pos").val();
      $val = parseInt($val);
      if($val > $max) $max = $val;
    }
    $max++;
    stageAdd($max, $("#projectprogress #stage.eName").val(), true);
    $("#projectprogress .inline .eName").val("");
  });
  
  
  $('#projectprogress .inline #stagebar li[new="new"] .text').live('change', function() {
    $sidd = $(this).parent().parent().attr("sid");
    $('#projectprogress .inline .newstages div[sid="'+$sidd+'"] .midd').attr("value", $(this).val());
  });
});

function stageAdd(position, text, nw) {
  $position = position; $text = text; $nw = nw;
  $size = $("#projectprogress .inline #stagebar li").size();
  
  // get highest SID
  $highestId = 0;
  $('#projectprogress .inline #stagebar li').each(function(j) { 
    $highestId = (parseInt($(this).attr("sid")) > $highestId) ? parseInt($(this).attr("sid")) : $highestId;
  });
  $highestId++;
  
  if($nw)
  {
    $('#projectprogress .inline .newstages').append('<div sid="'+$highestId+'"><input sid="'+$highestId+'" type="text" class="midd" name="newstages[name][]" position="'+$position+'" value="'+$text+'" /><input sid="'+$highestId+'" type="text" class="hidd" name="newstages[position][]" position="'+$position+'" value="'+$position+'" /></div>');
    $newTag = 'new="new"';
    $delNew = true;
  }
  else { $newTag =''; $delNew = false; }
  $('#projectprogress .inline #stagebar').append('<li sid="'+$highestId+'" data-itemidx="'+$size+'" '+$newTag+'><div style="cursor: pointer"><input class="text" id="stages_name_" name="stages[name][]" type="text" value="'+$text+'"><input class="pos" id="stages_position_" name="stages[position][]" type="hidden" value="'+$position+'"><input class="ysid" id="stages_sid_" name="stages[sid][]" type="hidden" value="-1"></div><a href="#" class="delete"><img alt="Delete" src="/images/delete.png?1294147242"></a></li>');
  
  $("#crrent").append('<option value="'+$position+'" sid="'+$highestId+'">'+$text+'</option>');
}







// Overlay
function overlay(id){
    $.blockUI({ 
    	css: {
    		cursor: 'default'
    	},
    	overlayCSS:  { 
    		opacity: 0.8,
    		cursor: 'default'
  		}, 
  		themedCSS: {
			top:	'17%',
			left:	'50%',
      marginLeft: '-250px'
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