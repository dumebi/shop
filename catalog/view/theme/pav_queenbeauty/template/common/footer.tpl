<?php 
	/******************************************************
	 * @package Pav Megamenu module for Opencart 1.5.x
	 * @version 1.1
	 * @author http://www.pavothemes.com
	 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
	 * @license		GNU General Public License version 2
	*******************************************************/

	require_once(DIR_SYSTEM . 'pavothemes/loader.php');
	$helper = ThemeControlHelper::getInstance( $this->registry, $this->config->get('config_template') );
?>
</section>
<?php
/**
 * promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$blockid = 'promotion';
$blockcls = '';
$modules = $helper->getModulesByPosition( $blockid ); 
$ospans = array(1=>12);?>
<?php
if( count($modules) ){
$cols = isset($config['block_'.$blockid])&& $config['block_'.$blockid]?(int)$config['block_'.$blockid]:count($modules);
$class = $helper->calculateSpans( $ospans, $cols );
if( !isset($tmcols) ){
$tmcols = 'col-sm-12 col-xs-12';
}
?>
<section class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
    <div class="container-full"><div class="inner">
            <?php $j=1;foreach ($modules as $i =>  $module) {  ?>
            <?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>
                <div class="<?php echo $class[$j] . ' '.$tmcols;?>"><?php echo $module; ?></div>
                <?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
            <?php  $j++;  } ?>
        </div></div>
</section>
<?php } ?>


<?php
/**
 * mass top modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$blockid = 'mass_top';
$blockcls = '';
$modules = $helper->getModulesByPosition( $blockid ); 
$ospans = array(1=>12);
$tmcols = 'col-sm-12 col-xs-12';
require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>
<?php
/**
 * mass center modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
*/
$blockid = 'mass_center';
$blockcls = '';
$modules = $helper->getModulesByPosition( $blockid );
$ospans = array(1=>12);
$tmcols = 'col-sm-12 col-xs-12';
require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>
<?php
/**
 * promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$blockid = 'mass_bottom';
$blockcls = '';
$modules = $helper->getModulesByPosition( $blockid ); 
$ospans = array();
$tmcols = 'col-sm-12 col-xs-12';
require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>

<footer id="footer">
	<?php
	/**
	 * promotion modules
	 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
	 */
	$blockid = 'footer_top';
	$blockcls = '';
	$modules = $helper->getModulesByPosition( $blockid ); 
	$ospans = array(1=>12);
	$tmcols = 'col-sm-12 col-xs-12';
	require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );

	?>
	<?php
	/**
	 * Footer Center Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
	 */
	$blockid = 'footer_center';
	$blockcls = '';
	$modules = $helper->getModulesByPosition( $blockid ); 
	$ospans = array(1=>3,2=>3,3=>3,4=>3);
	$tmcols = 'col-sm-6 col-xs-12';
	if( count($modules) ){
		require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );

	} elseif( $helper->getConfig('enable_footer_center') ) { ?>
	
	<div class="footer-center">
		<div class="container">
			<div class="row">			
					
			<?php if ($informations) { ?>
			<div class="column col-xs-12 col-sm-6 col-lg-3 col-md-3">
				<div class="box info">
					<div class="box-heading"><span><?php echo $text_information; ?></span></div>
					<div class="box-content">
						<ul class="list">
						  <?php foreach ($informations as $information) { ?>
						  <li><a href="<?php echo $information['href']; ?>"><i class="fa fa-stop"></i><?php echo $information['title']; ?></a></li>
						  <?php } ?>
						</ul>
					</div>					
				</div>
			</div>
			<?php } ?>				
		  
			<div class="column col-xs-12 col-sm-6 col-lg-3 col-md-3">
				<div class="box extra">
					<div class="box-heading"><span><?php echo $text_extra; ?></span></div>
					<div class="box-content">
						<ul class="list">							
							<li><a href="<?php echo $manufacturer; ?>"><i class="fa fa-stop"></i><?php echo $text_manufacturer; ?></a></li>
							<li><a href="<?php echo $voucher; ?>"><i class="fa fa-stop"></i><?php echo $text_voucher; ?></a></li>
							<li><a href="<?php echo $affiliate; ?>"><i class="fa fa-stop"></i><?php echo $text_affiliate; ?></a></li>
							<li><a href="<?php echo $special; ?>"><i class="fa fa-stop"></i><?php echo $text_special; ?></a></li>
						</ul>
					</div>			
				</div>
			</div>

			<div class="column col-xs-12 col-sm-6 col-lg-3 col-md-3">
				<div class="box">
					<div class="box-heading"><span><?php echo $text_account; ?></span></div>
					<div class="box-content">
						<ul class="list">						  
							<li><a href="<?php echo $account; ?>"><i class="fa fa-stop"></i><?php echo $text_account; ?></a></li>
							<li><a href="<?php echo $order; ?>"><i class="fa fa-stop"></i><?php echo $text_order; ?></a></li>
							<li><a href="<?php echo $wishlist; ?>"><i class="fa fa-stop"></i><?php echo $text_wishlist; ?></a></li>
							<li><a href="<?php echo $newsletter; ?>"><i class="fa fa-stop"></i><?php echo $text_newsletter; ?></a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="column col-xs-12 col-sm-6 col-lg-3 col-md-3">
				<div class="box customer-service">
					<div class="box-heading"><span><?php echo $text_service; ?></span></div>
					<div class="box-content">
						<ul class="list">						  
							<li><a href="<?php echo $contact; ?>"><i class="fa fa-stop"></i><?php echo $text_contact; ?></a></li>
							<li><a href="<?php echo $return; ?>"><i class="fa fa-stop"></i><?php echo $text_return; ?></a></li>
							<li><a href="<?php echo $sitemap; ?>"><i class="fa fa-stop"></i><?php echo $text_sitemap; ?></a></li>
						</ul>
					</div>	
				</div>
			</div>
		 </div> 
	</div></div>
<?php  } ?>	

<?php
/**
 * Footer Bottom
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$blockid = 'footer_bottom';
$blockcls = '';
$modules = $helper->getModulesByPosition( $blockid ); 
$ospans = array();
require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>	

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<div id="powered">
	<div class="container">
		<div class="inner">
			<div id="top"><a class="scrollup" href="#"><i class="fa fa-angle-up"></i>Top</a></div>
			<div class="copyright pull-left">
			<?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>
				<?php echo $helper->getConfig('copyright'); ?>
			<?php } else { ?>
				<?php echo $powered; ?>. 
			<?php } ?>
			Designed by <a href="http://www.pavothemes.com" title="PavoThemes - Opencart Themes Clubs" target="_blank">PavoThemes</a>
			</div>	
			<?php if( $content=$helper->getLangConfig('widget_paypal') ) {?>
				<div class="paypal pull-right">
					<?php echo $content; ?>
			</div>
			 <?php } ?>
		</div>
	</div>
</div>
</footer>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<?php if( $helper->getConfig('enable_paneltool',0) ){  ?>
	<?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>
</section> 
</body></html>