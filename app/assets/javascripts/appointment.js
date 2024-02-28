$('#slot_date_picker').change(function () {
  
  var selectedDate = $('#slot_date_picker').val();
  var salonId =   window.location.pathname.split('/')[2]
  var barbarId = $('#appointment_barbar_id').val(); 
  $.ajax({
      type: "GET",
      url: window.location.origin + `/salons/${salonId}/appointments/get_appointment_slots`,
      data: { 'date': selectedDate, 'barbar_id': barbarId },
      success: function (response) {
          console.log(response);
      },
      error: function (xhr, status, error) {
          console.error(error);
      }
  });
});
