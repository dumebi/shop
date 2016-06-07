<div class="category box ">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content tree-menu">
		<ul id="accordion" class="box-category box-panel">
			<?php 
				$k=0;
				foreach ($categories as $category) {				
				$class = "";
					if(isset($category["children"]) && !empty($category["children"])){
					$class = "haschild";
				}
				$name = str_replace("", '<span class="">',  $category['name'] );
				$category['name'] = str_replace("", '</span>', $name); 
			?>
			
			<li class="<?php echo $class; ?>">
				<?php if ($category['category_id'] == $category_id) { ?>
				<a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
				<?php } else { ?>
				<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
				<?php } ?>
				<?php if ($category['children']) { $k++; ?>								
				<span class="head">
                    <a data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne<?php echo $k ;?>">
                        <i class="fa fa-plus"></i>
                    </a>
                </span>
                <ul id="collapseOne<?php echo $k ;?>" class="panel-collapse collapse list-category">
                    <?php foreach ($category['children'] as $child) { ?>
                    <?php
						$child['name'] = str_replace("", '<span class="">',  $child['name'] );
                    $child['name'] = str_replace("", '</span>', $child['name']);
                    ?>
                    <li>
                        <?php if ($child['category_id'] == $child_id) { ?>
                        <a href="<?php echo $child['href']; ?>" class="active"> <?php echo $child['name']; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $child['href']; ?>"> <?php echo $child['name']; ?></a>
                        <?php } ?>
                    </li>
                    <?php } ?>
                </ul>
				<?php } ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $('#collapseOne<?php echo $k ;?>').on('show.bs.collapse', function () {
                            $('a[data-target="#collapseOne<?php echo $k ;?>"] i').removeClass("fa-plus").addClass("fa-minus");
                        });
                        $('#collapseOne<?php echo $k ;?>').on('hide.bs.collapse', function () {
                            $('a[data-target="#collapseOne<?php echo $k ;?>"] i').removeClass("fa-minus").addClass("fa-plus");
                        });
                    });
                </script>

			</li>
			<?php } ?>
		</ul>
	</div>
</div>
