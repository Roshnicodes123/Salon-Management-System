document.addEventListener('turbo:load', () => {
    flatpickr('.date-picker', {
      dateFormat: 'Y-m-d',
      minDate: 'today',
    });
  });
  