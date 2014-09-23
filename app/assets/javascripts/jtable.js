(function ($) {
    jQuery.fn.jtable_ou = function () {
        return this.each(function () {
            var $this = $(this);
            var config_url=$this.attr("data-jtable-config");
            $.getScript( config_url, function( data, textStatus, jqxhr ) {
                $this.jtable(jtable_config);
                $this.jtable('load');
            });
        });
    };
})(jQuery);

$(document).on("page:change", function() {
    $('[data-jtable-config]').jtable_ou();
});