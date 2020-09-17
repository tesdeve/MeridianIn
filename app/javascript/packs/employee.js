jQuery.fn.submitOnCheck = function() { 
	this.find('input[type=checkbox]').click(function() {		
		$(this).parent('form').submit();
  });
  return this;
};

$(function() { 
	$('.edit_employee').submitOnCheck();
});









//jQuery.fn.submitOnCheck = function() { 
//	this.find('input[type=checkbox]').click(function() {		
//		$(this).parent('form').submit();
//		//alert("Updwwwated!!");
//  });
//  return this;
//};
//
//
//$(function() { 
//	$('.edit_employee').submitOnCheck();
//});

//
    //$(this).parent('form').submit()
		//$(this).parent('form').submit();

		//alert("Updated!!");



//
    //$(this).parent('form').submit()
		//$(this).parent('form').submit();

		//alert("Updated!!");