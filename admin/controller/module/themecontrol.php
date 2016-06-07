<?php
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 2.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) October 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

require_once( DIR_SYSTEM . 'pavothemes/framework.php' );
require_once( DIR_SYSTEM . 'pavothemes/theme.php' );

/**
 *
 *
 */
class ControllerModuleThemeControl extends Controller {

	/**
	 *
	 */
	private $error = array(); 
	
	/**
	 *
	 */
	private $theme = ''; 
	
	/**
	 *
	 */
	private $moduleName = 'themecontrol';
	
	/**
	 *
	 */
	private $theme_path = '';
	
	/**
	 *
	 */
	public function setTheme( $theme ){
		$this->theme = $theme;
		return $this;
	}
	
	/**
	 *
	 */
	public function getTheme(){
		return $this->theme;
	}
	
	/**
	 *
	 */
	public function index() {   

		$this->load->model('setting/setting');
		$this->load->model('tool/image');

		$this->data['module'] = array(	
						'default_theme' =>'',
						'skin' 			=> '',
						'theme_width'   => 'auto',
						'fontsize'		=>'12',
						'enable_custom_copyright' =>0,
						'copyright' => 'Copyright 2014 PavoThemes.Com.',
						'responsive' => 1,
						'enable_offsidebars' => 1,
						'enable_customfont' => 0,
						'enable_paneltool'  => 0,
						'enable_footer_center' => 1,
						'block_showcase'  => '',
						'block_promotion' => '',
						'block_footer_top'=>'',
						'block_footer_center' => '',
						'block_footer_bottom'=>'',
						'body_pattern' => '',
						'enable_product_customtab'=>'',
						'product_related_column'=> '',
						'product_customtab_content' => '',
						'product_customtab_name' => '',

						'fontsize1'   => '',
						'type_fonts1' => array(),
						'normal_fonts1' => array(),
						'google_url1' => '',
						'google_family1' => '',
						'body_selector1' => '',
						
						'fontsize2'   => '',
						'type_fonts2' => array(),
						'normal_fonts2' => array(),
						'google_url2' => '',
						'google_family2' => '',
						'body_selector2' => '',
						
						'fontsize3'   => '',
						'type_fonts3' => array(),
						'normal_fonts3' => array(),
						'google_url3' => '',
						'google_family3' => '',
						'body_selector3' => '',

						'fontsize4'   => '',
						'type_fonts4' => array(),
						'normal_fonts4' => array(),
						'google_url4' => '',
						'google_family4' => '',
						'body_selector4' => '',

						'custom_css' =>'',
						'custom_javascript' =>'',
						'bg_image'   => '',
						'use_custombg' => 0,
						'enable_custom_background'=>'',
						'bg_repeat' => 'repeat'	,
						'bg_position' => 'left top'	,
						'listing_products_columns' => '0',
						'listing_products_columns_small' => '2',
						'listing_products_columns_minismall'=> '1',
						'cateogry_display_mode'=>'grid',
						'category_saleicon' => 1,
						'category_pzoom' => 1,	
						'product_enablezoom' => 1,
						'product_zoommode' => 'basic',
						'product_zoomeasing' => 1,		
						'product_zoomlenssize' => 150,
						'product_zoomlensshape' => 'normal',		
						'product_zoomgallery'   => 0,		
						'show_swap_image'			=> 0,	
						'location_address' => '79-99 Beaver Street, New York, NY 10005, USA',
						'location_latitude' => '40.705423',
						'location_longitude' => '-74.008616',
						//end edit code
						'contact_customhtml'    => '',
						'enable_compress_css'   => 0,
						'exclude_css_files'     => 'bootstrap.css',
						'enable_development_mode' => 0,
						'customize_theme' => ''
											
		);
		

 		$module = $this->config->get($this->moduleName);
 		if ( $this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
		 	if(  isset($this->request->post['action_type']) &&  $this->request->post['action_type'] == 'save-importprofile' && ($this->request->server['REQUEST_METHOD'] == 'POST') ){
				if( isset($_FILES['upload']['tmp_name']) && $_FILES['upload']['tmp_name'] ){
					$content = file_get_contents( $_FILES['upload']['tmp_name'] );
					if( !empty($content) ) {
						$profile = @unserialize( $content );
						if( isset($profile['modules']) ) {
							$this->load->model('sample/module');
							$this->model_sample_module->importProfiles(  $profile, array(), $this->themeName );
						} 
				 		$this->data['alert_info'] = $this->language->get('alert_import_profile_success');
					}	
				}
				$this->request->server['REQUEST_METHOD'] = 'GET';
				$this->request->post = null;

			}
		}

		if( empty($module) ) {
			$default_data = array();
			$default_data[$this->moduleName]=$this->data['module'];
			$this->model_setting_setting->editSetting( $this->moduleName, $default_data );	 
			$this->data['first_installation'] = 1;
		}

		if (isset($this->request->post[$this->moduleName])) {
			$this->data['module'] = $this->request->post[$this->moduleName];
		} elseif ($this->config->get($this->moduleName)) { 
			$this->data['module'] = array_merge($this->data['module'],$module);
		}	
		
		$this->document->addStyle('view/stylesheet/themecontrol.css');
		$this->document->addScript('view/javascript/jquery/jquerycookie.js');
		$this->language->load('module/'.$this->moduleName);	
		
		$this->document->setTitle( strip_tags($this->language->get('heading_title')) );
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		// themes 
		$directories = (array)glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);
		$this->data['templates'] = array();
		if(isset($directories) && !empty($directories)){
			foreach ($directories as $directory) {	 
				if( file_exists($directory."/etc/config.ini") ){
					$this->data['templates'][] = basename($directory);
				}
			}
		}

		if( count($this->data['templates']) && empty($this->data['module']['default_theme'])  ){  
			$this->data['module']['default_theme'] = $this->data['templates'][0];
			
		}	
	
		$this->setTheme( $this->data['module']['default_theme']  ); 		
	
		$this->data['skins']	 = PavoThemeHelper::getSkins( $this->getTheme() );

		$this->data['hasskinsprofile'] = false; 
		if( $this->data['skins'] ){
			foreach( $this->data['skins'] as $skin ){
				if( file_exists(PavoThemeHelper::getPathProfileBySkin( $this->getTheme(), $skin )) ){
					$this->data['hasskinsprofile'] = true;
					break;
				}
			}	
		}

		$this->data['theme_url'] = HTTP_CATALOG."/catalog/view/theme/".$this->getTheme()."/";
		$this->themePath 	 	 = DIR_CATALOG . 'view/theme/'.$this->getTheme().'/';

		if( is_file($this->themePath.'stylesheet/font-awesome.css') ){     
			$this->document->addStyle(  HTTP_CATALOG."/catalog/view/theme/".$this->getTheme()."/stylesheet/font-awesome.css" );
		}	
		//
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) { 
	
			$data = $this->request->post['themecontrol'];
			$a = $this->request->post['action_type'];
			$this->request->post= array();
			$this->request->post['themecontrol'] = $data;
 			/**/
 			 
			if( is_dir($this->themePath.'stylesheet/local/') ){
				$t = $this->themePath.'stylesheet/local/custom.css';
				if( $data['custom_css'] ) {
					PavoThemeHelper::writeToCache( $this->themePath.'stylesheet/local/', 'custom', $data['custom_css'], 'css' );	
				}else if( file_exists($t) && filesize($t) ){
					@unlink($t);
					PavoThemeHelper::writeToCache( $this->themePath.'stylesheet/local/', 'custom', "", 'css' );	
				}
			}

			$this->request->post['themecontrol']['custom_css'] = '';
			$this->model_setting_setting->editSetting($this->moduleName, $this->request->post);	 
			$this->session->data['success'] = $this->language->get('text_success');

			if( isset($data['enable_activeprofile']) && $data['enable_activeprofile'] ){
				$this->load->model('sample/module');
			 	$this->model_sample_module->setActiveByProfileSkin( $this->getTheme(), $data['skin'] );
			}
			if( $a == 'save-edit'  ){
				$this->redirect($this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL'));
			}else {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension'); 
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
			$this->data['button_save_keep'] = $this->language->get('button_save_keep');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['default_theme'] = '';
		$this->data['text_image_manager'] = $this->language->get('text_image_manager'); 
		// table
		$this->data['tab_general'] = $this->language->get( 'tab_general' );
		$this->data['tab_layout'] = $this->language->get( 'tab_layout' );
		$this->data['tab_font'] = $this->language->get( 'tab_font' );
		$this->data['tab_custom'] = $this->language->get( 'tab_custom' );
		$this->data['yesno'] = array(0=>$this->language->get('text_no'),1=>$this->language->get('text_yes'));
		$this->data['bg_thumb'] =  '';
		$this->data['no_image'] =  $this->model_tool_image->resize('no_image.jpg', 180, 180);
		
		$this->data['patterns'] = PavoThemeHelper::getPattern( $this->getTheme() );
		$this->data['product_rows'] = array('0'=> $this->language->get('text_auto'), 1=>1, 2=>2, 3=>3,4=>4,5=>5,6=>6 );
		$this->data['category_saleicons'] = array(
			'text_sale' => 'Sale',
			'text_sale_detail' => 'Saved %s',
			'text_sale_percent' => 'Number %'
		);

		$this->themeLayoutCustomize();

		$this->data['product_zoomgallery'] = array( 
			'basic'  => $this->language->get('text_basic_zoom'),
			'slider' => $this->language->get('text_slider_gallery_zoom')
		);

		$this->data['product_zoom_modes'] = array(
			'basic' => $this->language->get('text_basic_zoom'),
			'inner'	=> $this->language->get('text_inner_zoom'),
			'lens'	=> $this->language->get('text_lens_zoom')
		);
	 
		$this->data['product_zoomlensshapes'] = array(
			'basic' => $this->language->get('text_len_zoom_basic'),
			'round'	=> $this->language->get('text_len_zoom_round'),
			 
		);
		$this->data['type_fonts'] = array(
								array( 'standard', 'Standard'),
								array( 'google', 'Google Fonts'),						
		);
		$this->data['compressions'] = array(
			'' => $this->language->get('text_compress_select'),
			'compress-only'  => $this->language->get('text_compress_only'),
			'compress-merge' => $this->language->get('text_compress_merge')
		);
		$this->data['bg_repeat'] = array('repeat','repeat-x','repeat-y','no-repeat');	
		$this->data['bg_position'] = array('left top','left center','left bottom','center top','center','center bottom','right top','right center','right bottom');	
		
		if( is_dir(DIR_APPLICATION.'model/sample/') && $this->getTheme() ){
			$this->data['unexpectedModules']  = array();
			$this->data['modulesQuery'] = array();

			$this->load->model('sample/module');
			$this->data['samples'] = $this->model_sample_module->getSamplesByTheme( $this->getTheme() );
			$this->data['backup_restore'] = $this->model_sample_module->getBackupByTheme( $this->getTheme() );


			if( !empty($this->data['samples']) ){
				$this->data['modulesQuery'] = $this->model_sample_module->getModulesQuery( $this->getTheme() );
				$tmodules = array_merge($this->data['samples'],$this->data['modulesQuery']);
				$this->data['unexpectedModules'] = $this->getUnexpectedModules( 1, $tmodules );
			}
			
			if( isset($this->request->get['exportprofile']) && $this->hasPermission() ){
				 $this->model_sample_module->exportProfiles( $this->getTheme() );
			}

	
			if( isset($this->request->get['export']) && $this->hasPermission() ){
				 $this->model_sample_module->export( $this->getTheme() );
			}

			if( isset($this->request->get['backup']) && $this->hasPermission() ){
				 $this->model_sample_module->backup( $this->getTheme() );
				 $this->redirect($this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL'));
			}
		
			if( isset($this->request->get['ajax_massinstall']) && !empty($this->data['samples']) ) { 
				$this->model_sample_module->massInstallSample( $this->getTheme(), $this->data['samples'] );
				die('done');
			}
		}
		
		$this->data['normal_fonts'] = PavoThemeHelper::getLocalFonts();
							
		 //general 
		$this->data['fontsizes'] = PavoThemeHelper::getFontSizes();

	 	$fontbase = array();
	 	$fontbase[1] = array(
	 		'label'	=> $this->language->get('text_body_font_setting'),
	 		'selector' => 'body',
	 		'fontsize'	=> 12
	 	);
	 	$fontbase[2] = array(
	 		'label'	=> $this->language->get('text_pageheading_font_setting'),
	 		'selector' => 'h1, #content h1',
	 		'fontsize'	=> 12
	 	);
	 	$fontbase[3] = array(
	 		'label'	=> $this->language->get('text_moduleheading_font_setting'),
	 		'selector' => 'h2,h3,h4,h5, .box-heading, .box-heading span',
	 		'fontsize'	=> 12
	 	);

	 	$this->data['fontbase'] = $fontbase;


		$this->data['cateogry_display_modes'] = array( 'grid'=> $this->language->get('text_grid') , 'list' => $this->language->get('text_list') );
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}
		
		$this->data['token'] = $this->session->data['token'];
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL');
		$this->data['exportprofile_action'] = $this->url->link('module/'.$this->moduleName, 'exportprofile=1&token=' . $this->session->data['token'], 'SSL');

		$this->data['ajax_modules_position'] = $this->url->link('module/'.$this->moduleName."/ajaxsave", 'token=' . $this->session->data['token'], 'SSL');
		$this->data['ajax_massinstall'] = $this->url->link('module/'.$this->moduleName."", 'ajax_massinstall=1&token=' . $this->session->data['token'], 'SSL');
		$this->data['ajax_clearcache'] = $this->url->link('module/'.$this->moduleName."/clearcache", 'token=' . $this->session->data['token'], 'SSL');
		$this->data['ajax_compileless'] =HTTP_CATALOG.'?compileless=1';
		
		$this->data['live_customizing_url'] =  $this->url->link('module/'.$this->moduleName."/customize", 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
					
		$this->load->model('design/layout');
		
		
		$t = DIR_CATALOG . 'view/theme/'.$this->getTheme().'/template/common/admin/modules.tpl';
		$this->data['layouttpl'] = 	DIR_CATALOG . 'view/theme/'.$this->getTheme().'/template/common/admin/layout-setting.tpl'; 

		if( file_exists($t) ){
			$this->data['admin_modules'] = $t;
		}
	
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		$this->load->model('design/banner');
		
		$this->data['banners'] = $this->model_design_banner->getBanners();	
		$this->data['imodules'] = PavoThemeHelper::getInternalModules( $this->getTheme() );	
	 
		
		$this->tabModules();
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['logo_types'] = array(
			'' => $this->language->get('logo_system'),
			'logo-text' => $this->language->get('logo_text'),
			'logo-image' =>  $this->language->get('logo_image'),
		);
	 	
	 	/** CUSTOMIZATION THEME */
	 
	 	$this->themeCustomizePath = $this->themePath.'stylesheet/customize/';
	 	$this->data['customizeFolderURL'] = HTTP_CATALOG.'catalog/view/theme/'.$this->getTheme().'/stylesheet/customize/';
	 	$this->data['files'] = PavoThemeHelper::getFileList( $this->themeCustomizePath , '.css' );
	 	$this->data['development_mode'] = array(
	 		'' 				 => $this->language->get( 'text_no' ),
	 		'compile-export' => $this->language->get( 'text_compile_export' ),
	 		'compile'		 => $this->language->get( 'text_compile_only' )
	 	);
 	
 		if( file_exists($this->themePath.'stylesheet/local/custom.css') ){
 			$content = file_get_contents( $this->themePath.'stylesheet/local/custom.css' );
 			$this->data['module']['custom_css'] = $content;
 		}

 		$this->data['themeinfo'] = PavoThemeHelper::getThemeInfo( $this->getTheme() );

 		 
 		$this->checkingInfo();

		$this->template = 'module/themecontrol/'.$this->moduleName.'.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		
		$this->response->setOutput($this->render());
	}
	
	public function themeLayoutCustomize(){
		$this->data['theme_customizations'] =  PavoThemeHelper::getLayoutSettingByTheme( $this->getTheme() );
	}

	public function checkingInfo(){
		$customFilesWarning = array();
		$developmentWraning = array();
		if( !is_writable($this->themePath.'stylesheet/local/custom.css') ) {
			$customFilesWarning[] = $this->language->get( 'warning_file_permssion_local_custom' )
						. ': <span>'.$this->themePath.'stylesheet/local/custom.css'.'</span>';
		}

		if( !is_writable($this->themePath.'stylesheet/customize') ) {
			$customFilesWarning[] = $this->language->get( 'warning_file_permssion_live_custom' )
					. ': <span>'.$this->themePath.'stylesheet/customize'.'</span>';
		}

		if( !is_writable($this->themePath.'stylesheet') ){
			$developmentWraning[] = $this->language->get( 'warning_file_permssion_development_folder' )
					. ': <span>'.$this->themePath.'stylesheet'.'</span>';
		}

		$this->data['warning_custom_files_permission'] 		= $customFilesWarning;
		$this->data['warning_development_files_permission'] = $developmentWraning;

	}

	/**
	 *
	 */
	public function customize(){

		$this->language->load( 'module/themecontrol' );
		$themeConfig = $this->config->get( 'themecontrol' ); 
	 	$theme = $themeConfig['default_theme'];
	 	$this->theme = $theme;
	 	$this->data['heading_title'] = $this->language->get('heading_title');
		if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
	 		$siteURL = HTTPS_CATALOG;
	 		$adminURL = HTTPS_SERVER;
	 	}else {
	 		$siteURL  = HTTP_CATALOG;
	 		$adminURL = HTTP_SERVER;
	 	}

	 	$this->themePath 				   = DIR_CATALOG . 'view/theme/'.$theme.'/';
	 	$this->themeCustomizePath 		   = $this->themePath.'stylesheet/customize/';
	 	$this->data['customize_form_path'] = '';
	 	$this->data['themeName'] 		   = $theme;
	 	$this->data['siteURL'] 			   = $siteURL;
	 	$this->data['adminURL'] 		   = $adminURL;
	 	$this->data['themePath'] 		   = $this->themePath;
	 	$this->data['customizeFolderURL']  = $siteURL.'catalog/view/theme/'.$theme.'/stylesheet/customize/';
	 	$this->data['backgroundImageURL']  = $siteURL.'catalog/view/theme/'.$theme.'/image/pattern/';
	 	$this->data['token'] 			   = $this->session->data['token'];
	 	$this->data['patterns'] 		   = PavoThemeHelper::getPattern( $this->getTheme() );


 		$this->data['xmlselectors'] 	= PavoThemeHelper::getThemeEditor( $this->getTheme() ); 
 

	 	if( !is_dir($this->themeCustomizePath) ){
	 		$this->data['warning'][] = $this->language->get('warning_theme_customize_folder_not_exists');
	 	}
 
	 	if( !is_writable($this->themeCustomizePath) ){
	 		$this->data['warning'][] = $this->language->get('warning_theme_customize_folder_writeable');
	 	}
	 	 
 
		$this->document->setTitle( strip_tags($this->language->get('heading_title')) );
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$data = $this->request->post;

			$selectors = $this->request->post['customize'];
			$matches = $this->request->post["customize_match"];
			$output = '';

			$cache = array();
			$tmpss = array();
			foreach( $selectors as $match => $customizes  ){
		 
				foreach( $customizes as $key => $customize ){
					if( isset($matches[$match]) && isset($matches[$match][$key]) ){
						$tmp = explode("|", $matches[$match][$key]);
						if( trim($customize) ) {
							if( strtolower(trim($tmp[1])) == 'background-image'){
								$tmpss[$tmp[0]][] =  $tmp[1] . ':url('.$customize .')';	
							}else {
								$prefix = preg_match( "#color#i", $tmp[1] )?"#":"";
								$suffix = preg_match( "#size#i", $tmp[1] )?"px":"";
								$tmpss[$tmp[0]][] =  $tmp[1] . ':'.$prefix.$customize.$suffix; 		
							}
						}
						$cache[$match][] =  array('val'=>$customize,'selector'=>$tmp[0], 'attr' => $tmp[1] );
					}
				}	

			}

			$output = '';

			foreach( $tmpss as $key => $values ){
				$output .= "\r\n/* customize for $key */ \r\n";
				$output .= $key ." { \r\n".implode( ";\r\n", $values )." \r\n} \r\n";
			}
			 
			if(  !empty($data['saved_file'])  ){
				if( $data['saved_file'] && file_exists($this->themeCustomizePath.$data['saved_file'].'.css') ){
					unlink( $this->themeCustomizePath.$data['saved_file'].'.css' );
				}
				if( $data['saved_file'] && file_exists($this->themeCustomizePath.$data['saved_file'].'.json') ){
					unlink( $this->themeCustomizePath.$data['saved_file'].'.json' );
				}
				$nameFile = $data['saved_file'];
			}else {
				if( empty($this->request->post['newfile']) ){
					$nameFile = time();
				}else {
					$nameFile = preg_replace("#\s+#", "-", trim($this->request->post['newfile']));
				}
			}
		
			if( $data['action-mode'] != 'save-delete' ){
				
			 	if( !empty($output) ){
			 		PavoThemeHelper::writeToCache( $this->themeCustomizePath, $nameFile, $output );
			 	}
			 	if( !empty($cache) ){
			 		PavoThemeHelper::writeToCache(  $this->themeCustomizePath, $nameFile, json_encode($cache),"json" );
			 	}

			 }	
			  
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/'.$this->moduleName.'/customize', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['back_url']     = $this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL');
		$this->data['upload_link']  = $this->url->link('module/'.$this->moduleName.'/upload', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['list_file'] = $this->language->get('list_file');
	 	
	 	$this->data['files'] = PavoThemeHelper::getFileList( $this->themeCustomizePath , '.css' );

	 	

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  	 
		
		$this->data['action'] = $this->url->link('module/'.$this->moduleName.'/customize', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		$this->data['themeName'] = $theme;
	  	$this->data['localfonts'] =  PavoThemeHelper::getLocalFonts();
	  	 
		$this->data['store'] = $siteURL;
		
		$customizeForm = '';
		 
		$this->template = 'module/themecontrol/customize.tpl';
		$this->response->setOutput( $this->render() );
	}

	
	/**
	 *
	 */
	public function upload(){
		if( $this->hasPermission() ){
			 
		}else {
			die( $this->language->get('error_permission') );
		}
	}

	/**
	 * 
	 */
	public function getUnexpectedModules( $layout_id, $tmodules ){
		$this->load->model('setting/themecontrol');
		$extensions = $this->model_setting_themecontrol->getExtensions('module');		
		$module_data = array();
		foreach ($extensions as $extension) {
			if ( file_exists(DIR_APPLICATION . 'controller/module/' . $extension['code'] . '.php')) {	
				$modules = $this->config->get($extension['code'] . '_module');
				$this->language->load('module/'.$extension['code']);	
				if ($modules) {
					foreach ($modules as $index => $module) {  
						if( ($module['layout_id'] == $layout_id || $module['layout_id'] == 99999) && $module['status'] && !isset($tmodules[$extension['code']]) ){
							$module_data[] = array(
								'title'      => ($this->language->get('heading_title')),
								'code'       => $extension['code'],
								'setting'    => $module,
								'sort_order' => $module['sort_order'],
								'status'     => $module['status'],
								'index'      => $index
							);				
						}
					}
				}
			}
			$this->language->load('module/'.$this->moduleName);	
		}
		return $module_data;
	}
	
	
	
	 
	/**
	 * 
	 */
	public function tabModules() {
		$this->data['elayout_default'] = 1;
		if( isset($this->request->get['elayout_id']) ){
			$this->data['elayout_default'] = $this->request->get['elayout_id'];	
		}
		$this->data['layout_modules'] = $this->getModules( $this->data['elayout_default'] );
	}
	
	/**
	 * 
	 */
	public function getModules( $layout_id ){
		
		$this->load->model('setting/themecontrol');
		$extensions = $this->model_setting_themecontrol->getExtensions('module');		
		$module_data = array();
		foreach ($extensions as $extension) {
			if ( file_exists(DIR_APPLICATION . 'controller/module/' . $extension['code'] . '.php')) {	

				$modules = $this->config->get($extension['code'] . '_module');
				$this->language->load('module/'.$extension['code']);	
				if ($modules) {
					foreach ($modules as $index => $module) {  
						if( $module['layout_id'] == $layout_id || $module['layout_id'] == 99999){
							$module_data[$module['position']][] = array(
								'title'      => ($this->language->get('heading_title')). '',
								'code'       => $extension['code'],
								'setting'    => $module,
								'sort_order' => $module['sort_order'],
								'status'     => $module['status'],
								'index'      => $index
							);				
						}
					}
				}
			}
			$this->language->load('module/'.$this->moduleName);	
		}
		foreach( $module_data as $position => $modules ){
			$sort_order = array(); 
			foreach ($modules as $key => $value) {
			
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $module_data[$position]);
		}
	//	 echo '<pre>'.print_r( $module_data, 1 ); die;
		return $module_data;
		
		//
	}
	
	/**
	 *
	 */
	public function getLang( $key ){
		return $this->language->get( $key ); 
	}
	
	/**
	 *
	 */
	public function getConfig( $config ){
		return ''.$config;
	}
	
	/**
	 *
	 */	
	public function hasPermission(){
		return $this->user->hasPermission('modify', 'module/'.$this->moduleName);
	}

	/**
	 * Validation
	 */
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}	
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	/**
	 * 
	 */
	public function installsample(){

		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}	
		
		if( is_dir(DIR_APPLICATION.'model/sample/') ){
			$this->load->model('sample/module');
			if( isset($this->request->get['type']) && $this->request->get['type']== 'query' ){
				$this->model_sample_module->installSampleQuery( $this->request->get['theme'] , $this->request->get['module'] );
			}else {
				$this->model_sample_module->installSample( $this->request->get['theme'] , $this->request->get['module'] );
			}
		}
		die( "done" );
	}

	/**
	 * 
	 */
	public function restore(){

		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}	
		
		if( is_dir(DIR_APPLICATION.'model/sample/') ){
			$this->load->model('sample/module');
			if( isset($this->request->get['type']) && $this->request->get['type']== 'query' ){
				//$this->model_sample_module->installSampleQuery( $this->request->get['theme'] , $this->request->get['module'] );
			}else {
				$this->model_sample_module->restoreDataModule( $this->request->get['theme'] , $this->request->get['module'] );
			}
		}
		die( "done" );
	}
	 
	/**
	 * 
	 */
	public function storesample(){
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}	

		if( is_dir(DIR_APPLICATION.'model/sample/') ){
			$this->load->model('sample/module');
			$this->model_sample_module->installStoreSample( $this->request->get['theme']  );
		}	
	}
	
	/**
	 *
	 */	
	public function clearcache(){
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}

		define( "PAV_CSS_CACHE", DIR_CACHE."pavo-asset/" );
		if( is_dir(PAV_CSS_CACHE) ) {
			$files = glob( PAV_CSS_CACHE . '*.css' );
			if ($files) {
				foreach ($files as $file) {
					if ( is_file($file) ) {
						@unlink($file);
					}
				}
			}
		}
		die('done');	
	}

	 
	/**
	 * Ajax Save Content
	 */
	public function ajaxsave(){

		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}	

		$this->load->model('setting/setting');
		if( isset($this->request->post['modules']) ){
			$modules = $this->request->post['modules'];
			
			foreach( $modules  as $position => $mods ){	
				 echo $position."<br>";
				foreach( $mods as $index => $module ){
					$tmp = explode("-",$module);
					if( count($tmp)== 2 ){
						$code = $tmp[0];
						$modindex = $tmp[1];
						$data = array();
						$dbmods = $this->config->get( $code  . '_module');
						if( is_array($dbmods ) ) {
						
							foreach( $dbmods as $dbidx => $dbmod ){
								
								if( $dbidx == $modindex ){
									$dbmod['position'] = $position;
									$dbmod['sort_order'] = $index+1;
									$dbmods[$dbidx] = $dbmod ;
									break;
								}
							}
							$data = $this->model_setting_setting->getSetting( $code );
							if(  is_array($data) ){
								$data[$code."_module"] = $dbmods;			
							//	echo '<pre>'.print_r( $data, 1 );
								$this->model_setting_setting->editSetting( $code, $data );	 
							}
						}
					}
				}
			}
		}
		die();
	}
}