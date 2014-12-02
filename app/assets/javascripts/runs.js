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

    function init() {
        $('.js-log-a-run').click(logButtonClicked);
        $('.js-cancel-run').click(cancelButtonClicked);
    }

    init();
});

