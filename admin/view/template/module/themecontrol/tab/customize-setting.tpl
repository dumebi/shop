<?php if( $warning_custom_files_permission ) { ?> 
 
	<?php foreach( $warning_custom_files_permission as $warning ) { ?>
		<div class="warning"><?php echo $warning; ?></div>
	<?php } ?>

<?php } ?>
<div class="alert alert-success">
	<i><?php echo $this->language->get('text_explain_customization');?></i>
</div>
<table class="form">
		<tr class="highlight"><td colspan="2">

			<?php echo $this->language->get('text_customize_theme'); ?>

			</td>
		<tr>
			<td colspan="2">
				
				<select name="themecontrol[customize_theme]">
					<option value=""><?php echo $this->language->get('text_no_select'); ?></option>
					<?php foreach( $files as $file )  { $file = str_replace(".css", "", $file);?>
					<option value="<?php echo $file;?>" <?php if( $module['customize_theme']==$file){?> selected="selected" <?php } ?>><?php echo $file ;?></option>
					<?php } ?>
				</select>
				<a href="<?php echo $live_customizing_url;?>" class="button"><span class="fa fa-magic"></span> <?php echo $this->language->get('text_live_edit');?></a>
				<p><i><?php echo $this->language->get('text_explain_customize_theme'); ?></i></p>
				
			</td>
		</tr>
	   
		<tr class="highlight"><td colspan="2"><?php echo $this->language->get('text_heading_customize_code');?></td></tr>
<tr><td>

<?php echo $this->language->get('text_customcss'); ?>

</td>
<td>
<p><i><?php echo $this->language->get('text_explain_custom_css')?></i></p>
<textarea name="themecontrol[custom_css]" rows="16" cols="80"><?php echo $module['custom_css'];?></textarea>
</td>
</tr>
<tr><td>
<?php echo $this->language->get('text_customjavascript'); ?>
</td><td>
<p><i><?php echo $this->language->get('text_explain_custom_js')?></i></p>
<textarea name="themecontrol[custom_javascript]" rows="16" cols="80"><?php echo $module['custom_javascript'];?></textarea>
</td></tr>
</table>