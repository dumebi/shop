<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

  $themeConfig = (array)$this->config->get('themecontrol');
  $productConfig = array(
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,

  );
  $listingConfig = array(
	'category_pzoom'			   => 0,
  ); 
  $categoryPzoom 	    = $listingConfig['category_pzoom']; 
  $productConfig 		= array_merge( $productConfig, $themeConfig );  
  $languageID 			= $this->config->get('config_language_id');   
?>

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
$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/jquery.parallax-1.1.3.js' );
$helper->addScriptList( $scripts );
$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );	
if( $ctheme=$helper->getConfig('customize_theme')  
	&& file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$ctheme.'.css') ) {  
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
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- Mobile viewport optimized: h5bp.com/viewport -->
	<meta name="viewport" content="width=device-width">
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
	<?php foreach ($links as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>
	<?php foreach ($helper->getCssLinks() as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>

	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
	<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>

	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style> 
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}
	</style>
	<?php } ?>
	<?php 
		if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
			$css=array();
			$link = array();
			for( $i=1; $i<=3; $i++ ){
				if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
					$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
					$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
				}
				if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
					$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
				}
			}
			echo implode( "\r\n",$link );
			?>
			<style>
			<?php echo implode("\r\n",$css);?>
			</style>
			<?php } else { ?>			
			<link href='http://fonts.googleapis.com/css?family=Open+Sans:800italic,800,700italic,700,600italic,600,400italic,400,300italic,300' rel='stylesheet' type='text/css'>
			<?php } ?>
			<?php foreach ($styles as $style) { ?>
			<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
			<?php } ?>
			<?php foreach( $helper->getScriptFiles() as $script )  { ?>
			<script type="text/javascript" src="<?php echo $script; ?>"></script>
			<?php } ?>


			<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
			<script type="text/javascript"><!--
			$(document).ready(function() {
				<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
			});
			//--></script>
			<?php }	?>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->	
<!--[if lt IE 9]>
<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->

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
<body class="quickview">
	<section id="page-quickview" role="main">
		<section id="sys-notification">
			<div class="container">
				<?php if ($error) { ?>
				<div class="warning"><?php echo $error ?><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/close.png" alt="" class="close" /></div>
				<?php } ?>
				<div id="notification"></div>
			<script type="text/javascript">
				$(document).ready(function() {
					$( "#notification" ).delegate( "a", "click", function() {
						window.parent.location = $(this).attr('href');
						return false;
					});
					var tmp="";
					$("a").each(function(){
						$(this).click(function(){
							 tmp = $(this).attr('href');
							 if(tmp != '#image-additional' && $(this).children('img').length==0 && tmp.length>0 && tmp.indexOf('undefined')){
							 		window.parent.location = tmp;
									return false;
							 }
							});
					});
				});
			</script>
			</div>
		</section>
		<section id="columns">

		<div class="container-fluid padding">
			<div class="row">
            <section class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div id="content" class="product-detail">

                    <div class="product-info ">
                        <div class="row">
                            <?php if ($thumb || $images) { ?>
                            <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 image-container">

                                <?php if ($thumb) { ?>
                                <div class="image">

                                    <?php if( isset($date_available) && $date_available == date('Y-m-d')) {   ?>
                                    <span class="product-label product-label-new">
                                        <span><?php echo $this->language->get( 'text_new' ); ?></span>
                                    </span>
                                    <?php } ?>
                                    <?php if( $special )  { ?>
                                        <span class="product-label product-label-special"><span><?php echo $this->language->get( 'text_sale' ); ?></span></span>
                                    <?php } ?>

                                    <a title="<?php echo $heading_title; ?>">
                                        <img itemprop="image" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image"  data-zoom-image="<?php echo $popup; ?>" class="product-image-zoom img-responsive"/>
                                    </a>

                                </div>
                                <?php } ?>

                                <?php if ($images) { ?>
                                <div class="image-additional slide carousel" id="image-additional">
                                    <div id="image-additional-carousel" class="carousel-inner">
                                        <?php
                                        if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {
                                            $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  );
                                            $images = array_merge( $eimages, $images );
                                        }
                                        $icols = 4; $i= 0;
                                        foreach ($images as  $image) { ?>
                                            <?php if( (++$i)%$icols == 1 ) { ?>
                                            <div class="item clearfix">
                                            <?php }
                                                $colorbox = $i > 1?'colorbox':'';
                                            ?>
                                                <a title="<?php echo $heading_title; ?>" rel="<?php echo $colorbox; ?>" class="colorbox" data-image="<?php echo $image['popup']; ?>">
                                                    <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $this->config->get('config_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom img-responsive" />
                                                </a>
                                            <?php if( $i%$icols == 0 || $i==count($images) ) { ?>
                                            </div>
                                          <?php } ?>
                                        <?php } ?>
                                    </div>

                                    <!-- Controls -->
                                    <a class="right carousel-control fa fa-angle-right" href="#image-additional" data-slide="next"></a>
                                    <a class="left carousel-control fa fa-angle-left" href="#image-additional" data-slide="prev"></a>

                                </div>
                                <script type="text/javascript">
                                    $('#image-additional .item:first').addClass('active');
                                    $('#image-additional').carousel({interval:false})
                                </script>
                                <?php } ?>
                            </div>
                            <?php } ?>


                            <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 product-view">
                                <h1 itemprop="name"><?php echo $heading_title; ?></h1>

                                <?php if ($review_status) { ?>
                                <div class="review">
                                    <div><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
                                </div>
                                <?php } ?>


                                <div class="share">
                                    <!-- AddThis Button END -->
                                    <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
                                    <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script>
                                    <!-- AddThis Button BEGIN -->
                                </div>


                                <div class="description">
                                    <?php if ($manufacturer) { ?>
                                        <p>
                                            <i class="fa fa-chevron-down"></i>
                                            <b><?php echo $text_manufacturer; ?></b>
                                            <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a>
                                        </p>
                                    <?php } ?>
                                    <p>
                                        <i class="fa fa-chevron-down"></i>
                                        <b><?php echo $text_model; ?></b>
                                        <?php echo $model; ?>
                                    </p>
                                    <?php if ($reward) { ?>
                                        <p>
                                            <i class="fa fa-chevron-down"></i>
                                            <b><?php echo $text_reward; ?></b>
                                            <?php echo $reward; ?>
                                        </p>
                                    <?php } ?>
                                    <p>
                                        <i class="fa fa-chevron-down"></i>
                                        <b><?php echo $text_stock; ?></b>
                                        <span><?php echo $stock; ?></span>
                                    </p>
                                </div>


                                <?php if ($price) { ?>
                                <div class="price" itemscope itemtype="http://schema.org/Offer">
                                    <div class="price-gruop">
                                        <span class="text-price"><?php echo $text_price; ?></span>
                                        <?php if (!$special) { ?>
                                        <?php echo $price; ?>
                                            <?php if( preg_match( '#(\d+).?(\d+)#',  $price, $p ) ) { ?>
                                            <meta content="<?php echo $p[0]; ?>" itemprop="price">
                                            <?php } ?>
                                        <?php } else { ?>
                                            <?php if( preg_match( '#(\d+).?(\d+)#',  $special, $p ) ) { ?>
                                            <meta content="<?php echo $p[0]; ?>" itemprop="price">
                                            <?php } ?>

                                        <span class="price-old"><?php echo $price; ?></span>
                                        <span class="price-new"><?php echo $special; ?></span>
                                        <?php } ?>
                                    </div>
                                    <div class="other-price">
                                        <?php if ($tax) { ?>
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br/>
                                        <?php } ?>
                                        <?php if ($points) { ?>
                                            <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span>
                                        <?php } ?>
                                    </div>
                                    <?php if ($discounts) { ?>
                                    <div class="discount">
                                        <ul>
                                            <?php foreach ($discounts as $discount) { ?>
                                            <li><?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?></li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                    <?php } ?>

                                    <meta content="<?php echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
                                </div>
                                <?php } ?>



                                <?php if ( isset($profiles) && $profiles): ?>
                                <div class="option form-group">
                                    <h2 class="page-meta"><span class="required">*</span><?php echo $text_payment_profile ?></h2>
                                    <select name="profile_id" class="form-control">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($profiles as $profile): ?>
                                        <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                    <span id="profile-description"></span>
                                </div>
                                <?php endif; ?>



                                <div class="product-extra">
                                    <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
                                    <div class="quantity-adder">
                                        <div class="quantity-number pull-left">
                                            <span><?php echo $text_qty; ?></span>
                                            <input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
                                        </div>
                                        <div class="quantity-wrapper pull-left">
                                            <span class="add-up add-action fa fa-sort-asc"></span>
                                            <span class="add-down add-action fa fa-sort-desc"></span>
                                        </div>

                                        <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                    </div>

                                    <div class="action">
                                        <div class="cart">
                                            <button id="button-cart" class="btn btn-outline-inverse btn-variant">
                                                <span class="fa fa-shopping-cart fa-fw"></span><?php echo $button_cart; ?>
                                            </button>
                                        </div>
                                        <?php } ?>
                                        <div class="wishlist">
                                            <a class="btn btn-outline" onclick="addToWishList('<?php echo $product_id; ?>');">
                                                <i class="fa fa-heart"></i>
                                                <span><?php echo $button_wishlist; ?></span>
                                            </a>
                                        </div>
                                        <div class="compare">
                                            <a class="btn btn-outline" onclick="addToCompare('<?php echo $product_id; ?>');">
                                                <i class="fa fa-refresh"></i>
                                                <span><?php echo $button_compare; ?></span>
                                            </a>
                                        </div>
                                    </div>

                                </div>

                                <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
                                    <?php if ($minimum > 1) { ?>
                                        <div class="minimum"><small><?php echo $text_minimum; ?></small></div>
                                    <?php } ?>



                                    <?php if ($options) { ?>
                                    <div class="options">
                                        <h2 class="page-meta"><?php echo $text_option; ?></h2>
                                        <?php foreach ($options as $option) { ?>
                                        <?php if ($option['type'] == 'select') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <select name="option[<?php echo $option['product_option_id']; ?>]">
                                                <option value=""><?php echo $text_select; ?></option>
                                                <?php foreach ($option['option_value'] as $option_value) { ?>
                                                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                <?php if ($option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                                </option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                        <?php } ?>




                                        <?php if ($option['type'] == 'radio') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <?php foreach ($option['option_value'] as $option_value) { ?>
                                            <div class="radio">
                                                <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
                                                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                                                    <?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                            </div>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>



                                        <?php if ($option['type'] == 'checkbox') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <?php foreach ($option['option_value'] as $option_value) { ?>
                                            <div class="checkbox">
                                                <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                                                    <?php if ($option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                            </div>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>



                                        <?php if ($option['type'] == 'image') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <table class="option-image">
                                                <?php foreach ($option['option_value'] as $option_value) { ?>
                                                <tr>
                                                    <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                                                    <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                                                    <td>
                                                        <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </label>
                                                    </td>
                                                </tr>
                                                <?php } ?>
                                            </table>
                                        </div>
                                        <?php } ?>



                                        <?php if ($option['type'] == 'text') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
                                        </div>
                                        <?php } ?>


                                        <?php if ($option['type'] == 'textarea') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5" class="form-control"><?php echo $option['option_value']; ?></textarea>
                                        </div>
                                        <?php } ?>


                                        <?php if ($option['type'] == 'file') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button btn btn-default">
                                            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
                                        </div>
                                        <?php } ?>

                                        <?php if ($option['type'] == 'date') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
                                        </div>
                                        <?php } ?>

                                        <?php if ($option['type'] == 'datetime') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
                                        </div>
                                        <?php } ?>

                                        <?php if ($option['type'] == 'time') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option form-group">
                                            <?php if ($option['required']) { ?>
                                            <p><span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b></p>
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
                                        </div>
                                        <?php } ?>

                                    <?php } ?>
                                </div>
                            <?php } ?>
                        <?php } ?>



                        <?php if ($tags) { ?>
                        <div class="tags">
                            <b><?php echo $text_tags; ?></b>
                            <?php for ($i = 0; $i < count($tags); $i++) { ?>
                            <?php if ($i < (count($tags) - 1)) { ?>
                            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                            <?php } else { ?>
                            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                            <?php } ?>
                            <?php } ?>
                        </div>
                        <?php } ?>
                    </div>
	</div>
</div>



	</div>

<?php if( $productConfig['product_enablezoom'] ) { ?>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
	<?php if( $productConfig['product_zoomgallery'] == 'slider' ) {  ?>		
		$("#image").elevateZoom( {  gallery:'image-additional-carousel', 
									cursor: 'pointer', 
								 	<?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
									zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
									lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
									lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
									<?php } ?>
									galleryActiveClass: 'active' } ); 
		<?php } else { ?>
		var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
		$( zoomCollection ).elevateZoom({
		<?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
		zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
		<?php } ?>
		lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
		lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
	});
	<?php } ?> 
</script>
<?php } ?>

<script type="text/javascript">
<!--
$(document).ready(function() {
  $('.colorbox').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox"
  });
});
//-->
</script>

 <script type="text/javascript">
 <!--
$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
    dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      if (json['success']) {
                $('#profile-description').html(json['success']);
      }
    }
  });
});
$('#button-cart').bind('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
    dataType: 'json',
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
          }
        }

                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
      } 

      if (json['success']) {
        $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/close.png" alt="" class="close" /></div>');

        $('.success').fadeIn('slow');

        $('#cart-total', window.parent.document ).html(json['total']);

        $('html, body').animate({ scrollTop: 0 }, 'slow'); 
      } 
    }
  });
});
//-->
</script>

<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
  action: 'index.php?route=product/product/upload',
  name: 'file',
  autoSubmit: true,
  responseType: 'json',
  onSubmit: function(file, extension) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
  },
  onComplete: function(file, json) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

    $('.error').remove();

    if (json['success']) {
      alert(json['success']);
      $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
    }

    if (json['error']) {
      $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
    }

    $('.loading').remove(); 
  }
});
//-->
</script>

<?php } ?>
<?php } ?>
<?php } ?>

<script type="text/javascript">
<!--
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');

  $('#review').load(this.href);

  $('#review').fadeIn('slow');

  return false;
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-review').attr('disabled', true);
      $('#review-title').after('<div class="attention"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-review').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(data) {
      if (data['error']) {
        $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
      }

      if (data['success']) {
        $('#review-title').after('<div class="success">' + data['success'] + '</div>');

        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});
//-->
</script> 

<script type="text/javascript">
<!--
$('#tabs a').tabs();
//-->
</script> 

<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript">
<!--
$(document).ready(function() {
  if ($.browser.msie && $.browser.version == 6) {
    $('.date, .datetime, .time').bgIframe();
  }

  $('.date').datepicker({dateFormat: 'yy-mm-dd'});
  $('.datetime').datetimepicker({
    dateFormat: 'yy-mm-dd',
    timeFormat: 'h:m'
  });
  $('.time').timepicker({timeFormat: 'h:m'});
});
//-->
</script> 
</section>
 
 

</div></div>

</section></section> 
</body></html>