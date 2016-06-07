<div class="box">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content" id="pav-categorymenu">
		<div class="pav-category tree-menu">
			<?php echo $tree;?>
		</div>
	</div>
 </div>
<script>
$(document).ready(function(){
// applying the settings
    $("#pav-categorymenu li .head").empty().html('<i class="fa fa-plus"></i>');
    $("#pav-categorymenu li.active span.head").addClass("selected");
    $('#pav-categorymenu ul').Accordion({
        active: 'span.selected',
        header: 'span.head',
        alwaysOpen: false,
        animated: true,
        showSpeed: 400,
        hideSpeed: 800,
        event: 'click'
    });
    $( ".pav-category .head" ).click(function(){
        $( ".pav-category .fa-plus" ).switchClass( "fa-plus", "fa-minus");
        $( ".pav-category .fa-minus" ).switchClass( "fa-minus", "fa-plus");
    });
});

</script>