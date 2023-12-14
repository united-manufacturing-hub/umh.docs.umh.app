$(document).ready(function() {

    var switchesSelector = '.spoiler_block_show,.spoiler_block_hide';
    var contentSelector = '.spoiler_block_content';

    $(document).on('click', switchesSelector, function() {
        var selector = switchesSelector + ',' + contentSelector;
        $(this).parent().children(selector).toggle();
        return false;
    });
});