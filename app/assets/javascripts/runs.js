$(document).ready(function(){

    function submitRun() {
        distance = $('input.js-distance').val();
        $.post(Routes.runs_path(), {run:{distance: distance}}, submitRunSuccess)
    }

    function submitRunSuccess(data) {
        $('.js-log-a-run').show();
        $('.js-submit-run-container').hide();
        console.log(data);
    }

    function logButtonClicked() {
        $('.js-log-a-run').hide();
        $('.js-submit-run-container').show();
        $('input.js-distance').focus();
        return false;
    }

    function init() {
        $('.js-submit-run').click(submitRun);
        $('.js-log-a-run').click(logButtonClicked);
    }

    init();
});

