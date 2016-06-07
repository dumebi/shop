<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
	 
<?php echo $header; ?>

<div class="container">
	<div class="row">
		<?php if( $SPAN[0] ): ?>
			<aside class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>
		<?php endif; ?> 

		<?php $class_3cols = (!empty($column_left) && !empty($column_left))?'three-columns':''; ?>
		
		<section class="col-md-<?php echo $SPAN[1];?> <?php echo $class_3cols;?> ">
            <?php require( ThemeControlHelper::getLayoutPath( 'common/breadcrumb.tpl' ) );  ?>
			<div id="content">
				<?php echo $content_top; ?>
				<h1><?php echo $heading_title; ?></h1>				
				<?php if ($products) { ?>
					<?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
				<?php } else { ?>
				<div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>				
				<div class="buttons clearfix">
					<div class="right"><a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a></div>
				</div>
				<?php } ?>
				<?php echo $content_bottom; ?>
			</div>
  
<script type="text/javascript">
<!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.products-block  .product-block').each(function(index, element) {
 
			 $(element).parent().addClass("col-fullwidth");
		});		
		
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list active"><em><?php echo $text_list; ?></em></a><a class="grid" onclick="display(\'grid\');"><em><?php echo $text_grid; ?></em></a>');
	
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.products-block  .product-block').each(function(index, element) {
			 $(element).parent().removeClass("col-fullwidth");  
		});	
					
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list" onclick="display(\'list\');"><em><?php echo $text_list; ?></em></a><a class="grid active"><em><?php echo $text_grid; ?></em></a>');
	
		$.totalStorage('display', 'grid');
	}
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('<?php echo $DISPLAY_MODE;?>');
}
//-->
</script> 

</section>

<?php if( $SPAN[2] ): ?>
<aside class="col-md-<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div></div>

<?php echo $footer; ?>