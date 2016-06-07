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
	<?php if ($success) { ?>
	<div class="success alert alert-success"><?php echo $success; ?></div>
	<?php } ?>
	<?php if ($error) { ?>
	<div class="warning alert alert-warning"><?php echo $error; ?></div>
	<?php } ?>
    <?php require( ThemeControlHelper::getLayoutPath( 'common/breadcrumb.tpl' ) );  ?>
	<div id="content">
		<?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
		
		<div class="wrapper">
			<table class="list">
				<thead>
					<tr>
						<td class="left" colspan="2"><?php echo $text_recurring_detail; ?></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="left" style="width: 50%;">
							<p style="margin:5px;"><b><?php echo $text_recurring_id; ?></b> #<?php echo $profile['order_recurring_id']; ?></p>
							<p style="margin:5px;"><b><?php echo $text_date_added; ?></b> <?php echo $profile['created']; ?></p>
							<p style="margin:5px;"><b><?php echo $text_status; ?></b> <?php echo $status_types[$profile['status']]; ?></p>
							<p style="margin:5px;"><b><?php echo $text_payment_method; ?></b> <?php echo $profile['payment_method']; ?></p>
						</td>
						<td class="left" style="width: 50%; vertical-align: top;">
							<p style="margin:5px;"><b><?php echo $text_product; ?></b> <a href="<?php echo $profile['product_link']; ?>"><?php echo $profile['product_name']; ?></a></p>
							<p style="margin:5px;"><b><?php echo $text_quantity; ?></b> <?php echo $profile['product_quantity']; ?></p>
							<p style="margin:5px;"><b><?php echo $text_order; ?></b> <a href="<?php echo $profile['order_link']; ?>">#<?php echo $profile['order_id']; ?></a></p>
						</td>
					</tr>
				</tbody>
			</table>
			<table class="list">
				<thead>
					<tr>
						<td class="left"><?php echo $text_recurring_description; ?></td>
						<td class="left"><?php echo $text_ref; ?></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="left" style="width: 50%;"><p style="margin:5px;"><?php echo $profile['profile_description']; ?></p></td>
						<td class="left" style="width: 50%;"><p style="margin:5px;"><?php echo $profile['profile_reference']; ?></p></td>
					</tr>
				</tbody>
			</table>
			<h2 class="page-meta"><?php echo $text_transactions; ?></h2>
			<table class="list">
				<thead>
					<tr>
						<td class="left"><?php echo $column_created; ?></td>
						<td class="center"><?php echo $column_type; ?></td>
						<td class="right"><?php echo $column_amount; ?></td>
					</tr>
				</thead>
				<tbody>
					<?php
					if(!empty($profile['transactions'])){
						foreach ($profile['transactions'] as $transaction) {
					?>
					<tr>
						<td class="left"><?php echo $transaction['created']; ?></td>
						<td class="center"><?php echo $transaction_types[$transaction['type']]; ?></td>
						<td class="right"><?php echo $transaction['amount']; ?></td>
					</tr>
					<?php } 
					} else { ?>
					<tr>
						<td colspan="3" class="center"><?php echo $text_empty_transactions; ?></td>
					</tr>
					<?php } ?>
				</tbody>
			</table>
		</div>

		<div class="buttons clearfix">
			<div class="right">
				<?php if($cancel_link){ ?>
					<a href="<?php echo $cancel_link; ?>" class="button btn btn-default" onclick="return confirmCancel();"><?php echo $button_cancel_profile; ?></a>
				<?php } ?>
				<a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a>
			</div>
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

<script type="text/javascript">
<!--
    function confirmCancel(){
        var confirmed = confirm("<?php echo $text_confirm_cancel; ?>");
        return confirmed;
    }
//-->
</script>