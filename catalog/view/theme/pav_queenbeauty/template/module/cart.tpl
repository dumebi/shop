<div id="cart" class="clearfix">
	<div class="heading">
		<div class="cart-inner pull-right">
			<h4 class="hidden-sm hidden-xs"><?php echo $heading_title; ?></h4>
			<a><span id="cart-total"><?php echo $text_items; ?></span><i class="fa fa-angle-down"></i></a>
		</div>
		<div class="icon-cart pull-left">
		</div>
	</div>
	
	<div class="content">
		<?php if ($products || $vouchers) { ?>
		<div class="mini-cart-info">
			<table>
				<?php foreach ($products as $product) { ?>
				<tr>
					<td class="image">
						<?php if ($product['thumb']) { ?>
						<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
						<?php } ?>
					</td>
					<td class="name">
						<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
						<div>


							<?php foreach ($product['option'] as $option) { ?>
							- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
							<?php } ?>


							<?php if ($product['recurring']): ?>
							- <small><?php echo $text_payment_profile ?> <?php echo $product['profile']; ?></small><br />
							<?php endif; ?>


						</div>
					</td>
					<td class="quantity">x&nbsp;<?php echo $product['quantity']; ?></td>
					<td class="total"><?php echo $product['total']; ?></td>
					<td class="remove"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $product['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $product['key']; ?>' + ' #cart > *');" /></td>
				</tr>
				<?php } ?>
				<?php foreach ($vouchers as $voucher) { ?>
				<tr>
					<td class="image"></td>
					<td class="name"><?php echo $voucher['description']; ?></td>
					<td class="quantity">x&nbsp;1</td>
					<td class="total"><?php echo $voucher['amount']; ?></td>
					<td class="remove"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $voucher['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $voucher['key']; ?>' + ' #cart > *');" /></td>
				</tr>
				<?php } ?>
			</table>
		</div>
		<div class="mini-cart-total">
			<table>
				<?php foreach ($totals as $i => $total) { ?>
				<tr>
					<td class="left"><b><?php echo $total['title']; ?>:</b></td>
					<td class="right <?php if($i==count($totals)-1){ ?> last <?php } ?>"><?php echo  $total['text']; ?></td>
				</tr>
				<?php } ?>
			</table>
		</div>
		<div class="checkout">
			<a href="<?php echo $cart; ?>" class="btn btn-inverse"><?php echo $text_cart; ?></a>
			<a href="<?php echo $checkout; ?>" class="btn btn-outline"><?php echo $text_checkout; ?></a>
		</div>
		<?php } else { ?>
		<div class="empty"><?php echo $text_empty; ?></div>
		<?php } ?>
	</div>  
</div>