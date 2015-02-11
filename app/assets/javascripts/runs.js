$(document).ready(function(){

    function logButtonClicked() {
        $('.js-log-a-run').hide();
        $('.js-submit-run-container').show();
        $('input.js-distance').focus();
        return false;
    }

    function cancelButtonClicked() {
        $('.js-log-a-run').show();
        $('.js-submit-run-container').hide();
    }

    function confirmDelete() {
      $.ajax({
        url: $(this).attr('href'),
        type: 'DELETE',
        success: function(data) {
          $("tr[data-run-id='"+data.id+"']").remove();
        }
      });
    }

    function init() {
        $('.js-log-a-run').click(logButtonClicked);
        $('.js-cancel-run').click(cancelButtonClicked);
        $('a.editable').editable();
        $('a.editable-right').editable({
          placement: 'right'  
        });
        $('a.editable-left').editable({
          placement: 'left'  
        });
        $('[data-toggle="confirmation"]').confirmation({
          onConfirm: confirmDelete});
    }

    init();
});

