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
}); 