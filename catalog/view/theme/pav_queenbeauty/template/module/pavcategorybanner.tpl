<?php 
	$cols = 4;
	$itemsperpage = 8;
	$span = 12/$cols; 
	$id = rand(1,9)+rand();	
?>
<div class="box box-categories-banner hidden-xs">
	<div class="box-heading">
		<span><?php echo $this->language->get("heading_title");?></span>
	</div>
	<div class="box-items slide" id="box-banner-<?php echo $id;?>">
		<?php if( count($categories) > $itemsperpage ) { ?>
		<div class="carousel-controls">
			<a class="carousel-control left" href="#box-banner-<?php echo$id;?>"   data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#box-banner-<?php echo $id;?>"  data-slide="next">&rsaquo;</a>
		</div>
		<?php } ?>
		<div class="carousel-inner ">

			<?php $pages = array_chunk( $categories, $itemsperpage);?>
			<?php foreach ($pages as  $k => $tcategories ) { ?>

			<div class="item <?php if($k==0) { ?>active<?php } ?>">
				<?php foreach( $tcategories as $i => $category ) {  $i=$i+1;?>
				<?php if( $i%$cols == 1 && $cols > 1) { ?>
				<div class="row">
				<?php } ?>
					<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 col-banner">
						<div class="banner-wrapper effect">
						<?php
							$count = $category['parent']['count']; 
							if($count == 0 || $count == 1){
								$label = $count.' '.$this->language->get("text_item");
							} else {
								$label = $count.' '.$this->language->get("text_items");
							}
						?>
                            <div class="banner-meta">
                                <div class="banner-inner">
                                    <a  class="title" href="<?php echo $category['parent']['href']; ?>"><?php echo $category['parent']['name']; ?></a>
                                    <p class="content"><?php echo $label;?></p>
                                </div>
                            </div>
                            <div class="banner-image">
                                <?php if (!empty($category['parent']['image'])){ ?>
                                    <a href="<?php echo $category['parent']['href']; ?>">
                                        <img src="<?php echo $category['parent']['image']; ?>" alt="<?php echo $label;?>"/>
                                    </a>
                                <?php } ?>
                            </div>

							
						</div>
					</div>
				<?php if( $i%$cols == 0 || $i==count($tcategories) ) { ?>
				</div>
				<?php } ?>
				<?php } //end foreach?>
			</div>
			<?php } //end foreach?>
		</div>
	</div>

    <!-- Created heading-title style:Bold -->
    <script type="text/javascript">
        $(document).ready(function() {
            $('.banner-inner .title').each(function(){
                var string = $(this).html().trim();
                var check = /\s/.test(string);
                if(check == true){
                    string = string.replace(/(\S+?)$/, '<b>$1</b>');
                }else{
                    string = "<b>"+string +"</b>";
                }
                $(this).html(string);
            });
        });
    </script>
</div>