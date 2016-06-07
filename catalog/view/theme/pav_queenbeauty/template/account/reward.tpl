<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>


<div class="container">
<div class="row">

<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>
<?php endif; ?> 

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
    <?php require( ThemeControlHelper::getLayoutPath( 'common/breadcrumb.tpl' ) );  ?>
    <div id="content">
		<?php echo $content_top; ?> 
		<h1><?php echo $heading_title; ?></h1>
		<p><?php echo $text_total; ?><b> <?php echo $total; ?></b>.</p>
		
		<table class="list">
			<thead>
				<tr>
					<td class="left"><?php echo $column_date_added; ?></td>
					<td class="left"><?php echo $column_description; ?></td>
					<td class="right"><?php echo $column_points; ?></td>
				</tr>
			</thead>
		<tbody>
		<?php if ($rewards) { ?>
			<?php foreach ($rewards  as $reward) { ?>
				<tr>
					<td class="left"><?php echo $reward['date_added']; ?></td>
					<td class="left">
						<?php if ($reward['order_id']) { ?>
							<a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
						<?php } else { ?>
						<?php echo $reward['description']; ?>
						<?php } ?>
					</td>
					<td class="right"><?php echo $reward['points']; ?></td>
				</tr>
			<?php } ?>
			<?php } else { ?>
				<tr>
					<td class="center" colspan="5"><?php echo $text_empty; ?></td>
				</tr>
			<?php } ?>
		</tbody>
	</table>
	
	<div class="pagination paging clearfix"><?php echo $pagination; ?></div>
	<div class="buttons clearfix">
		<div class="right"><a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a></div>
	</div>
	<?php echo $content_bottom; ?>
	</div>
</section> 
 
<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>

</div></div>

<?php echo $footer; ?>