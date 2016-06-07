<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

$module_key = isset($module_key)?$module_key:'pavblogcomment';
?>

      <div id="<?php echo $module_key; ?>">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" id="module-<?php echo $module_key; ?>-<?php echo $module_row; ?>"><?php echo $this->language->get("tab_module") . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_key; ?>-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add-<?php echo $module_key; ?>"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModuleComment();" /></span> </div>
        <?php $module_row = 1; ?>
		  
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" class="vtabs-content">
         
		
          <table class="form">
		
			<tr>
				 <td class="left"><?php echo $this->language->get("entry_carousel"); ?></td>
				  <td class="left">
        
				<input type="text" name="pavblogcomment_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="3"/>
                <?php if (isset($error_carousel[$module_row])) { ?>
                <span class="error"><?php echo $error_carousel[$module_row]; ?></span>
                <?php } ?></td>
			</tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="pavblogcomment_module[<?php echo $module_row; ?>][layout_id]">
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
              <td><select name="pavblogcomment_module[<?php echo $module_row; ?>][position]">
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
              <td><select name="pavblogcomment_module[<?php echo $module_row; ?>][status]">
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
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="pavblogcomment_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </div>
<script type="text/javascript"><!--
var module_row_comment = <?php echo $module_row; ?>;

function addModuleComment() {	
	html  = '<div id="tab-module-<?php echo $module_key; ?>-' + module_row_comment + '" class="vtabs-content">';
	html += '  <table class="form">';

	html += '      <td><?php echo $this->language->get("entry_carousel"); ?></td>';
	html += '    <td class="left"><input type="text"  <input type="text" name="pavblogcomment_module[' + module_row_comment + '][limit]" value="6" size="3" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select name="pavblogcomment_module[' + module_row_comment + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select name="pavblogcomment_module[' + module_row_comment + '][position]">';
	<?php foreach( $positions as $pos ) { ?>
	html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>		html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="pavblogcomment_module[' + module_row_comment + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="pavblogcomment_module[' + module_row_comment + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#<?php echo $module_key; ?>').append(html);
	
	$('#module-add-<?php echo $module_key; ?>').before('<a href="#tab-module-<?php echo $module_key; ?>-' + module_row_comment + '" id="module-<?php echo $module_key; ?>-' + module_row_comment + '"><?php echo $this->language->get("tab_module"); ?> ' + module_row_comment + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-<?php echo $module_key; ?>-' + module_row_comment + '\').remove(); $(\'#tab-module-<?php echo $module_key; ?>-' + module_row_comment + '\').remove(); return false;" /></a>');
	
	$('#<?php echo $module_key; ?> .vtabs a').tabs();
	
	$('#module-<?php echo $module_key; ?>-' + module_row_comment).trigger('click');
	
	module_row_comment++;
}
//--></script> 
<script type="text/javascript"><!--
$('#<?php echo $module_key; ?> .vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_key; ?>-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
