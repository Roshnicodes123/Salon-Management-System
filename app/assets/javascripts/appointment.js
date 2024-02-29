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
        debugger
    
      var timeSlotContainer = $('.time-slots');
      timeSlotContainer.empty();
        
      timeSlots.forEach(function (slot) {
        debugger
        var formattedStartTime = new Date(slot).getHours();
        var timeSlotHtml = `<div class="slot" data-id="${slot.id}" data-start-time="${slot.start_time}" data-end-time="${slot.end_time}">
                              ${formattedStartTime}
                            </div>`;
        timeSlotContainer.append(timeSlotHtml);
      });
  
      $('.slot').click(function () {
        var selectedSlot = $(this);
        $('.slot').css('background-color', ''); 
        selectedSlot.css('background-color', 'yellow'); 
  
        var selectedSlotId = selectedSlot.data('id');
        console.log('Selected Time Slot ID:', selectedSlotId);
      });
    }
  });
  