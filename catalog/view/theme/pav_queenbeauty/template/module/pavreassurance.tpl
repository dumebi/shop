<?php 

if (!empty($pavreassurances)) { ?>
		<div class="box box-module-pavreassurances <?php echo $prefix_class ?> line">
            <div class="box-content">
				<div class="row box-outer">
						<?php foreach ($pavreassurances as $reassurance) { ?>
							<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 column">
								<div class="reassurances-left clearfix">
									<span class="icon-name pull-left fa <?php echo $reassurance['select_icon'] ?>"></span>
									<div class="description media-body">
										<h4><?php echo $reassurance['title']; ?></h4>										
										<?php echo htmlspecialchars_decode($reassurance['caption']); ?>	
										<a href="javascript:void(0);" class="pavreassurances arrow "></a>
										<div class="mask" style="display:none;">
											<?php echo htmlspecialchars_decode($reassurance['detail']); ?>
										</div>
									</div>													
								</div>
							</div>
						<?php } ?>
				</div>
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
