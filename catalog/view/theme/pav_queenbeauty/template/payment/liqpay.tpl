<form action="<?php echo $action; ?>" method="post" role="form">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="buttons clearfix">
    <div class="right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="button btn btn-default" />
    </div>
  </div>
</form>
