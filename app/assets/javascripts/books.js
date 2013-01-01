
$(document).ready(function() {
  // click on a row and send to the link
  $("tr[data-link]").click(function() {
    window.location = this.dataset.link;
  });
  
  //gather all the ids corresponding to the table rows
  var record_ids = new Array();
  $.each($("tr[data-record_id]"), function() {
    record_ids.push(this.dataset.record_id); 
  });

  //init the current_row
  var current_row = -1;
  
  //monitor keydown events
  //update the current_row every time the up and down keys are pressed
  $(document).keydown(function(e) {
    //down key
    if(e.keyCode == 40 && current_row < record_ids.length-1) {
      current_row += 1;
    }
    //up key
    if(e.keyCode == 38 && current_row > 0) {
      current_row -= 1;
    };
    
    //return key pressed
    //send to the link if the return key is pressed
    if(e.keyCode == 13 && current_row >= 0) {
      $.each($("tr[data-record_id]"), function() {
        if(this.dataset.record_id == record_ids[current_row]) {
          window.location = this.dataset.link;
          return;
        } 
      });
    }
  });
  
});


