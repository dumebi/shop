<?php echo $header; ?>

<?php   
	$adminModuleViewDir = DIR_TEMPLATE . 'module/themecontrol/';
?>
<div id="content">
 <div class="button-fixed "><a href="<?php echo $ajax_clearcache; ?>" class="ajax-action"><?php echo $this->language->get('text_clear_jscss_cache');?></a></div>
 
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="sform">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>

  <?php if( isset($alert_info) ){ ?>
  	  <div class="alert alert-success"><?php echo $alert_info; ?></div>
   <?php } ?>
  <div class="box"  id="themepanel">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
	  
      <div class="buttons">
	  <a class="button button-action btn-save" rel=""><span class="fa fa-save"></span> <?php echo $button_save; ?></a>
	  <a id="button_save_keep" class="button button-action btn-save" rel="save-edit"> <span class="fa fa-save"></span> <?php echo $button_save_keep; ?></a>
	 
	  <a href="<?php echo $cancel; ?>" class="button"><span class="fa fa-mail-reply"></span> <?php echo $button_cancel; ?></a> |
	   <a href="<?php echo $live_customizing_url;?>" class="button"><span class="fa fa-magic"></span> <?php echo $this->language->get('text_live_edit');?></a> | 
	   <a rel="" class="green button custom-popup btn-save" href="<?php echo trim($themeinfo['guide']);?>" id="btn-guide"><span class="fa fa-book"></span>  <?php echo $this->language->get('UserGuide');?></a>
	  </div>
    </div>
    <div class="content">
		
	 <div class="entry-theme">
		<b class="label"> <span class="fa fa-wrench"></span> <?php echo $this->getLang("text_default_theme");?></b>
		<select name="themecontrol[default_theme]">
			<?php foreach( $templates as $template ): ?>
			<?php  $selected= $template == $module['default_theme']?'selected="selected"':'';	?>
			<option value="<?php echo $template;?>" <?php echo $selected; ?>><?php echo $template; ?></option>
			<?php endforeach; ?>
		</select>
 

		<?php if( isset($first_installation) )  { ?>
			<div class="label" style="float:right"><?php echo $this->language->get("text_first_installation"); ?></div>
		<?php } ?>
	  </div>
	  
		<div class="ibox">
      
	  
	
		 <div id="tabs" class="htabs">
			
			<a href="#tab-general"><span class="fa fa-gear"></span> <?php echo $tab_general; ?></a>
			<a href="#tab-pages-layout"><span class="fa fa-files-o"></span> <?php echo $this->language->get('tab_modules_pages');?></a>
			

			<a href="#tab-font"><span class="fa fa-font"></span> <?php echo $tab_font; ?></a>
			<?php if(  isset($imodules) && is_array($imodules) ){ ?>
			<a href="#tab-imodules"><span class="fa fa-gears"></span> <?php echo $this->language->get('tab_internal_modules');?></a>
			<?php } ?>
			<a href="#tab-modules"><span class="fa fa-bars"></span> <?php echo $this->language->get('tab_modules_layouts');?></a>
			<?php if( isset($samples) && $samples )  { ?>
			<a href="#tab-datasample"><span class="fa fa-cloud-download"></span> <?php echo $this->language->get('tab_datasample');?></a>
			<?php } ?>
			<a href="#tab-compress"><span class="fa fa-tachometer"></span> <?php echo $this->language->get('tab_compression');?></a>
			<a href="#tab-customcode"><span class="fa fa-mail-reply"></span> <?php echo $this->language->get('tab_customcode');?></a>
			<a href="#tab-support"><span class="fa fa-info"></span> <?php echo $this->language->get('tab_information'); ?> </a>
		 </div>
		 <input type="hidden" name="themecontrol[layout_id]" value="1">
		 <input type="hidden" name="themecontrol[position]" value="1">


		<div id="tab-contents">
				
				<div id="tab-pages-layout">
		  			 <?php include( $adminModuleViewDir.'tab/pages-setting.tpl'); ?>
				</div>  

				<div id="tab-general">
					<?php include( $adminModuleViewDir.'tab/general-setting.tpl'); ?>

					<?php if( isset($theme_customizations) && is_array($theme_customizations) && isset($theme_customizations['layout']) ) { ?>
					<h3><?php echo $this->language->get('text_template_layouts_setting'); ?></h3> 
		  			 <div class="theme-customizations">
		  			 		<table class="form">
		  			 		<?php foreach($theme_customizations['layout'] as $bhead => $bcustoms ) {  
		  			 			$ckey = trim(strtolower($bhead));
		  			 			$default = isset($bcustoms['default'])?trim($bcustoms['default']):"";
		  			 			$selected = isset($module[$ckey])?$module[$ckey]:$default;
		  			 			$label = isset($bcustoms['label'])?$bcustoms['label']:$bhead;
		  			 		 ?>
		  			 			<div class="theme-custom-block">
		  			 				<tr>
			  			 				<td><label><?php echo $this->language->get( ucfirst( str_replace("_"," ",$label)) ); ?></label></td>
			  			 				<td>
			  			 					<?php if( isset($bcustoms['type']) && ($bcustoms['type']) == 'text') { ?>
			  			 						<input value="<?php echo $selected; ?>" name="themecontrol[layout_<?php echo trim(strtolower($bhead)); ?>]">
			  			 					<?php } else { ?>
			  			 					<select name="themecontrol[<?php echo $ckey; ?>]">
			  			 						<?php foreach( $bcustoms['option'] as $okey => $ovalue ) {  ?>
			  			 						<option <?php if($ovalue['value']==$selected) { ?> selected="selected" <?php } ?> value="<?php echo $ovalue['value']; ?>"><?php echo $this->language->get($ovalue['text']); ?></option>
			  			 						<?php } ?>
			  			 					</select>
			  			 					<?php } ?>
			  			 				</td>
			  			 			</tr>

		  			 			</div>
		  			 		<?php } ?>
		  			 		</table>
		  			 </div>
		  			 <?php } ?>
				</div>
				
				<?php if(  isset($imodules) && is_array($imodules) ){ ?>
				<div id="tab-imodules">
					<p><?php echo $this->language->get('text_explain_internal_modules'); ?></p>
					
					<div class="inner-modules-wrap clearfix">	 
						<div class="vtabs mytabs" id="my-tab-innermodules">
							<?php foreach( $imodules as $key => $imod ) { ?>
							<a onclick="return false;" href="#tab-imodule-<?php echo $key; ?>" class="selected"><?php echo $this->language->get( $imod['title'] );?></a>
							<?php } ?>
						</div>
						 <div class="page-tabs-wrap">
         					<?php foreach( $imodules as $key => $imod ) { ?>
         						<div id="tab-imodule-<?php echo $key;?>">
         						<?php 
         						if( is_object($imod['module'])){ 	
         							$imod['module'] = array(  $imod['module'] );
         						}
         						foreach( $imod['module'] as $mkey => $mod ) { ?>	
         				
             							<div class="panel">
             								<div class="panel-title"><?php echo $mod->title?></div>
             								<div class="panel-content">
         									    <table class="form">
             									<?php 
             									 $mod = (array)$mod;		
             							 		$fields = is_object($mod['field'])?array($mod['field']):$mod['field'];		 
             									 foreach( $fields as  $f ) { ?>
             										<tr>
             											<td><?php echo $f->label; ?></td>
             											<td>
	             										 <?php if( $f->type=='text') { ?>
		             										  <?php foreach ($languages as $language) { ?>
		             											<?php $text = ( isset($module[trim($f->name)][$language['language_id']]) ? trim($module[trim($f->name)][$language['language_id']]) : $f->default );  ?>

		             										  <p class="clearfix">
		             										  	<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		             										 	<input size="100" value="<?php echo $text; ?>" type="text" name="themecontrol[<?php echo trim($f->name);?>][<?php echo $language['language_id']; ?>]">
		             										 </p>
		             										 <?php } ?>	 
	             										 <?php }elseif( $f->type == 'textarea' ) { ?>
	             										    <?php foreach ($languages as $language) { ?>
	             										    	<?php $text = ( isset($module[trim($f->name)][$language['language_id']]) ? trim($module[trim($f->name)][$language['language_id']]) : $f->default );  ?>
	             										     <p class="clearfix">
	             										   		<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
	             										 		<textarea id="w<?php echo trim($f->name);?>-<?php echo $language['language_id']; ?>"  name="themecontrol[<?php echo trim($f->name);?>][<?php echo $language['language_id']; ?>]"><?php echo $text;?></textarea>
	             											 </p>
	             										 	<?php } ?>	 

																<script type="text/javascript"><!--
																$("#language-support_data a").tabs();
																<?php foreach( $languages as $language )  { ?>
																	CKEDITOR.replace('w<?php echo trim($f->name);?>-<?php echo $language['language_id']; ?>', {
																	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
																	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
																	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
																	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
																	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
																	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
																});
																<?php } ?>
																</script>

	             										 <?php } ?>
             											</td>
             										</tr> 
             									<?php } ?>	
             								</table>
             								</div>
             							</div>
         								 
         						<?php } ?>
         						</div>
         					<?php } ?>
         				</div>
					</div>		
				</div>	
				<?php } ?>
				<div id="tab-font">
					<?php include( $adminModuleViewDir."tab/font-setting.tpl" ); ?>
					
				</div>
	
				<div id="tab-modules">
					<?php
						if( !file_exists($layouttpl) ) {
							include( $adminModuleViewDir."tab/layout-setting.tpl" ); 
						}else {
							include( $layouttpl );
						}
					?>
				</div>
				
				
				
				<input type="hidden" name="action_type" id="action_type" value="new">
				<?php if( isset($samples) && $samples )  { ?>
			
				<div id="tab-datasample">
					<?php include( $adminModuleViewDir."tab/datasample.tpl" ); ?>	
				</div>
				<?php } ?>
				<div id="tab-compress">
					<?php include( $adminModuleViewDir.'tab/compress-setting.tpl' ); ?>
				</div>
				<div id="tab-customcode">
					<?php include( $adminModuleViewDir.'tab/customize-setting.tpl' ); ?>
				</div>
				
				<div id="tab-support">
					<h3>
						<?php echo $themeinfo['name'];?>
					</h3>	
					<div class="theme-info">
						<h4><?php echo $this->language->get('text_information'); ?></h4>
						<?php echo $themeinfo['description'];?>
					</div>	
					<div class="theme-info">
						<h4><?php echo $this->language->get('text_support_info'); ?></h4>
						<?php echo $themeinfo['support'];?>
					</div>	
				</div>
	   </div>
    </div></div>
  </div>
</form>
  
</div>
 <script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
 <script type="text/javascript"><!--

 	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('customtab-content-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	CKEDITOR.replace('contact_customhtml<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?>

$('#tabs a').tabs(); 
$('.mytabs a').tabs();
$('#languages a').tabs();
$('#tab-pages-layout a').tabs();
$('#tabs a').click( function(){
	$.cookie("actived_tab", $(this).attr("href") );
} );

if( $.cookie("actived_tab") !="undefined" ){
	$('#tabs a').each( function(){
		if( $(this).attr("href") ==  $.cookie("actived_tab") ){
			$(this).click();
			return ;
		}
	} );
	
}
$(document).ready( function(){		
		$(".button-action").click( function(){
			$('#action_type').val( $(this).attr("rel") );
			var string = 'rand='+Math.random();
			var hook = '';
			$(".ui-sortable").each( function(){
				if( $(this).attr("data-position") && $(".module-pos",this).length>0) {
					var position = $(this).attr("data-position");
					$(".module-pos",this).each( function(){
						if( $(this).attr("data-id") != "" ){
							hook += "modules["+position+"][]="+$(this).attr("data-id")+"&";
						}				
					} );
					string = string.replace(/\,$/,"");
					hook = hook.replace(/\,$/,"");
				}	
			} );
			var unhook = '';

			$.ajax({
			  type: 'POST',
			  url: '<?php echo str_replace("&amp;","&",$ajax_modules_position);?>',
			  data: string+"&"+hook+unhook,
			  success: function(){
				$('#sform').submit();
				// 	window.location.reload(true);
			  }
			});
		return false; 
	} );

	$("a.ajax-action").click( function(){
		$(this).append('<span class="ajax-loading">Procesing...</span>');
		var _a = this;
		var url = $(this).attr('href');
		$.ajax({
			  type: 'POST',
			  url: url,
			  data: 'rand='+Math.random(),
			  success: function(){
			  	$(".ajax-loading",_a).remove();
			 }
		});	 
		return false; 
	} );
} );

$(".group-change").each( function(){
	var $this = this;
	$(".items-group-change",$this).hide();  //  alert( $(".type-fonts",this).val() );
	$(".group-"+$(".type-fonts",$this).val(), this).show();
	
	$(".type-fonts", this).change( function(){
		$(".items-group-change",$this).hide();
		$(".group-"+$(this).val(), $this).show();
	} );
});


$(".custom-popup").click( function(){
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="'+$(this).attr('href')+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Guide For Theme: <?php echo $module["default_theme"]; ?>',
		close: function (event, ui) {},	
		bgiframe: false,
		width: 980,
		height: 560,
		resizable: false,
		modal: true
	});
	return false;
} );
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<?php echo $footer; ?>