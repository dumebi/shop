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
		<div class="search">
			<h1><?php echo $heading_title; ?></h1>
			<label for="input-search" class="control-label"><?php echo $text_critea; ?></label>
			<div class="content">
				<div class="wrapper">
					<div class="row">
						<div class="col-md-4">
							<div class="form-horizontal">
								<div class="form-group">
									<label for="search" class="col-md-3 control-label hidden-xs hidden-sm"><?php echo $entry_search; ?></label>
									<div class="col-md-9">
										<?php if ($search) { ?>
										<input type="text" name="search" value="<?php echo $search; ?>" class="input-text form-control" />
										<?php } else { ?>
										<input type="text" name="search" value="<?php echo $search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;"  class="input-text form-control" />
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<select name="category_id" class="form-control">
								<option value="0"><?php echo $text_category; ?></option>
								<?php foreach ($categories as $category_1) { ?>
								<?php if ($category_1['category_id'] == $category_id) { ?>
								<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
								<?php } ?>
								<?php foreach ($category_1['children'] as $category_2) { ?>
								<?php if ($category_2['category_id'] == $category_id) { ?>
								<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } ?>
								<?php foreach ($category_2['children'] as $category_3) { ?>
								<?php if ($category_3['category_id'] == $category_id) { ?>
								<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } ?>
								<?php } ?>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div>
						<label for="description" class="checkbox">
							<?php if ($description) { ?>
							<input type="checkbox" name="description" value="1" id="description" checked="checked" />
							<?php } else { ?>
							<input type="checkbox" name="description" value="1" id="description" />
							<?php } ?>
							<?php echo $entry_description; ?>
						</label>
						<label for="sub_category" class="checkbox">
								<?php if ($sub_category) { ?>
								<input type="checkbox" name="sub_category" value="1" id="sub_category" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="sub_category" value="1" id="sub_category" />
								<?php } ?>
								<?php echo $text_sub_category; ?>
						</label>
					</div>
				</div>				
			</div>
  
			<div class="buttons clearfix">
				<div class="left"><input type="button" value="<?php echo $button_search; ?>" id="button-search" class="button btn btn-default" /></div>
			</div>
  
			<h2 class="page-meta"><?php echo $text_search; ?></h2>
			<?php if ($products) { ?>
				<?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
			<?php } else  { ?>
			<div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
    		<?php } ?>
			<?php echo $content_bottom; ?>
		</div>
  
  
<script type="text/javascript"><!--
$('#content input[name=\'search\']').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').bind('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').attr('disabled', 'disabled');
		$('input[name=\'sub_category\']').removeAttr('checked');
	} else {
		$('input[name=\'sub_category\']').removeAttr('disabled');
	}
});

$('select[name=\'category_id\']').trigger('change');

$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var search = $('#content input[name=\'search\']').attr('value');
	
	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').attr('value');
	
	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}
	
	var sub_category = $('#content input[name=\'sub_category\']:checked').attr('value');
	
	if (sub_category) {
		url += '&sub_category=true';
	}
		
	var filter_description = $('#content input[name=\'description\']:checked').attr('value');
	
	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

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
	display('<?php echo isset($DISPLAY_MODE)?$DISPLAY_MODE:"grid";?>');
}
//-->
</script> 

</section>
 
<?php if( $SPAN[2] ): ?>
<aside class="col-md-<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div></div></div>

<?php echo $footer; ?>