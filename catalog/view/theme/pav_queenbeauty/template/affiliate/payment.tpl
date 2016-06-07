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
		
		<div class="wrapper">		
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" role="form">
				<h2 class="page-meta"><?php echo $text_your_payment; ?></h2>
				<div class="content">
					<table class="form">
						<tbody>
							<tr>
								<td><?php echo $entry_tax; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="tax" value="<?php echo $tax; ?>" class="form-control" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_payment; ?></td>							
							</tr>
							<tr>
								<td>
									<?php if ($payment == 'cheque') { ?>
									<input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
									<?php } else { ?>
									<input type="radio" name="payment" value="cheque" id="cheque" />
									<?php } ?>
									<label for="cheque"><?php echo $text_cheque; ?></label>
									<?php if ($payment == 'paypal') { ?>
									<input type="radio" name="payment" value="paypal" id="paypal" checked="checked" />
									<?php } else { ?>
									<input type="radio" name="payment" value="paypal" id="paypal" />
									<?php } ?>
									<label for="paypal"><?php echo $text_paypal; ?></label>
									<?php if ($payment == 'bank') { ?>
									<input type="radio" name="payment" value="bank" id="bank" checked="checked" />
									<?php } else { ?>
									<input type="radio" name="payment" value="bank" id="bank" />
									<?php } ?>
									<label for="bank"><?php echo $text_bank; ?></label>
								</td>
							</tr>
						</tbody>
						<tbody id="payment-cheque" class="payment">
							<tr>
								<td><?php echo $entry_cheque; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="cheque" value="<?php echo $cheque; ?>" class="form-control" /></td>
							</tr>
						</tbody>
						<tbody class="payment" id="payment-paypal">
							<tr>
								<td><?php echo $entry_paypal; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="paypal" value="<?php echo $paypal; ?>" class="form-control" /></td>
							</tr>
						</tbody>
						<tbody id="payment-bank" class="payment">
							<tr>
								<td><?php echo $entry_bank_name; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="bank_name" value="<?php echo $bank_name; ?>" class="form-control" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_bank_branch_number; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" class="form-control" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_bank_swift_code; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" class="form-control" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_bank_account_name; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" class="form-control" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_bank_account_number; ?></td>							
							</tr>
							<tr>
								<td><input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" class="form-control" /></td>
							</tr>
						</tbody>
					</table>
				</div>	
		
				<div class="buttons clearfix">
					<div class="left"><a href="<?php echo $back; ?>" class="button btn btn-default"><?php echo $button_back; ?></a></div>
					<div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button btn btn-default" /></div>
				</div>
	  		</form>
  		</div>

  	<?php echo $content_bottom; ?>

</div>


<script type="text/javascript">
<!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//-->
</script> 

</section> 


<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>

</div></div>

<?php echo $footer; ?>