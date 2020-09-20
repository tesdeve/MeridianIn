$(document).ready(function(){
	$('#hideShowStats').click(function(){
		$(this).text(function(i, text){ 
			text === 'Hide Stats' ? 'Show Stats' : 'Hide Stats'; //'Show Instructions' 
		})
		$('.information1').toggle();
	});
	$('#hideShowInstructions').click(function(){
		$(this).text(function(i, text){ 
			text === 'Hide Instructions' ? 'Show Instructions' : 'Hide Instructions'; //'Show Instructions' 
		})
		$('.separate-top').toggle();
	});

		$("#editEmployeelink").click(function(){
	     $("#linkEmployee").slideUp();
 	});
	//$('.cancelButton').click(function(){
	//	location.reload()
	//})
});
