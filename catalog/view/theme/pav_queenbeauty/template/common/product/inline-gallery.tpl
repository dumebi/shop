 <?php 
 $rid =md5($product['name'].rand().$product['product_id']);
 ?>
 <div class="product-block" itemtype="http://schema.org/Product" itemscope>	
	<?php if ($product['thumb']) {    ?>
		<div class="image">
			<?php if( $product['special'] ) {   ?>
			<span class="product-label product-label-special"><span><?php echo $this->language->get( 'text_sale' ); ?></span></span>
			<?php } ?>
			<a class="img" itemprop="url" title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>">
				<img class="img-responsive" itemprop="image" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>							
			<?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
				<a href="<?php echo $zimage;?>" class="btn-danger colorbox product-zoom cboxElement" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
			<?php } ?>
			<?php if ( isset($quickview) && $quickview ) { ?>
				<a class="pav-colorbox btn btn-danger" href="<?php echo $this->url->link("themecontrol/product",'product_id='.$product['product_id'] );?>"><em class="fa fa-plus"></em><span><?php echo $this->language->get('quick_view'); ?></span></a>
			<?php } ?>
		</div>
			<div id="<?php echo $rid ;?>" >
 
					 
 
				<div class="gallery-carousel slide" >
				<ul class="jcarousel-skin-opencart">
				<li class="product-image">
					<img class="img-responsive" itemprop="image" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				</li>	
				<?php
		  			$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );  

					if(isset($product_images) && !empty($product_images)) { ?>
					

					<?php foreach( $product_images as $pimage ){ ?>
					<?php 	
						$thumb2 = $this->model_tool_image->resize($pimage['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
					?>

					<li class="product-image aitem">
				 		<img class="img-responsive" src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"> 
				 	</li>
					<?php } ?>
			
				<?php }  ?>
				</ul></div></div>
				<script type="text/javascript"></script>
	<?php } ?>
					 
	<div class="product-meta">		  
		<div class="left">
			<?php if ( isset($product['rating']) && $product['rating'] ) { ?>
		    <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['rating']; ?>"></div>
		    <?php } else { ?>
	        <div class="norating"><img alt="0" src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
	        <?php } ?>	
	        <h3 class="name" itemprop="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
			<?php if ($product['price']) { ?>
			<div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
				<?php if (!$product['special']) {  ?>
					<span class="special-price"><?php echo $product['price']; ?></span>
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>
				<?php } else { ?>
					<span class="price-old"><?php echo $product['price']; ?></span> 
					<span class="price-new"><?php echo $product['special']; ?></span>
			 
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>

				<?php } ?>
				<?php if ( isset($product['tax']) && $product['tax']) { ?>	        
					<span class="price-tax"><?php echo $this->language->get('text_tax'); ?> <?php echo $product['tax']; ?></span>
				<?php } ?>

				<meta content="<?php echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
			</div>
			<?php } ?>
			<?php if( isset($product['description']) ){ ?> 
			<p class="description" itemprop="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</p>
			<?php } ?>	
		</div>
  
		<div class="right">		
			<div class="action">			
				<?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
				<div class="cart">						
					<button onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-variant btn-outline ">
						<i class="fa fa-shopping-cart"></i>
						<span><?php echo $this->language->get("button_cart"); ?></span>
					</button>
				</div>
				<?php } ?>
				<div class="wishlist">
					<a onclick="addToWishList('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get("button_wishlist"); ?>" class="btn btn-outline-inverse">
				 		<i class="fa fa-heart"></i>
						<span><?php echo $this->language->get("button_wishlist"); ?></span>
					</a>	
				</div>	
				<div class="compare">			
					<a class="btn btn-outline-inverse" onclick="addToCompare('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get("button_compare"); ?>">
						<i class="fa fa-files-o"></i>
						<span><?php echo $this->language->get("button_compare"); ?></span>
					</a>	
				</div>							
			</div>		 
		</div>	 
	</div>		 
</div>