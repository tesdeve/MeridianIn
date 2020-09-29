$(document).ready(function(){
	$('.hideShowInstructions').click(function(){
		var $this = $(this);
		$this.toggleClass('hideShowInstructions');
		if($this.hasClass('hideShowInstructions')){
			$this.text('Hide Instructions');			
		} else {
			$this.text('Show Instructions ');
		}
		$('.instructions').toggle();
	});
		


	$('.hideShowStats').click(function(){
		var $this = $(this);
		$this.toggleClass('hideShowStats');
		if($this.hasClass('hideShowStats')){
			$this.text('Hide Stats');			
		} else {
			$this.text('Show Stats ');
		}
		$('.information').toggle();
	});

		$("#editEmployeelink").click(function(){
	     $("#linkEmployee").slideUp();
 	});
	//$('.cancelButton').click(function(){
	//	location.reload()
	//})
 	});







