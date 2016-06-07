<?php
class ControllerModulepavcategorybanner extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('catalog/product'); 
		$this->load->model('catalog/category'); 
		$this->load->model('tool/image');
		$this->language->load('module/pavcategorybanner');

		// if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavcategorybanner.css')) {
		// 	$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavcategorybanner.css');
		// } else {
		// 	$this->document->addStyle('catalog/view/theme/default/stylesheet/pavcategorybanner.css');
		// }
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
  		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');

		$language = $this->config->get('config_language_id');

		$default = array(
			'width' => 202,
			'height' => 168,
			'category_tabs' => array(),
			'image' => array(),
			'itemsperpage' => 6,
			'cols' => 3,
			'limit' => 12,
		);

		$data  = array_merge($default, $setting);

		$this->data['itemsperpage'] = $data['itemsperpage'];
		$this->data['cols'] = $data['cols'];
		$this->data['limit'] = $data['limit'];

		//List image categories
		$catimgs = $data['image'];

		if(empty($data['category_tabs'])){
			return ;
		}
		
		foreach ($data['category_tabs'] as $key=>$category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if($catimgs[$key]){
				$image = $this->model_tool_image->resize($catimgs[$key], $data['width'], $data['height']);
			} else {
				$image = false;
			}

			$datap = array(
				'filter_category_id'  => $category_info['category_id'],
				'filter_sub_category' => true
			);

			$product_total = $this->model_catalog_product->getTotalProducts($datap);

			if ($category_info) {
				$categories[$category_id]['parent'] = array(
					'image' => $image,
					'href' => $this->url->link('product/category', 'path=' . $category_info['category_id'])	,
					'name' =>(isset($category_info['path']) ? $category_info['path'] . ' &gt; ' : '') . $category_info['name'],
					'count' => $product_total,
				);
			}
			//$categories[$category_id]['haschild'] = $this->rendercategory($category_id);
		}

		$this->data['categories']   = $categories;

		$this->data['module'] = $module++;					
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavcategorybanner.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavcategorybanner.tpl';
		} else {
			$this->template = 'default/template/module/pavcategorybanner.tpl';
		}
		
		$this->render();
	}

	public function rendercategory($category_id) {
		$this->load->model('catalog/category');
		$categories = $this->model_catalog_category->getCategories($category_id);

		$result = array();

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {
				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);

				$product_total = $this->model_catalog_product->getTotalProducts($data);

				$total += $product_total;

				$children_data[] = array(
					'category_id' => $child['category_id'],
					'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
				);		
			}

			$result[] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $total . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);	
		}

		return $result;
	}
}
?>