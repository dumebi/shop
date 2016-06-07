<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
	    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
	    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	    <?php } ?>
	</div>

	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
	<div class="success"><?php echo $success; ?></div>
	<?php } ?>

	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
				<a onclick="$('#action').val('save_stay');$('#form').submit();" class="button"><?php echo $button_save_stay; ?></a>
				<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
			</div>
		</div>

		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<input name="action" type="hidden" id="action"/>  
				<div id="tabs-modules" class="htabs">
					<a href="#tab-modules"><?php echo $tab_module_assign; ?></a>
					<a href="#tab-data"><?php echo $tab_reassurance_image; ?></a>
				</div>

				<div id="tab-modules">
					<table class="form">

						<tr>
							<td><?php echo $prefix_class; ?></td>
							<td>
								<?php $module_row = 0; ?>
								<input name="pavreassurance_module[<?php echo $module_row; ?>][prefix]" value="<?php echo ( isset($module['prefix'])?$module['prefix']:'' ) ?>"/>
							</td>
						</tr>

						<tr>
							<td><?php echo $entry_layout; ?></td>
							<td>
								<select name="pavreassurance_module[<?php echo $module_row; ?>][layout_id]">
									<?php foreach ($layouts as $layout) { ?>
									<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
									<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
							</td>
						</tr>

						<tr>
							<td><?php echo $entry_position; ?></td>
							<td>
								<select name="pavreassurance_module[<?php echo $module_row; ?>][position]">
									<?php foreach( $positions as $pos ) { ?>
									<?php if ($pos == $module['position']) { ?>
									<option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
									<?php } else { ?>
									<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
									<?php } ?>
									<?php } ?> 
								</select>
							</td>
						</tr>

						<tr>
							<td><?php echo $entry_status; ?></td>
							<td>
								<select name="pavreassurance_module[<?php echo $module_row; ?>][status]">
									<?php if ($module['status']) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td><?php echo $entry_sort_order; ?></td>
							<td><input type="text" name="pavreassurance_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo isset($module['sort_order'])?$module['sort_order']:''; ?>" size="3" /></td>
						</tr>

					</table>
				</div>

				<div id="tab-data">

					<?php $reassurence_row = 1; ?>
					<div class="vtabs">
						<?php if(isset($module['pavreassurances']) && !empty($module['pavreassurances'])) { ?>
							<?php $reassurence_row = 1; ?>
							<?php foreach ($module['pavreassurances'] as $reassuarance) { ?>
							<a href="#tab-module-<?php echo $reassurence_row; ?>" id="module-<?php echo $reassurence_row; ?>"><?php echo $tab_module . ' ' . $reassurence_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $reassurence_row; ?>').remove(); $('#tab-module-<?php echo $reassurence_row; ?>').remove(); return false;" /></a>
							<?php $reassurence_row++; ?>
							<?php } ?>
						<?php } //end check isset reassuarances data?>
						<span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
					</div>
					<?php //echo '<pre>'.print_r($module['pavreassurances'],1);die; ?>
					<?php if(isset($module['pavreassurances']) && !empty($module['pavreassurances'])) { ?>
						<?php $reassurence_row = 1; ?>
						<?php foreach ($module['pavreassurances'] as $reassuarance) { ?>
						<div id="tab-module-<?php echo $reassurence_row; ?>" class="vtabs-content">

							<table class="form">
								<tr>
									<td><?php echo $lang_select_icon; ?></td>
									<td>
										<input name="pavreassurance_module[<?php echo $module_row; ?>][pavreassurances][<?php echo $reassurence_row; ?>][select_icon]" value="<?php echo ( isset($reassuarance['select_icon'])?$reassuarance['select_icon']:'' ) ?>" size="50" />
										<span class="help"><?php echo $lang_description ?> <a href="http://fortawesome.github.io/Font-Awesome/icons/">fortawesome.github.io/Font-Awesome/icons/</a></span>
									</td>
								</tr>							
							</table>

							<?php /*
							// Language Tab */ ?>
							<div id="language-<?php echo $reassurence_row; ?>" class="htabs">
								<?php foreach ($languages as $language) { ?>
								<a href="#tab-language-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
								<?php } ?>
							</div>

							<?php /*
							// Input title and Text editor */ ?>
							<?php foreach ($languages as $language) { ?>
							<div id="tab-language-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>">
								<table class="form">

									<tr>
										<td><?php echo $lang_module_title; ?></td>
										<td>
											<input type="text" name="pavreassurance_module[<?php echo $module_row; ?>][pavreassurances][<?php echo $reassurence_row; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($reassuarance['title'][$language['language_id']]) ? $reassuarance['title'][$language['language_id']] : ''; ?>" size="50" />
										</td>
									</tr>

									<tr>
										<td><?php echo $lang_content; ?></td>
										<td>
											<textarea cols="30" rows="5" name="pavreassurance_module[<?php echo $module_row; ?>][pavreassurances][<?php echo $reassurence_row; ?>][caption][<?php echo $language['language_id']; ?>]" id="caption-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($reassuarance['caption'][$language['language_id']]) ? $reassuarance['caption'][$language['language_id']] : ''; ?></textarea>
										</td>
									</tr>

									<tr>
										<td><?php echo $lang_detail; ?></td>
										<td>
											<textarea cols="60" rows="10" name="pavreassurance_module[<?php echo $module_row; ?>][pavreassurances][<?php echo $reassurence_row; ?>][detail][<?php echo $language['language_id']; ?>]" id="detail-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($reassuarance['detail'][$language['language_id']]) ? $reassuarance['detail'][$language['language_id']] : ''; ?></textarea>
										</td>
									</tr>

								</table>
							</div>
							<?php } ?>

						</div>
						<?php $reassurence_row++; ?>
						<?php } //end foreach ?>
					<?php } //end check data ?>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript"><!--

<?php /* // CKEDITOR */ ?>
<?php $reassurence_row = 1; ?>
<?php foreach ($module['pavreassurances'] as $reassuarance) { ?>
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('caption-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});
	CKEDITOR.replace('detail-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});
	<?php } ?>
	<?php $reassurence_row++; ?>
<?php } ?>

//--></script>

<script type="text/javascript"><!--
	var module_row = <?php echo $module_row; ?>;

	var reassurence_row = <?php echo $reassurence_row; ?>;

	function addModule() {
		html  = '<div id="tab-module-' + reassurence_row + '" class="vtabs-content">';

		html += '	<table class="form">';
		html += '		<tr>';
		html += '			<td><?php echo $lang_select_icon; ?></td>';
		html += '			<td><input name="pavreassurance_module['+module_row+'][pavreassurances]['+reassurence_row+'][select_icon]" id="pavreassurance[<?php echo $reassurence_row; ?>][select_icon]" size="50" value="fa-comments-o"/></p>';
		html += '				<span class="help"><?php echo $lang_description ?> <a href="http://fortawesome.github.io/Font-Awesome/icons/">fortawesome.github.io/Font-Awesome/icons/</a></span></td>';
		html += '		</tr>';
		html += '	</table>';

		<?php /*
		// Language Tab */ ?>
		html += '<div id="language-' + reassurence_row + '" class="htabs">';
		<?php foreach ($languages as $language) { ?>
		html += '<a href="#tab-language-'+ reassurence_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
		<?php } ?>
		html += '</div>';

		<?php /* 
		// Text Editor
		*/ ?>
		<?php foreach ($languages as $language) { ?>
		html += '    <div id="tab-language-'+ reassurence_row + '-<?php echo $language['language_id']; ?>">';
		html += '      <table class="form">';
		html += '        <tr>';
		html += '          <td><?php echo $lang_module_title; ?></td>';
		html += '          <td><input value="title" type="text" name="pavreassurance_module['+module_row+'][pavreassurances]['+reassurence_row+'][title][<?php echo $language['language_id']; ?>]" id="title-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>" size="50"/></td>';
		html += '        </tr>';
		html += '        <tr>';
		html += '          <td><?php echo $lang_content; ?></td>';
		html += '          <td><textarea cols="30" rows="5" name="pavreassurance_module['+module_row+'][pavreassurances]['+reassurence_row+'][caption][<?php echo $language['language_id']; ?>]" id="caption-' + reassurence_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
		html += '        </tr>';
		html += '        <tr>';
		html += '          <td><?php echo $lang_detail; ?></td>';
		html += '          <td><textarea cols="30" rows="5" name="pavreassurance_module['+module_row+'][pavreassurances]['+reassurence_row+'][detail][<?php echo $language['language_id']; ?>]" id="detail-' + reassurence_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
		html += '        </tr>';
		html += '      </table>';
		html += '    </div>';
		<?php } ?>

		html += '</div>';

		$('#tab-data').append(html);

		<?php /* //CKEDITOR */ ?>
		<?php foreach ($languages as $language) { ?>
		CKEDITOR.replace('caption-' + reassurence_row + '-<?php echo $language['language_id']; ?>', {
			filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});
		CKEDITOR.replace('detail-<?php echo $reassurence_row; ?>-<?php echo $language['language_id']; ?>', {
			filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});
		<?php } ?>

		$('#language-' + reassurence_row + ' a').tabs();
	
		$('#module-add').before('<a href="#tab-module-' + reassurence_row + '" id="module-' + reassurence_row + '"><?php echo $tab_module; ?> ' + reassurence_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + reassurence_row + '\').remove(); $(\'#tab-module-' + reassurence_row + '\').remove(); return false;" /></a>');
		
		$('.vtabs a').tabs();
		
		$('#module-' + reassurence_row).trigger('click');
		
		reassurence_row++;
	}
--></script>

<script type="text/javascript"><!--
	$("#tabs-modules a").tabs();
	$('#tabs-modules a').click( function(){
		$.cookie("sactived_tab", $(this).attr("href") );
	} );

	if( $.cookie("sactived_tab") !="undefined" ){
		$('#tabs-modules a').each( function(){ 
			if( $(this).attr("href") ==  $.cookie("sactived_tab") ){
				$(this).click();
				return ;
			}
		} );
	}

	$('.vtabs a').tabs();
//--></script>

<script type="text/javascript"><!--
<?php if(isset($module['pavreassurances']) && !empty($module['pavreassurances'])){ ?>
	<?php $reassurence_row = 1; ?>
	<?php foreach ($module['pavreassurances'] as $reassuarance) { ?>
	$('#language-<?php echo $reassurence_row; ?> a').tabs();
	<?php $reassurence_row++; ?>
	<?php } ?>
<?php } ?> 
//--></script>

<?php echo $footer; ?>