$(function() {
  var status = localStorage.getItem('chkStatus');

  if(status == 'true'){
    $(".instructions").css("display", "none");
    $(".hideShowInstructions").attr('checked', true)
  }
  else{
    $(".instructions").css("display");
    $(".hideShowInstructions").attr('checked', false)
  }
  $(".hideShowInstructions").click(function() {
    if (this.checked) {
      $(".instructions").hide();
    }
    else {
      $(".instructions").show();
    }
    localStorage.setItem("chkStatus", this.checked);
  });
});


// STATS WILL NEED TO BE HIDDEN ASWELL

//$(function() {
//  var status2 = localStorage.getItem('chkStatus2');
//
//  if(status2 == 'true'){
//    $(".information").css("display", "none");
//    $(".hideShowStats").attr('checked', true)
//  }
//  else{
//    $(".information").css("display");
//    $(".hideShowStats").attr('checked', false)
//  }
//  $(".hideShowStats").click(function() {
//    if (this.checked) {
//      $(".information").hide();
//    }
//    else {
//      $(".information").show();
//    }
//    localStorage.setItem("chkStatus2", this.checked);
//  });
//});
//


//$(function() {
//  var status = localStorage.getItem('chkStatus');
//  
//  if(status == 'true'){
//    $("#mesfavgame").css("display", "none");
//    $(".AvGamesCheckBox").attr('checked', true)
//  }
//  else{
//    $("#mesfavgame").css("display", "block");
//    $(".AvGamesCheckBox").attr('checked', false)
//  }
//  $(".AvGamesCheckBox").click(function() {
//    if (this.checked) {
//      $("#mesfavgame").hide();
//    }
//    else {
//      $("#mesfavgame").show();
//    }
//    localStorage.setItem("chkStatus", this.checked);
//  });
//});