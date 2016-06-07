<?php 
	$cols = 4;
	$span = 12/$cols;

	$themeConfig  	 			= $this->config->get('themecontrol');
	$listingConfig  			= array( 		
		'category_pzoom' 		=> 1,
		'show_swap_image' 		=> 0,
		'quickview' 			=> 0,
		'product_layout'		=> 'default',
		'catalog_mode'			=> '',
	); 
	$listingConfig  			= array_merge($listingConfig, $themeConfig );
	$categoryPzoom 	    		= $listingConfig['category_pzoom'];
	$quickview 					= $listingConfig['quickview'];
	$swapimg 					= ($listingConfig['show_swap_image'])?'swap':'';
	$this->language->load( 'module/themecontrol' ); 
	$theme  = $this->config->get('config_template');
	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}   
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
	if( !is_file($productLayout) ){
		$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/default.tpl';	
	}
 
?>
<div class="products-block">		
	<?php foreach ($products as $i => $product) { $i=$i+1; ?>
	<?php if( $i%$cols == 1 && $cols > 1 ) { ?>
	<div class="row products-row">
		<?php } ?> 
		<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
			<?php require( $productLayout );  ?>   	
		</div>		
		<?php if( ($i%$cols == 0 || $i==count($products) ) && $cols > 1 ) { ?>
	</div>
	<?php } ?>			
	<?php } ?>		
</div>	