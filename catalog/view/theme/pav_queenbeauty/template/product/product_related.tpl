<?php if ($products) { ?>	
<?php 	
$cols = 3;
$span = 12/$cols;

?>
<div class="product-related box clearfix padding">
	<div class="box-heading"></span><span><?php echo $tab_related; ?> (<?php echo count($products); ?>)</span></div>
	<div id="related" class="slide row-fluid box-content" data-interval="0">
		<?php if( count($products) > $cols ) { ?> 
	    <div class="carousel-controls">
	      <a class="carousel-control left fa fa-angle-left" href="#related" data-slide="prev"></a>
	      <a class="carousel-control right fa fa-angle-right" href="#related" data-slide="next"></a>
	    </div>
	    <?php } ?>
	<div class=" carousel-inner">
		<?php  $pages = array_chunk( $products, $cols);  ?>	
		  <?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
						<?php if( $i%$cols == 1 ) { ?>
						  <div class="row-fluid products-row">
						<?php } ?>
						<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
							<?php require( ThemeControlHelper::getLayoutPath( 'common/product/default.tpl' ) );  ?>     
						</div>
					  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
						 </div>
						<?php } ?>
					<?php } //endforeach; ?>
				</div>
		  <?php } ?>		  
	</div>
</div>
</div>	
<?php } ?>