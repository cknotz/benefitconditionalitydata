// Interactive footnotes with hover effect (from http://hiphoff.com/creating-hover-over-footnotes-with-bootstrap/)
jQuery(document).ready(function() {
    jQuery('[data-toggle="tooltip"]').each(function() {
        var $elem = jQuery(this);
        $elem.tooltip({
            html:true,
            container: $elem,
            delay: {hide:400}
        });
    });
});
