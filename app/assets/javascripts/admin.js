$(document).ready(function(){
  function init() {
    $('.js-quick-select').change(update_filter);

    $('.js-reset-button').click(function() {
      $('#admin_filter_from').val('');
      $('#admin_filter_to').val('');
      $('#admin_filter_type').val('');
    });
  }

  function update_filter() {
    var val = $(this).val();
    var FORMAT = 'YYYY-MM-DD';
    if (val == 'tm') {
      $('#admin_filter_from').val(moment().startOf('month').format(FORMAT));
      $('#admin_filter_to').val(moment().endOf('month').add(1, 'day')
        .format(FORMAT));
    } else if (val == 'lm') {
      $('#admin_filter_from').val(moment().subtract(1, 'month')
        .startOf('month').format(FORMAT));
      $('#admin_filter_to').val(moment().subtract(1, 'month').endOf('month')
        .add(1, 'day').format(FORMAT));
    } else if (val == 'lw') {
      $('#admin_filter_from').val(moment().subtract(1, 'week')
        .startOf('week').format(FORMAT));
      $('#admin_filter_to').val(moment().subtract(1, 'week').endOf('week')
        .add(1, 'day').format(FORMAT));
    } else if (val == 'ty') {
      $('#admin_filter_from').val(moment().startOf('year').format(FORMAT));
      $('#admin_filter_to').val(moment().add(1, 'day')
        .format(FORMAT));
    }
  }
  
  init();
});
