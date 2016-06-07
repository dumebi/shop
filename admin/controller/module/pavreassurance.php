<?php
/******************************************************
 * @package:   Pav Ajax Search module for Opencart 1.5.x
 * @version:   1.0
 * @author:    http://www.pavothemes.com
 * @copyright: Copyright (coffee) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @License :  GNU General Public License version 2
*******************************************************/
class ControllerModulePavreassurance extends Controller {

	private $error = array();

	public function index() {
		$this->language->load('module/pavreassurance');
		$this->load->model('setting/setting');
		$this->load->model('localisation/language');
		$this->load->model('design/layout');

		//$this->document->addStyle('view/stylesheet/pavreassurance/font-awesome.min.css');
		$this->document->addScript('view/javascript/sliderlayer/jquery-cookie.js');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = isset($this->request->post["action"]) ? $this->request->post["action"] : "";
			unset($this->request->post['action']);

			$this->model_setting_setting->editSetting('pavreassurance', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			if($action == "save_stay"){
				$this->redirect($this->url->link('module/pavreassurance', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['tab_module'] = $this->language->get('tab_module');

		// Button
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_stay'] = $this->language->get('button_save_stay');
		$this->data['install_button']   = $this->language->get('install_button');
  		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');

		//Text
		$this->data['tab_module_assign'] = $this->language->get('tab_module_assign');
		$this->data['tab_reassurance_image'] = $this->language->get('tab_reassurance_image');
		$this->data['lang_default_store'] = $this->language->get('lang_default_store');

		$this->data['lang_select_icon'] = $this->language->get('lang_select_icon');
		$this->data['lang_module_title'] = $this->language->get('lang_module_title');
		$this->data['lang_content'] = $this->language->get('lang_content');
		$this->data['lang_detail'] = $this->language->get('lang_detail');

		$this->data['prefix_class'] = $this->language->get('prefix_class');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['lang_description'] = $this->language->get('lang_description');
		

		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_enabled'] = $this->language->get('text_enabled');

		$this->data['positions'] = array( 
		  	'content_top',
		  	'mass_bottom',
		  	'content_bottom',
		  	'footer_top',
		  	'footer_center',
		  	'footer_bottom'
		);

		$themeConfig = $this->config->get( 'themecontrol' );
		if( isset($themeConfig['default_theme']) ){
			$layoutxml = DIR_CATALOG.'view/theme/'.$themeConfig['default_theme'].'/development/layout/default.php';
			if( file_exists($layoutxml) ){
				include( $layoutxml );
		 		$this->data['positions'] = PavoLayoutPositions::getList();
			}
		}	
		
		$this->data['layout_groups'] = array( 	
			array('layout_id' => 1, 'name' => $this->language->get('layout_1')),
			array('layout_id' => 2, 'name' => $this->language->get('layout_2')), 
		);

		$this->data['token'] = $this->session->data['token'];
		
		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;

		$this->data['layouts'] = array();
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('text_all_page') );
		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		//Get data Store
		$this->load->model('setting/store');
		$action = array();
		$action[] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL'),
		);
		$store_default = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
		);
		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);
		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('module/pavreassurance', $url.'&token=' . $this->session->data['token'], 'SSL');
		}

		$this->data['stores'] = $stores;
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		$this->data['store_id'] = $store_id;

		$this->data['action'] = $this->url->link('module/pavreassurance', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

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
			'href'      => $this->url->link('module/pavreassurance', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['modules'] = array();
		if (isset($this->request->post['pavreassurance_module'])) {
			$this->data['modules'] = $this->request->post['pavreassurance_module'];
		}

		if ($this->config->get('pavreassurance_module')) { 
			$this->data['modules'] = $this->config->get('pavreassurance_module');
		}
		
		//echo "<pre>"; print_r($this->config->get('pavreassurance_module'),1); die('aaaaaaaaa');

		$d = array(
			'prefix'    	  => '',
			'layout_id'       => '1',
			'position'        => 'content_top',
			'status'          => '1',
			'sort_order'      => '2',
			'module_layout'   => '1',
			'pavreassurances' => array(),
		);

		if( isset($this->data['modules']) && !empty($this->data['modules']) ){
			$d = array_merge($d,reset($this->data['modules']));			
		}

		if( isset($d['pavreassurances']) && !empty($d['pavreassurances']) ){
			foreach( $d['pavreassurances'] as &$reassurance ){
				$reassurance['select_icon'] = isset($reassurance['select_icon']) ? $reassurance['select_icon'] : "";
				$reassurance['title'] = isset($reassurance['title']) ? $reassurance['title'] : "";
				$reassurance['caption'] = isset($reassurance['caption']) ? $reassurance['caption'] : "";
				$reassurance['detail'] = isset($reassurance['detail']) ? $reassurance['detail'] : "";
			}
		}

		$this->data['module'] = $d;

		//echo '<pre>'.print_r($this->data['module'],1);die;


		$this->template = 'module/pavreassurance.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavreassurance')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
?>