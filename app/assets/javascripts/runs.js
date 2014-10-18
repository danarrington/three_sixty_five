$(document).ready(function(){

    function logButtonClicked() {
        $('.js-log-a-run').hide();
        $('.js-submit-run-container').show();
        $('input.js-distance').focus();
        return false;
    }

    function init() {
        $('.js-log-a-run').click(logButtonClicked);
    }

    init();
});

