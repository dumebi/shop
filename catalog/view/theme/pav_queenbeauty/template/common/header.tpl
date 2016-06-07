<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
$this->language->load('module/themecontrol');
$themeName =  $this->config->get('config_template');
require_once(DIR_SYSTEM . 'pavothemes/loader.php');
$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
$helper->setDirection( $direction );
$helper->triggerUserParams( array('headerlayout','productlayout') );
/* Add scripts files */
$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
$helper->addScript( 'catalog/view/javascript/common.js' );
$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/common.js' );
$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );
//colorbox
$helper->addScript( 'catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js' );
$helper->addCss( 'catalog/view/javascript/jquery/colorbox/colorbox.css' );

$helper->addScriptList( $scripts );
$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );
$ctheme = $helper->getConfig('customize_theme');
if(isset($ctheme) && file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$ctheme.'.css') ) {
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$ctheme.'.css'  );
}
$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/animation.css' );
$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );
$helper->addCssList( $styles );

$logoType = $helper->getConfig('logo_type','logo-theme');
$headerlayout = $helper->getConfig('header_layout');

if( $helper->getConfig('enable_paneltool') ){
	if( $helper->getParam('headerlayout') ){
		$headerlayout = $helper->getParam('headerlayout');
	}
}

?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>

<?php if( isset($links) && $links )  { foreach ($links as $link) {  ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } } ?>
<?php foreach ($helper->getCssLinks() as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.jcarousel.min.js"></script>
<!-- Created heading-title style:Bold -->
<script type="text/javascript">
    $(document).ready(function() {
        $('.box-heading span').each(function(){
            var string = $(this).html().trim();
            var check = /\s/.test(string);
            if(check == true){
                string = string.replace(/(\S+?)$/, '<b>$1</b>');
            }else{
                string = "<b>"+string +"</b>";
            }
            $(this).html(string);
        });
    });
</script>

<?php if( $cjs=$helper->getConfig('custom_javascript') ){ ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
			<?php echo html_entity_decode(trim($cjs) ); ?>
		});
//--></script>
<?php }	?>

<?php
	if( $helper->getConfig('enable_customfont',0) ){
		echo $helper->renderCustomFont();
	}
?>

<!--[if lt IE 9]>
<?php if( $helper->getConfig('load_live_html5') ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->

<?php if( $helper->getConfig('enable_paneltool') ){  ?>
<link  href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/paneltool.css" rel="stylesheet"/>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorpicker/js/colorpicker.js"></script>
<link  href="catalog/view/javascript/jquery/colorpicker/css/colorpicker.css" rel="stylesheet" />
<?php } ?>

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body id="offcanvas-container" class="keepheader offcanvas-container layout-<?php echo $helper->getParam( 'layout' ); ?>  <?php echo $helper->getPageClass();?>">
	<section id="page" class="offcanvas-pusher" role="main">
        <section id="header-top" >
            <div class="header-top"><!-- Start.header-top -->
                <div id="topbar">
                    <div class="container">
                        <div class="show-desktop">
                            <div class="quick-access pull-left  hidden-sm hidden-xs">
                                <div class="login links link-active">
                                    <?php if (!$logged) { ?>
                                    <?php echo $text_welcome; ?>
                                    <?php } else { ?>
                                    <?php echo $text_logged; ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <!--Button -->
                            <div class="quick-top-link  links pull-left">
                                <!-- user-->
                                <div class="btn-group">
                                    <div data-toggle="dropdown">
                                            <span class="quick-icon">
                                                <i class="fa fa-user"></i>
                                                <span class="fa fa-angle-down"></span>
                                            </span>
                                    </div>
                                    <div class="dropdown-menu">
                                        <ul class="links">
                                            <li><a class="wishlist" href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                                            <li><a class="account" href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                                            <li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a></li>
                                            <li><a class="last checkout" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- language -->
                                <div class="btn-group">
                                    <div data-toggle="dropdown">
                                        <i class="fa fa-cog"></i>
                                        <span class="fa fa-angle-down"></span>
                                    </div >

                                    <div class="quick-setting dropdown-menu links-variant">
                                        <div class="language">
                                            <?php echo $language; ?>
                                        </div>
                                        <div class="currency">
                                            <?php echo $currency; ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="shopping-cart pull-right">
                                <div class="cart-top">
                                    <?php echo $cart; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
                    if( file_exists($helper->getLayoutPath('common/header/'.$headerlayout.'.tpl')) ) {
                        require( $helper->getLayoutPath('common/header/'.$headerlayout.'.tpl') );
                    }else {
                        require( ThemeControlHelper::getLayoutPath( 'common/header/hasmainmenu.tpl' ) );
                    }
                ?>
        </section>
<?php if( $helper->getConfig('enable_offsidebars') ) { ?>
<section id="columns" class="offcanvas-siderbars">
    <div class="row visible-xs">
        <div class="container">
            <div class="offcanvas-sidebars-buttons clearfix">
                <button type="button" data-for="column-left" class="pull-left btn btn-danger btn-default"><i class="fa fa-sort-amount-asc"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>

                <button type="button" data-for="column-right" class="pull-right btn btn-danger btn-default"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="fa fa-sort-amount-desc"></i></button>
            </div>
        </div>
    </div>
<?php }else { ?>
<section id="columns">
<?php } ?>

<!--/**
* sys-notification
*/-->
<section id="sys-notification">
    <div class="container">
        <?php if ($error) { ?>
        <div class="warning"><?php echo $error ?><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/close.png" alt="" class="close" /></div>
        <?php } ?>
        <div id="notification"></div>
    </div>
</section>

<?php
/**
 * Showcase modules
 * $ospans allow overrides width of columns base on thiers indexs.format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
    */
    $blockid = 'showcase';
    $blockcls = '';
    $modules = $helper->getModulesByPosition( $blockid );
    $ospans = array();
    require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>
