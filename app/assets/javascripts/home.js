$(document).ready(function(){

    function init() {
        $('.js-leaderboard-option').on('ajax:success', set_leaderboard_selection);
        $('.leaderboard-results').on('click', 'li.disabled a', function(){return false;})
    }

    function set_leaderboard_selection(data, status, xhr){
        $('.leaderboard .selected').removeClass('selected');
        $(this).addClass('selected');
        var description = $(this).data('description');
        $('.js-leaderboard-selection-text').html(description);
    }

    init();
});

