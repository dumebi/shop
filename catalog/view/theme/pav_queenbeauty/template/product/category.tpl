<?php require( ThemeControlHelper::getLayoutPath( 'common/config.tpl' ) );  ?> 
<?php echo $header; ?>


<div class="container">
	<div class="row"> 
		<?php if( $SPAN[0] ): ?>
			<aside class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
		<section class="col-md-<?php echo $SPAN[1];?>">
            <?php require( ThemeControlHelper::getLayoutPath( 'common/breadcrumb.tpl' ) );  ?>
			<div class="content">
				<?php echo $content_top; ?>
				<h1><?php echo $heading_title; ?></h1>
				<?php if ($thumb || $description) { ?>
				<div class="category-info clearfix hidden-xs hidden-sm">
					<?php if ($thumb) { ?>
					<div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" /></div>
					<?php } ?>
					<?php if ($description) { ?>
					<div class="category-description wrapper">
						<?php echo $description; ?>
					</div>
					<?php } ?>
				</div>
				<?php } ?> 

				<?php if ($categories) { ?>
				<div class="box  refine-search clearfix">
					<div class="box-heading"><span><?php echo $text_refine; ?></span>
					</div>
					<div class="category-list clearfix box-content">
						<?php if (count($categories) <= 5) { ?>
						<ul class="list-style">
							<?php foreach ($categories as $category) { ?>
							<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
							<?php } ?>
						</ul>
						<?php } else { ?>
						<?php for ($i = 0; $i < count($categories);) { ?>
						<ul  class="list-style">
							<?php $j = $i + ceil(count($categories) / 4); ?>
							<?php for (; $i < $j; $i++) { ?>
							<?php if (isset($categories[$i])) { ?>
							<li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
							<?php } ?>
							<?php } ?>
						</ul>
						<?php } ?>
						<?php } ?>
					</div>
				</div>
				<?php } ?>


				<?php if ($products) { ?>
				<?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
				<?php } ?>					

				<?php if (!$categories && !$products) { ?>
				<div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
				<div class="buttons clearfix">
					<div class="right"><a href="<?php echo $continue; ?>" class="button btn btn-outline"><?php echo $button_continue; ?></a></div>
				</div>
				<?php } ?>

				<?php echo $content_bottom; ?></div>

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