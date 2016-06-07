<?php if( count($testimonials) ) { ?>
<?php $id = rand(1,10)+rand();?>

<div class="box">
    <div class="box-heading">
        <span>My Testimonial</span>
    </div>
    <div class="box-content">
        <div id="pavtestimonial<?php echo $id;?>" class="carousel slide pavtestimonial">
            <div class="container inner">
                <div class="carousel-inner testimonial-content">
                    <?php foreach ($testimonials as $i => $testimonial) {  ?>
                    <div class="item <?php if($i==0) {?>active<?php } ?>">
                        <div class="testimonial-item clearfix">
                                <div class="t-avatar">
                                    <img  alt="<?php echo strip_tags($testimonial['profile']); ?>" src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/>
                                </div>
                                <div class="testimonial-meta">
                                    <?php if(  $testimonial['description'] ) { ?>
                                    <div class="description">
                                        <div><?php echo $testimonial['description']; ?></div>
                                    </div>
                                    <?php } ?>

                                    <?php if(  $testimonial['profile'] ) { ?>
                                    <div class="profile">
                                        <div><?php echo $testimonial['profile']; ?></div>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if( $testimonial['video_link']) { ?>
                            <a class="colorbox-t" href="<?php echo $testimonial['video_link'];?>"><?php echo $this->language->get('text_watch_video_testimonial');?></a>
                            <?php } ?>
                        </div>
                    </div>
                    <?php } ?>
                </div>
                <?php if( count($testimonials) > 1 ){ ?>
                <ol class="carousel-indicators">
                    <?php for($t=0; $t<count($testimonials); $t++) { ?>
                    <li id="carousel-selector-<?php echo $t; ?>" class="bullet <?php echo($t==0?'active':''); ?>" data-target="#pavtestimonial<?php echo $id;?>" data-slide-to="<?php echo $t; ?>">&nbsp;</li>
                    <?php } ?>
                </ol>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<?php if( count($testimonials) > 1 ){ ?>
<script type="text/javascript">
    <!--
    $('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});

    // handles the carousel thumbnails
    $('[id^=carousel-selector-]').click( function(){
        var id_selector = $(this).attr("id");
        var id = id_selector.substr(id_selector.length -1);
        id = parseInt(id);
        $('#myCarousel').carousel(id);
        $('[id^=carousel-selector-]').removeClass('active');
        $(this).addClass('active');
    });

    $('#pavtestimonial<?php echo $id;?>').bind('slid', function () {
        var id = $('#pavtestimonial<?php echo $id;?> .item.active').index();

        $('[id^=carousel-selector-]').removeClass('active');
        $('[id^=carousel-selector-'+id+']').addClass('active');
    });

    var width = 0;
    $('#pavtestimonial<?php echo $id;?> .bullets .bullet').each(function() {
        width += $(this).outerWidth(true);
    });
    $('#pavtestimonial<?php echo $id;?> .bullets').width(width);
    -->
</script>
<?php } ?>
<script type="text/javascript"><!--
    $(document).ready(function() {
        $('.colorbox-t').colorbox({iframe:true, innerWidth:640, innerHeight:390});
    });
    //--></script>
<?php } ?>
