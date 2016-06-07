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
				<h2 class="page-meta"><?php echo $text_password; ?></h2>
				<div class="content">
					<table class="form">
						<tr>
							<td>
								<span class="required">*</span> <?php echo $entry_password; ?>
							</td>
							<td>
								<input type="password" name="password" value="<?php echo $password; ?>" class="form-control" />
								<?php if ($error_password) { ?>
									<span class="error"><?php echo $error_password; ?></span>
								<?php } ?>
							</td>
						</tr>
						<tr>
							<td>
								<span class="required">*</span> <?php echo $entry_confirm; ?>
							</td>
							<td>
								<input type="password" name="confirm" value="<?php echo $confirm; ?>" class="form-control" />
								<?php if ($error_confirm) { ?>
									<span class="error"><?php echo $error_confirm; ?></span>
								<?php } ?>
							</td>
						</tr>
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

</section> 

<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>

</div></div>

<?php echo $footer; ?>