<?php 
/******************************************************
 * @package Pav Product Tabs module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
* @license		GNU General Public License version 2
*******************************************************/
$span = 12/$cols;
$active = 'latest';
$id = rand(1,9)+rand();
$themeConfig = (array)$this->config->get('themecontrol');
$listingConfig = array(
'category_pzoom'                     => 1,
'quickview'                          => 0,
'show_swap_image'                    => 0,
'product_layout'		=> 'default',
);
$listingConfig     = array_merge($listingConfig, $themeConfig );
$categoryPzoom 	    = $listingConfig['category_pzoom'];
$quickview          = $listingConfig['quickview'];
$swapimg            = $listingConfig['show_swap_image'];
$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;
$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
if( !is_file($productLayout) ){
$listingConfig['product_layout'] = 'default';
}

$productLayout = DIR_TEMPLATE.$this->config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

?>
<div class="box producttabs">
    <?php if( !empty($module_description) ) { ?>
    <div class="module-desc">
        <?php echo $module_description;?>
    </div>
    <?php } ?>
    <div class="tab-nav box-heading box-inline">
        <ul class="nav nav-pills" id="producttabs<?php echo $id;?>">
            <?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;}  ?>
            <li><a href="#tab-<?php echo $tab.$id;?>" data-toggle="tab"><?php echo $this->language->get('text_'.$tab)?></a></li>
            <?php } ?>
        </ul>
    </div>


    <div class="tab-content box-content">
        <?php foreach( $tabs as $tab => $products ) {
        if( empty($products) ){ continue;}
        ?>
        <div class="tab-pane products-rows  tabcarousel<?php echo $id; ?> slide" id="tab-<?php echo $tab.$id;?>">

            <?php if( count($products) > $itemsperpage ) { ?>
            <div class="carousel-controls">
                <a class="carousel-control left" href="#tab-<?php echo $tab.$id;?>"   data-slide="prev">
                    <i class="fa fa-angle-left"></i>
                </a>
                <a class="carousel-control right" href="#tab-<?php echo $tab.$id;?>"  data-slide="next">
                    <i class="fa fa-angle-right"></i>
                </a>
            </div>
            <?php } ?>
            <div class="carousel-inner products-block">
                <?php
					$pages = array_chunk( $products, $itemsperpage);
				// echo '<pre>'.print_r( $pages, 1 ); die;
                ?>
                <?php foreach ($pages as  $k => $tproducts ) {   ?>
                <div class="item <?php if($k==0) {?>active<?php } ?>">
                    <?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
                    <?php if( $i%$cols == 1 ) { ?>
                    <div class="row products-row">
                        <?php } ?>
                        <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
                            <?php require( $productLayout );  ?>
                        </div>

                        <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
                    </div>
                    <?php } ?>
                    <?php } //endforeach; ?>
                </div>
                <?php } ?>
            </div>
        </div>
        <?php } // endforeach of tabs ?>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        $('#producttabs<?php echo $id;?> a:first').tab('show');
    })
    $('.tabcarousel<?php echo $id;?>').carousel({interval:false,auto:false,pause:'hover'});
</script>
