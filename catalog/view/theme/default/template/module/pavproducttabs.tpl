<?php 
/******************************************************
 * @package Pav Product Tabs module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,9)+rand();	
?>
<div class="box producttabs">
<?php if( !empty($module_description) ) { ?>
 <div class="module-desc">
	<?php echo $module_description;?>
 </div>
 <?php } ?>
  <div class="tab-nav">
	<ul class="nav nav-tabs" id="producttabs<?php echo $id;?>">
		<?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;}  ?>
			 <li><a href="#tab-<?php echo $tab.$id;?>" data-toggle="tab"><?php echo $this->language->get('text_'.$tab)?></a></li>
		<?php } ?>
	</ul>
  </div>
	

	<div class="tab-content">
		<?php foreach( $tabs as $tab => $products ) { 
				if( empty($products) ){ continue;}
			?>
			<div class="tab-pane box-products  tabcarousel<?php echo $id; ?> slide" id="tab-<?php echo $tab.$id;?>">
				
				<?php if( count($products) > $itemsperpage ) { ?>
				<div class="carousel-controls">
				<a class="carousel-control left" href="#tab-<?php echo $tab.$id;?>"   data-slide="prev">&lsaquo;</a>
				<a class="carousel-control right" href="#tab-<?php echo $tab.$id;?>"  data-slide="next">&rsaquo;</a>
				</div>
				<?php } ?>
				<div class="carousel-inner ">		
				 <?php 
					$pages = array_chunk( $products, $itemsperpage);
				//	echo '<pre>'.print_r( $pages, 1 ); die;
				 ?>	
				  <?php foreach ($pages as  $k => $tproducts ) {   ?>
						<div class="item <?php if($k==0) {?>active<?php } ?>">
							<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
								<?php if( $i%$cols == 1 ) { ?>
								  <div class="row box-product">
								<?php } ?>
									  <div class="col-lg-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 product-block"><div class="product-inner">
										<?php if ($product['thumb']) { ?>
										<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
										<?php } ?>
										<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
										<div class="description">
											<?php echo utf8_substr( strip_tags($product['description']),0,58);?>...
										</div>
										<?php if ($product['price']) { ?>
										<div class="price">
										  <?php if (!$product['special']) { ?>
										  <?php echo $product['price']; ?>
										  <?php } else { ?>
										  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
										  <?php } ?>
										</div>
										<?php } ?>
										<?php if ($product['rating']) { ?>
										<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
										<?php } ?>
										<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
									  </div></div>
							  
							  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
								 </div>
								<?php } ?>
							<?php } //endforeach; ?>
						</div>
				  <?php } ?>
				</div>  
			</div>
		<?php } // endforeach of tabs ?>	
	</div>
</div>


<script>
$(function () {
$('#producttabs<?php echo $id;?> a:first').tab('show');
})
$('.tabcarousel<?php echo $id;?>').carousel({interval:false,auto:false,pause:'hover'});
</script>
