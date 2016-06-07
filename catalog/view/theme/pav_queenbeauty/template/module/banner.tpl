<div id="banner<?php echo $module; ?>" class="box pav-banner hidden-xs hidden-sm">
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <div class="effect"><a href="#" class="overlay">&nbsp;</a><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" class="img-responsive" /></div>
  <?php } else { ?>
  <div><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" class="img-responsive" /></div>
  <?php } ?>
  <?php } ?>
</div>
<script type="text/javascript"><!--
  $(document).ready(function() {
     $('#banner<?php echo $module; ?> div:first-child').css('display', 'block');
 });

  var banner = function() {
     $('#banner<?php echo $module; ?>').cycle({
        before: function(current, next) {
           $(next).parent().height($(next).outerHeight());
       }
   });
 }

 setTimeout(banner, 2000);
 //--></script>