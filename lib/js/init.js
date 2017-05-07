$(document).ready(function(){
      $('.parallax').parallax();
});

$(document).ready(function(){
      $('.slider').slider({full_width: true});
});

$('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 20,
    format: 'yyyy-mm-dd'
});

$(document).ready(function(){
    $('.tooltipped').tooltip({delay: 50});
});

$(document).ready(function() {
	$('select').material_select();
});
$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();
});
$(document).ready(function(){
      $(".dropdown-button").dropdown();
});


/*
{
          dismissible: true, // Modal can be dismissed by clicking outside of the modal
          opacity: .5, // Opacity of modal background
          in_duration: 300, // Transition in duration
          out_duration: 200, // Transition out duration
          starting_top: '4%', // Starting top style attribute
          ending_top: '10%', // Ending top style attribute
          ready: function(modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
            alert("Ready");
            console.log(modal, trigger);
          },
          complete: function() { alert('Closed'); } // Callback for Modal close
        }
*/