

jQuery(document).ready(function(){

jQuery( ".navigation li i" ).click(function(e) {
                jQuery(this).next('ul').slideToggle(300);
        if(jQuery(this).hasClass('fa-arrow-down')){
            jQuery(this).addClass('fa-arrow-left');
            jQuery(this).removeClass('fa-arrow-down');
        }else{
            
            jQuery(this).removeClass('fa-arrow-left');
            jQuery(this).addClass('fa-arrow-down');
        }

});

})