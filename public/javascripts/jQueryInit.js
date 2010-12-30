// FORM PLACEHOLDER
$(document).ready(function(){  
	placeholder();
	$("input[type=text], input[type=password], textarea").focusin(function(){  
		var phvalue = $(this).attr("placeholder");  
		if (phvalue == $(this).val()) {  
		$(this).val("");  
		}  
	});  
	$("input[type=text], input[type=password], textarea").focusout(function(){  
		var phvalue = $(this).attr("placeholder");  
		if ($(this).val() == "") {  
			$(this).val(phvalue);  
		}  
	}); 
  
  // Tooltip
  xOffset = -10;
  yOffset = 15;
  $(".tooltip").hover(function(e){
    var t = this.title;
    this.title = "";
    $("body").append("<p id='stdTooltip'>"+ t +"</p>");
    $("#stdTooltip")
      .css("top",(e.pageY - xOffset) + "px")
      .css("left",(e.pageX + yOffset) + "px")
      .show();
    },
  function(){
    this.title = t;
    $("#stdTooltip").remove();
    });	
  $("a.tooltip").mousemove(function(e){
    $("#stdTooltip")
      .css("top",(e.pageY - xOffset) + "px")
      .css("left",(e.pageX + yOffset) + "px");
  });
}); 
