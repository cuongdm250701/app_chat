document.addEventListener('turbolinks:load', function() {
    $(function() {
        function check_to_hide_or_show_add_link() {
            
            if($('#users .nested-fields:visible').length == 5) {
                $('#users .links a').hide();
            } else {
                $('#users .links a').show();
            }
        }

        $('#users').on('cocoon:after-insert', function() {
            check_to_hide_or_show_add_link()
        });

        $('#users').on('cocoon:after-remove', function() {
            check_to_hide_or_show_add_link()
        })
    })
})