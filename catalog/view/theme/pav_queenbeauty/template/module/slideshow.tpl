<div class="slideshow">
  <div class="row">
      <div class="col-lg-12 col-md-12">
          <div id="slideshow<?php echo $module; ?>" class="nivoSlider" style="width: <?php echo $width; ?>px; height: <?php echo $height; ?>px;">
              <?php foreach ($banners as $banner) { ?>
              <?php if ($banner['link']) { ?>
              <a href="<?php echo $banner['link']; ?>"><img  class="img-responsive" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
              <?php } else { ?>
              <img class="img-responsive" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
              <?php } ?>
              <?php } ?>
          </div>
      </div>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#slideshow<?php echo $module; ?>').nivoSlider();
});
--></script>