$(document).on('turbolinks:load', function(){

  const EndDate = flatpickr('.flatpickr',{
    minDate: "today",
    mode: "multiple" 
  });

})