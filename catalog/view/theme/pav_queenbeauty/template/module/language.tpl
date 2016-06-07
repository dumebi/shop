<?php if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div class="box-language">
    <label><?php echo $text_language; ?></label>
    <ul class="langs-wrapper">
    	<?php foreach ($languages as $language) { ?>
    	<li onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $(this).parent().parent().parent().submit();"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>"  />
	       <span class="text-language"><?php echo $language['name']; ?></span>
	    <?php } ?></li>
	</ul>
    <input type="hidden" name="language_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </div>
</form>
<?php } ?>
