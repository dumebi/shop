<?php 

if (!empty($pavreassurances)) { ?>
		<div class="box-module-pavreassurances <?php echo $prefix_class ?>">
				<div class="row box-outer">
						<?php foreach ($pavreassurances as $reassurance) { ?>
							<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 column">
								<div class="reassurances-center">
									<span class="icon-name fa <?php echo $reassurance['select_icon'] ?>"></span>
									<div class="description">										
										<h4><?php echo $reassurance['title']; ?></h4>										
										<?php echo htmlspecialchars_decode($reassurance['caption']); ?>	
										<a href="javascript:void(0);" class="pavreassurances arrow"><i class="fa fa-long-arrow-right"></i></a>
										<div class="mask" style="display:none;">
											<?php echo htmlspecialchars_decode($reassurance['detail']); ?>
										</div>
									</div>													
								</div>
							</div>
						<?php } ?>
				</div>
		</div>
	<?php } ?>

<script type="text/javascript"><!--
$(document).ready(function() {
	$(".pavreassurances").bind("click", function(){
		$('.pavreassurances').colorbox({
			overlayClose: true,
			opacity: 0.5,
		  	width: '40%', 
            height: '55%',
			html:$(this).parent().find(".mask").html(),
		});
		return;
	});
});
//--></script>
