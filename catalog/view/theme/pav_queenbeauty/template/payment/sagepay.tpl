<form action="<?php echo $action; ?>" method="post" role="form">
  <input type="hidden" name="VPSProtocol" value="2.23" />
  <input type="hidden" name="TxType" value="<?php echo $transaction; ?>" />
  <input type="hidden" name="Vendor" value="<?php echo $vendor; ?>" />
  <input type="hidden" name="Crypt" value="<?php echo $crypt; ?>" />
  <div class="buttons clearfix">
    <div class="right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="button btn btn-default" />
    </div>
  </div>
</form>
