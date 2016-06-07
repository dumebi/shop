
(function($) {
    $.fn.PavoLiveSearch = function(opts) {
        // default configuration
        var config = $.extend({}, {
            lang:null,
            limit: 5,
            viewall: 'View All',
            showimage:1,
            showprice: 1
        }, opts);


        function makeAutoSearch( wrapper ){
            var selector = wrapper;
            var show_image = config.showimage;
            var show_price = config.showprice;
            var search_sub_category = true;
            var search_description = true;


           $( wrapper ).find('input[name=\'search\']').autocomplete({
                delay: 500,
                source: function(request, response) {
                    var category_id = $(".category_filter select[name=\"category_id\"]").first().val();
                    if(typeof(category_id) == 'undefined')
                        category_id = 0;
                    var limit = config.limit;
                    var search_sub_category = search_sub_category?'&sub_category=true':'';
                    var search_description = search_description?'&description=true':'';
                    $.ajax({
                        url: 'index.php?route=module/pavautosearch/autocomplete&filter_category_id='+category_id+'&limit='+limit+search_sub_category+search_description+'&filter_name='+encodeURIComponent(request.term),
                        dataType: 'json',
                        success: function(json) {       
                            response($.map(json, function(item) {
                                if($('.pavautosearch_result')){
                                    $('.pavautosearch_result').first().html("");
                                }
                                total = 0;
                                if(item.total){
                                    total = item.total;
                                }
                                return {
                                    price: item.price,
                                    label: item.name,
                                    image: item.image,
                                    link:  item.link,
                                    value: item.product_id
                                }
                            }));
                        }
                    });
                },
                select: function(event, ui) {  
                    return false;
                },
                focus: function(event, ui) { 
                    if(ui.item){ 
                         $( wrapper ).find('input[name=\'search\']').val(ui.item.label);
                         $(".ui-autocomplete li").removeClass('active');
                         $("#autocomplete-"+ui.item.value).addClass("active"); 
                    }
                    return false;
                }
            })
            $(selector).find('input[name=\'search\']').data( "autocomplete" )._renderMenu = function(ul,b){
                var g=this;
                $.each(b,function(c,f){g._renderItem(ul,f)});
                var category_id = $(".category_filter select[name=\"category_id\"]").first().val();
                category_id = parseInt(category_id);
                var text_view_all = config.viewall;
                text_view_all = text_view_all.replace(/%s/gi, total);
                return $(ul).append('<li><a href="index.php?route=product/search&search='+g.term+'&category_id='+category_id+'&sub_category=true&description=true" onclick="window.location=this.href">'+text_view_all+'</a></li>');
            };
            $(selector).find('input[name=\'search\']').data( "autocomplete" )._renderItem = function( ul, item ) {
                var html = '';
                if(show_image){
                    html += '<img class="pull-left" style="margin-right:10px;" src="'+item.image+'">';
                }
                html += '<div class="name">'+item.label+'</div>';
                if(show_price){
                    var text_price = "";
                    if (item.price) {
                        text_price += '<div class="price">';
                        if (!item.special) {
                         text_price += item.price;
                        } else {
                         text_price += '  <span class="price-old">'+item.price+'</span> <span class="price-new">'+item.special+'</span>';
                        }
                        if (item.tax) {
                            item.text_price += '<br />';
                            item.text_price += '<span class="price-tax"> '+item.tax+'</span>';
                        }
                        text_price += '</div>';
                    }
                    html += '<div class="price">'+item.price;   
                }
                
                html += '</div><br class="clear clr"/>';
                var li_element = $("<li class=\"ui-menu-item\" role=\"presentation\" id=\"autocomplete-"+item.value+"\"></li>").data("item.autocomplete",item).append(html).appendTo(ul);
                
                $(li_element).click(function(el){
                   
                    if(item.link){
                        window.location = item.link.replace(/&amp;/gi,'&');
                    }
                });
                
                return li_element;
            };
        }
        /**
         * initialize every element
         */
        this.each(function() {  
             makeAutoSearch( this );
        });

        return this;
    };
    
})(jQuery);
/**
 * sidebarEffects.js v1.0.0
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2013, Codrops
 * http://www.codrops.com
 */
 var SidebarMenuEffects = (function() {

    function hasParentClass( e, classname ) {
        if(e === document) return false;
        if( classie.has( e, classname ) ) {
            return true;
        }
        return e.parentNode && hasParentClass( e.parentNode, classname );
    }

    // http://coveroverflow.com/a/11381730/989439
    function mobilecheck() {
        var check = false;
        (function(a){if(/(android|ipad|playbook|silk|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))check = true})(navigator.userAgent||navigator.vendor||window.opera);
        return check;
    }

    function init() {
        
        $(document).ready( function(){

            var $mcontent = $('#pav-mainnav .navbar .navbar-nav');
          
            var effect;
            var classhtml = $('html').attr('dir');

            if(classhtml == 'rtl') {
                effect = 5;
            } else {
                effect = 3;
            }
			
            var $offcmenu = $('<nav id="menu-offcanvas" class="offcanvas-menu offcanvas-effect-'+effect+' hidden-lg hidden-md"><div class="menu-offcanvas-inner"></div></nav>');
            $(".menu-offcanvas-inner", $offcmenu ).append( $mcontent.clone() );

            $("body").append( $offcmenu );
            $(".navbar-nav", $offcmenu  ).removeClass("navbar-nav").removeClass("nav").addClass("menu-offcanvas-content");
			$(".menu-offcanvas-inner").append("<div class='button-close-menu'><i class='fa fa-times'></i></div>");
			
			var $btn = $("#pav-mainnav .navbar-toggle, .menu-offcanvas-inner .button-close-menu");
		 
             var eventtype = mobilecheck() ? 'click' : 'click';  
                $($btn).bind( eventtype, function(e){  
                $("#offcanvas-container").toggleClass(  "offcanvas-menu-open" ).addClass( "offcanvas-effect-"+effect );
               
                 
                $("#page").bind( eventtype , function (){
                    $("#offcanvas-container").toggleClass(  "offcanvas-menu-open" );
                    $("#page").unbind( eventtype );
                } ); 
                e.stopPropagation();       
               return false;
            } );
        } );    
    }
    init();
})();

/* Offcanvas Sidebars */
$(document).ready( function (){  
    
    if( $("#columns").hasClass("offcanvas-siderbars") ) { 
        $('.offcanvas-sidebars-buttons button').hide();
        $( ".sidebar" ).parent().parent().find("section").addClass("main-column");
        $( ".sidebar" ).each( function(){ 
            $('[data-for="'+$(this).attr("id")+'"]').show();
            $(this).parent().attr("id","oc-"+$(this).attr("id") ).addClass("offcanvas-sidebar");
        } );
        $(".offcanvas-sidebars-buttons button").bind( "click", function(){
            if( $(this).data("for") == "column-right" ){
                 $(".offcanvas-siderbars").removeClass("column-left-active");
            }else {
                 $(".offcanvas-siderbars").removeClass("column-right-active");
            }
            $(".offcanvas-siderbars").toggleClass( $(this).data("for")+"-active" );
            $("#oc-"+$(this).data("for") ).toggleClass("canvas-show");
        } );
     }

} );

 
 

$(window).ready( function(){

    /* Ajax Cart mobile detect*/
    $('#icon-cart-m').live('click', function() {
        $('#cart-m').addClass('active');
        $('#cart-m').load('index.php?route=module/cart #cart > *');
        $('#cart-m').live('mouseleave', function() {
            $(this).removeClass('active');
        });
    });
    /* start fix search detect mobile */
    $('#search_mobile .button-search-mobile').bind('click', function() {
        url = $('base').attr('href') + 'index.php?route=product/search';
        var search = $('input[name=\'search_m\']').attr('value');
        if (search) {
            url += '&search=' + encodeURIComponent(search);
        }
        location = url;
    });
    $('#search_mobile input[name=\'search_m\']').bind('keydown', function(e) {
        if (e.keyCode == 13) {
            url = $('base').attr('href') + 'index.php?route=product/search';
            var search = $('input[name=\'search_m\']').attr('value');
            if (search) {
                url += '&search=' + encodeURIComponent(search);
            }
            location = url;
        }
    });
    /* end fix search detect mobile */

	/*  Fix First Click Menu */
	$(document.body).on('click', '#pav-mainnav [data-toggle="dropdown"], #menu-offcanvas [data-toggle="dropdown"]' ,function(){
		if(!$(this).parent().hasClass('open') && this.href && this.href != '#'){
			window.location.href = this.href;
		}

	});
    $(document.body).on('click', '#pav-verticalmenu [data-toggle="dropdown"]' ,function(){
        if(!$(this).parent().hasClass('open') && this.href && this.href != '#'){
            window.location.href = this.href;
        }

    });

	// $("#pav-mainnav").PavOffCavasmenu();
	$('[data-toggle="tooltip"]').tooltip();
	
	$(".quantity-adder .add-action").click( function(){
		if( $(this).hasClass('add-up') ) {  
			$("[name=quantity]",'.quantity-adder').val( parseInt($("[name=quantity]",'.quantity-adder').val()) + 1 );
		}else {
			if( parseInt($("[name=quantity]",'.quantity-adder').val())  > 1 ) {
				$("input",'.quantity-adder').val( parseInt($("[name=quantity]",'.quantity-adder').val()) - 1 );
			}
		}
	} );

    $("#image-additional a").click( function(e){
        $("#image").parent('a').attr('href', $(this).data('zoom-image') );
        e.preventDefault();
    } );

} );

function addToCart(product_id, quantity) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: 'product_id=' + product_id + '&quantity=' + quantity,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            }
            
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                
                $('.success').fadeIn('slow');
                $('#cart-total').html(json['total']);
                
                $('#cart #cart-total').html(json['total']);

                $('#cart-m #cart-total').html(json['total']);
                
                $('html, body').animate({ scrollTop: 0 }, 'slow'); 
            }   
        }
    });
}

$(document).ready(function() {
    // scroll-to-top button show and hide
    jQuery(document).ready(function(){
        jQuery(window).scroll(function(){
            if (jQuery(this).scrollTop() > 100) {
                jQuery('.scrollup').fadeIn();
            } else {
                jQuery('.scrollup').fadeOut();
        }
    });
    // scroll-to-top animate
    jQuery('.scrollup').click(function(){
        jQuery("html, body").animate({ scrollTop: 0 }, 600);
            return false;
        });
    });
    if( jQuery().colorbox ){
        $('.colorbox').colorbox({
            overlayClose: true,
            opacity: 0.5,
            rel: false
        });
        $('.pav-colorbox').colorbox({
            width: '990px', 
            height: '65%',
            overlayClose: true,
            opacity: 0.5,
            iframe: true,
        });
        $('.info_colorbox').colorbox({
            overlayClose: true,
            opacity: 0.5,
            rel: "colorbox1"
        });
    }
    $(".image-gallery .product-image img").mouseover( function(){
       $(this).parent().parent().parent().find(".img img").attr( 'src', $(this).attr('src') );
    });
    $('.slide').on('slide.bs.carousel', function () {
        $(this).css('overflow','hidden');
    })

    $('.slide').on('slid.bs.carousel', function () {
        $(this).css('overflow','visible');
    });
});

$(document).ready(function(){
    //search-box
    $(function() {
        // Setup drop down menu
        $('.menu-offcanvas-inner .dropdown-toggle').dropdown();
        // Fix input element click problem
        $('.dropdown-menu input').click(function(e) {
            e.stopPropagation();
        });
    });

        /* automatic keep header always displaying on top */

//        var hnav = $("#header").outerHeight();
//        var htop =  $("#topbar").outerHeight();
//        var hslider =  $("#pavo-slideshow").outerHeight();
//        var hh = hnav + htop;
//        var hhb = hslider + htop;
//
//        if( $("#header").hasClass("menu-bottom")){
//
//            var updateTopbar = function(){
//                var pos = $(window).scrollTop();
//                if( pos >= hhb ){
//                    $("#header").addClass('navbar-fixed-top');
//                }else {
//                    $("#header").removeClass('navbar-fixed-top');
//                }
//
//            }
//            $(window).scroll(function() {
//                updateTopbar();
//            });
//        }
//        else if( $("#header").hasClass("menu-top") ){
//
//            $("#page").css( "padding-top", hh);
//            $(".header-top").addClass('navbar-fixed-top');
//            var updateTopbar = function(){
//                var pos = $(window).scrollTop();
//                if( pos >= htop ){
//
//                    $("#header-top").addClass('hide-bar');
//
//                }else {
//                    $("#header-top").removeClass('hide-bar');
//                }
//
//            }
//            $(window).scroll(function() {
//                updateTopbar();
//            });
//
//        }

})

