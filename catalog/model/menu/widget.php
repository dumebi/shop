<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 2.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) September 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

class ModelMenuWidget extends Model {

	private $widgets = array();

	/**
	 * get list of supported widget types.
	 */
	public function getTypes(){

		$this->language->load('module/pavmegamenubase');
		return array(
			'html' 				=> $this->language->get( 'text_widget_html' ),
			'product_category'  => $this->language->get( 'text_widget_product_category' ),
			'product_list'	    => $this->language->get( 'text_widget_product_list' ),
			'product'			=> $this->language->get( 'text_widget_product' ),
			'banner'			=> $this->language->get( 'text_widget_banner' ),
			'image'				=> $this->language->get( 'text_widget_image' ),
			'video_code'		=> $this->language->get( 'text_widget_video_code' ),
			'feed'				=> $this->language->get( 'text_widget_feed' ),
			'pavo_blogs'		=> $this->language->get( 'text_pavo_blogs' )
		);
	}

	/**
	 * get list of widget rows.
	 */
	public function getWidgets(){
		$sql = ' SELECT * FROM '.DB_PREFIX.'megamenu_widgets ';
		$query = $this->db->query( $sql );
		$a = $query->rows;

 		return $a;
	}

	public function delete( $id ){
		$sql = ' DELETE FROM '.DB_PREFIX.'megamenu_widgets WHERE id='.(int)$id;
		return $this->db->query( $sql );
	}

	/**
	 * get widget data row by id
	 */
	public function getWidetById( $id ){

		$sql = ' SELECT * FROM '.DB_PREFIX.'megamenu_widgets WHERE id='.(int)$id;
		$query = $this->db->query( $sql );
		$row =  $query->row;

		$output = array(
			'id' => '',
			'name' => '',
			'params' => '',
		);
		if( $row ){
		 	$output = array_merge( $output, $row );
		 	$output['params'] = unserialize( $output['params'] );

		}
		return $output;
	}

	/**********/

	public function renderWidgetProductContent( $args, $setting, $widget_name = "" ){

		$output = '';
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$t = array(
			'product_id' => 0,
			'image_height' => '320',
			'image_width'	 =>  300
		);
		$setting = array_merge( $t, $setting );


			$result = $this->model_catalog_product->getProduct( $setting['product_id'] );

			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}

			$product = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
				'rating'     => $rating,
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);


      		ob_start();
	  		require( DIR_TEMPLATE .  $this->getLayout('product') );
	  		$output = ob_get_contents();
      		ob_end_clean( );


		return $output;
	}

	/**
	 *
	 */
	public function renderWidgetFeedContent(  $args, $setting, $widget_name= "" ){

		$t = array(
			'limit' => 12,
	 		'feed_url' => ''
		);
		$setting = array_merge( $t, $setting );

	 	$output = '';
	 	if( $setting['feed_url'] ) {
			$content = file_get_contents( $setting['feed_url']  );
			$x = new SimpleXmlElement($content);
			$items = $x->channel->item;

			ob_start();
	  		require( DIR_TEMPLATE .  $this->getLayout('feed') );
	  		$output = ob_get_contents();
	  		ob_end_clean( );
		}


		return $output;
	}


	/**
	 *
	 */
	public function renderWidgetBannerContent(  $args, $setting, $widget_name= "" ){

		$this->load->model('design/banner');
		$this->load->model('tool/image');


		$t  = array(
			'group_id'=> '',
			'image_width'   => 80,
			'image_height'	=> 80,
		);
		$setting = array_merge( $t, $setting );


		$results = $this->model_design_banner->getBanner($setting['group_id']);
		$banners = array();
		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$banners[] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height'])
				);
			}
		}

		ob_start();
  		require( DIR_TEMPLATE .  $this->getLayout('banner') );
  		$output = ob_get_contents();
  		ob_end_clean( );

  		return $output;

	}
	/**
	 *
	 */
	public function renderWidgetImageContent(  $args, $setting, $widget_name= "" ){

		$this->load->model('tool/image');

		$t  = array(
			'group_id'=> '',
			'image_width'   => 80,
			'image_height'	=> 80,
		);
		$setting = array_merge( $t, $setting );

		$image = $this->model_tool_image->resize($setting['image_path'], $setting['image_width'], $setting['image_height']);
		ob_start();
  		require( DIR_TEMPLATE .  $this->getLayout('image') );
  		$output = ob_get_contents();
  		ob_end_clean( );

  		return $output;

	}

	/**
	 *
	 */
	public function renderWidgetProduct_categoryContent(  $args, $setting, $widget_name= "" ){
		$this->load->model('catalog/product');
		$t  = array(
			'category_id'=> '',
			'limit'   => '12',
			'image_width'=>'200',
			'image_height' =>'200',
		);
		$setting = array_merge( $t, $setting );
			$data = array(
				'filter_category_id'=> $setting['category_id'],
				'sort'  => 'p.date_added',
				'order' => 'DESC',
				'start' => 0,
				'limit' => $setting['limit']
			);

			$results = $this->model_catalog_product->getProducts( $data );
			$products = $this->buildDataProduct( $results, $setting );

			ob_start();
			require( DIR_TEMPLATE .  $this->getLayout('product_list') );
			$output = ob_get_contents();
			ob_end_clean( );


			return $output;
	}

	/**
	 *
	 */
	public function renderWidgetHtmlContent(  $args, $setting, $widget_name= "" ){

		$t  = array(
			'name'=> '',
			'html'   => '',
		);
		$setting = array_merge( $t, $setting );
		$html = '';
		$languageID = $this->config->get('config_language_id');

		if( is_array($setting['html']) && isset($setting['html'][$languageID]) ){
			$html = $setting['html'][$languageID];
			$html = html_entity_decode($html, ENT_QUOTES, 'UTF-8');
		}


		ob_start();
  		require( DIR_TEMPLATE .  $this->getLayout('html') );
  		$output = ob_get_contents();
  		ob_end_clean( );


  		return $output;
	}

	/**
	 *
	 */
	public function renderWidgetVideo_codeContent(  $args, $setting, $widget_name= "" ){

		$t  = array(
			'name'=> '',
			'video_code'   => '',
		);
		$setting = array_merge( $t, $setting );
		$html =  $setting['video_code'];

 		$html = html_entity_decode($html, ENT_QUOTES, 'UTF-8');

		ob_start();
  		require( DIR_TEMPLATE .  $this->getLayout('html') );
  		$output = ob_get_contents();
  		ob_end_clean( );


  		return $output;
	}

	/**
	 *
	 */
	public function renderWidgetProduct_listContent(  $args, $setting, $widget_name= "" ){
		$t = array(
			'list_type'=> '',
			'limit' => 12,
			'image_width'=>'200',
			'image_height' =>'200',
		);
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$products = array();

		$setting = array_merge( $t, $setting );
		if( $setting['list_type'] == 'bestseller' ){
			$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
		}else if( $setting['list_type'] == 'special' ){
			$data = array(
				'sort'  => 'pd.name',
				'order' => 'ASC',
				'start' => 0,
				'limit' => $setting['limit']
			);

			$results = $this->model_catalog_product->getProductSpecials($data);
		}else {
			$data = array(
				'sort'  => 'p.date_added',
				'order' => 'DESC',
				'start' => 0,
				'limit' => $setting['limit']
			);

			$results = $this->model_catalog_product->getProducts( $data );
		}



  		$products = $this->buildDataProduct( $results, $setting );
		ob_start();
  		require( DIR_TEMPLATE .  $this->getLayout('product_list') );
  		$output = ob_get_contents();
  		ob_end_clean( );


  		return $output;
	}

	/**
	 *
	 */
	private function buildDataProduct( $results, $setting ){

		$this->load->model('tool/image');


		$products = array();

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}

			$products[] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
				'rating'     => $rating,
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}
		return $products;
	}

	/**
	 *
	 */
	protected function getLayout( $layout ){

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavmegamenubase/'.$layout.'.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/pavmegamenubase/'.$layout.'.tpl';
		} else {
			$template = 'default/template/module/pavmegamenubase/'.$layout.'.tpl';
		}
		return $template;
	}

	/**
	 *
	 */
	public function getWidgetContent( $type, $data, $widget_name = ""){
		$this->language->load('module/pavmegamenubase');

		$method = "renderWidget".ucfirst($type).'Content';
	 	$args = array();


		if( method_exists( $this, $method ) ){
			return $this->{$method}( $args, $data, $widget_name );
		}
		return ;
	}

	/**
	 *
	 */
	public function renderContent( $id ){
		$output = '<div class="pavo-widget" id="wid-'.$id.'">';

		if( isset($this->widgets[$id]) ){
			$output .= $this->getWidgetContent( $this->widgets[$id]['type'], unserialize($this->widgets[$id]['params']), $this->widgets[$id]['name'] );
		}
		$output .= '</div>';
		return $output;
	}

	/**
	 *
	 */
	public function loadWidgets(){
		if( empty($this->widgets) ){
			$widgets = $this->getWidgets();
			foreach( $widgets as $widget ){
				$this->widgets[$widget['id']] =$widget;
			}
		}
	}
}
?>
