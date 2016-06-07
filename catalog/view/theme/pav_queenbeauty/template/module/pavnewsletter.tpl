<div class="box no-padding">
    <div class="box-heading hidden"><?php echo $this->language->get("entry_newsletter");?></div>
    <div class="box-content border-box no-padding">
        <div class="<?php echo $prefix; ?> pav-newsletter padding-inline" id="newsletter_<?php echo $position.$module;?>">
            <form id="formNewLestter" method="post" action="<?php echo $action; ?>" class="formNewLestter">
                <span class="pull-left"></span>
                <div class="explain"><?php echo html_entity_decode( $description );?></div>
                <div class="clearfix input-group input-newsletter">
                    <div class="clearfix input-group">
                        <div class="input-group">
                            <span class="input-group-addon input-inverse">
                                <i class="fa fa-envelope"></i>
                            </span>
                            <input type="text" class="form-control email input-inverse" <?php if(!isset($customer_email)): ?> onblur="javascript:if(this.value=='')this.value='<?php echo $this->language->get("default_input_text");?>';" onfocus="javascript:if(this.value=='<?php echo $this->language->get("default_input_text");?>')this.value='';"<?php endif; ?> value="<?php echo isset($customer_email)?$customer_email:$this->language->get("default_input_text");?>" size="18" name="email">
                                <span class="input-group-btn">
                                    <button type="submit" name="submitNewsletter" class="btn btn-outline-inverse btn-variant btn-newsletter"><?php echo $this->language->get("button_subscribe");?></button>
                                </span>
                        </div>
                        <input type="hidden" value="1" name="action">
                        <div class="valid"></div>
                    </div>
                </div>
            </form>

        </div>
        <?php if (!empty($social)): ?>
        <?php  echo html_entity_decode( $social );?>
        <?php endif ?>
    </div>
</div>
<script type="text/javascript"><!--
    $( document ).ready(function() {
        $('#formNewLestter').on('submit', function() {
            var sbt =  '<img src=\"catalog/view/theme/default/image/close.png\" alt=\"\" class=\"close\">';
            var email = $('.email').val();
            $(".warning, .success").remove();
            if(!isValidEmailAddress(email)) {
                $('.valid').html("<div class=\"warning\"><?php echo $this->language->get('valid_email'); ?>"+sbt+"</div>");
                $('.email').focus();
                return false;
            }
            var url = "<?php echo $action; ?>";
            $.ajax({
                type: "post",
                url: url,
                data: $("#formNewLestter").serialize(),
                dataType: 'json',
                success: function(json)
                {
                    $(".warning, .success").remove();
                    if (json['error']) {
                        $('.valid').html("<div class=\"warning\">"+json['error']+sbt+"</div>");
                    }
                    if (json['success']) {
                        $('.valid').html("<div class=\"success\">"+json['success']+sbt+"</div>");
                    }
                }
            }); return false;
        }); //end submmit
    }); //end document

    function isValidEmailAddress(emailAddress) {
        var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
        return pattern.test(emailAddress);
    }
    --></script>