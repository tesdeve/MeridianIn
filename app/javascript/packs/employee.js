window.checkInChange = function(item){
	Rails.fire(item.closest('form'), 'submit');
	//alert("OE!")
}

