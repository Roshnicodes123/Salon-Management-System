$(document).ready(function () {
  $('#slot_date_picker, #appointment_barbar_id').change(function () {
    var selectedDate = $('#slot_date_picker').val();
    var salonId = window.location.pathname.split('/')[2];
    var barbarId = $('#appointment_barbar_id').val();

    $.ajax({
      type: "GET",
      url: window.location.origin + `/salons/${salonId}/appointments/get_appointment_slots`,
      data: { 'date': selectedDate, 'barbar_id': barbarId },
      success: function (response) {
        console.log(response);
        updateTimeSlots(response.data);
      },
      error: function (xhr, status, error) {
        console.error(error);
      }
    });
  });

  function updateTimeSlots(timeSlots) {
    var timeSlotContainer = $('.time-slots');
    timeSlotContainer.empty();

    if (Array.isArray(timeSlots) && timeSlots.length > 0) {
      
      console.log(timeSlots);
      timeSlots.forEach(function (slot, index) {
        console.log("Index:", index, "Value:", slot);

        var formattedStartTime = new Date(slot[1]).getHours();
        var timeSlotHtml = `<div class="slot" data-id="${slot[0]}" data-start-time="${slot[1]}">
                            ${formattedStartTime}
                            </div>`;
        timeSlotContainer.append(timeSlotHtml);
      });

      $('.slot').click(function () {
        var selectedSlot = $(this);
        $('.slot').css('background-color', '');
        selectedSlot.css('background-color', 'yellow');

        var selectedSlotId = selectedSlot.data('id');
        $('#appointment_time_slot_id').val(selectedSlotId); 
        console.log('Selected Time Slot ID:', selectedSlotId);
      });
    } else {
      console.error("Invalid timeSlots data:", timeSlots);
    }
  }
});
