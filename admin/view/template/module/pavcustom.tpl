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
        <a class="button" onclick="$('#pavcustom_module_action').val('saveedit');$('#form').submit();"><?php echo $this->language->get('text_save_edit'); ?></a>
        <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <label style="font-weight: bold;color:red;"><?php echo $this->language->get('entry_default_store'); ?></label>
        <select id="pavstores" name="pavcustom_module[stores]">
          <?php foreach($stores as $store):?>
          <?php if($store['store_id'] == $store_id):?>
            <option value="<?php echo $store['store_id'];?>" selected="selected"><?php echo $store['name'];?></option>
          <?php else:?>
            <option value="<?php echo $store['store_id'];?>"><?php echo $store['name'];?></option>
          <?php endif;?>
          <?php endforeach;?>
        </select>
        <input type="hidden" value="<?php echo $store_id;?>" name="pavcustom_module[store_id]"/></br></br>
        <div class="vtabs">
            <input type="hidden" name="pavcustom_module[action]" id="pavcustom_module_action" value="" size="3" />
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="language-<?php echo $module_row; ?>" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_module_title; ?></td>
                <td><input size="60" name="pavcustom_module[<?php echo $module_row; ?>][module_title][<?php echo $language['language_id']; ?>]" id="module_title-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" value="<?php echo isset($module['module_title'][$language['language_id']]) ? $module['module_title'][$language['language_id']] : ''; ?>"/></td>
              </tr>

              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="pavcustom_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php } ?>
          <table class="form">
              <tr>
                <td><?php echo $this->language->get('entry_show_title'); ?></td>
                <td><select name="pavcustom_module[<?php echo $module_row; ?>][show_title]">
                    <?php if ($module['show_title']) { ?>
                    <option value="1" selected="selected"><?php echo $this->language->get('text_show'); ?></option>
                    <option value="0"><?php echo $this->language->get('text_hide'); ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $this->language->get('text_show'); ?></option>
                    <option value="0" selected="selected"><?php echo $this->language->get('text_hide'); ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_layout; ?></td>
                <td><select name="pavcustom_module[<?php echo $module_row; ?>][layout_id]">
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_position; ?></td>
                <td><select name="pavcustom_module[<?php echo $module_row; ?>][position]">
                    <?php foreach( $positions as $pos ) { ?>
                    <?php if ($module['position'] == $pos) { ?>
                    <option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
                    <?php } ?>
                    <?php } ?> 
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select name="pavcustom_module[<?php echo $module_row; ?>][status]">
                    <?php if ($module['status']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>

			       <tr>
              <td><?php echo $entry_module_class; ?></td>
               <td><input type="text" name="pavcustom_module[<?php echo $module_row; ?>][module_class]" value="<?php echo isset($module['module_class'])?$module['module_class']:""; ?>" size="20" /></td>
            </tr>

            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="pavcustom_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>

        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
$(document).ready( function() {
  $('#pavstores').bind('change', function () {
      url = 'index.php?route=module/pavcustom&token=<?php echo $token; ?>';
      var id = $(this).val();
      if (id) {
          url += '&store_id=' + encodeURIComponent(id);
      }
      window.location = url;
  });
});


<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
    html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
	html += '  </div>';

	<?php foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '      <table class="form">';
	html += '        <tr>';
	html += '          <td><?php echo $entry_module_title; ?></td>';
	html += '          <td><input name="pavcustom_module[' + module_row + '][module_title][<?php echo $language['language_id']; ?>]" id="module_title-' + module_row + '-<?php echo $language['language_id']; ?>"/></td>';
	html += '        </tr>';
	html += '        <tr>';
	html += '          <td><?php echo $entry_description; ?></td>';
	html += '          <td><textarea name="pavcustom_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
	html += '        </tr>';
	html += '      </table>';
	html += '    </div>';
	<?php } ?>

	html += '  <table class="form">';

  html += '<tr>';
  html += '            <td><?php echo $this->language->get('entry_show_title'); ?></td>';
  html += '            <td><select name="pavcustom_module[<?php echo $module_row; ?>][show_title]">';
  html += '                <option value="1"><?php echo $this->language->get('text_show'); ?></option>';
  html += '                <option value="0"><?php echo $this->language->get('text_hide'); ?></option>';
  html += '              </select></td>';
  html += '          </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select name="pavcustom_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '    <td class="left"><select name="pavcustom_module[' + module_row + '][position]">';
	 <?php foreach( $positions as $pos ) { ?>
            html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>			  
	html += '    </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="pavcustom_module[' + module_row + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_module_class; ?></td>';
	html += '      <td><input type="text" name="pavcustom_module[' + module_row + '][module_class]" value="" size="13" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="pavcustom_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);
	
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?>
	
	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>