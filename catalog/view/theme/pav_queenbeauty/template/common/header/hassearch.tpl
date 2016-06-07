<?php
?>
<?php
/**
* slideshow modules
* $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
*/
$blockid = 'slideshow';
$blockcls = ' hidden-xs ';
$modules = $helper->getModulesByPosition( $blockid );
$ospans = array();// array(1=>3, 2=>9);
if( count($modules) ){
$cols = isset($config['block_'.$blockid])&& $config['block_'.$blockid]?(int)$config['block_'.$blockid]:count($modules);
$class = $helper->calculateSpans( $ospans, $cols );
?>
<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
    <div class="container-full">
        <div class="inner">
            <?php $j=1;foreach ($modules as $i =>  $module) {  ?>
            <?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>
                <div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
                <?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
            <?php  $j++;  } ?>
        </div>
    </div>
</div>
<?php } ?>
</div><!-- End.header-top -->
<header id="header" class="menu-bottom">
    <div id="header-main">
        <div class="container">
            <div class="header-inner">
                <div class="header-content">
                    <div class="logo inner hassearch ">
                        <?php if( $logoType=='logo-theme'){ ?>
                        <div id="logo-theme" class="logo-store">
                            <a href="<?php echo $home; ?>">
                                <span><?php echo $name; ?></span>
                            </a>
                        </div>
                        <?php } elseif ($logo) { ?>
                        <div id="logo" class="logo-store"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
                        <?php } ?>
                    </div>
                    <div id="pav-mainnav" class="mainnav">
                        <?php
                            /**
                            * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
                            */

                            $modules = $helper->getModulesByPosition( 'mainmenu' );
                        if( count($modules) && !empty($modules) ){
                        ?>
                        <?php foreach ($modules as $module) { ?>
                        <?php echo $module; ?>
                        <?php } ?>

                        <?php } elseif ($categories) {  ?>

                        <div class="navbar navbar-inverse">
                            <nav id="mainmenutop" class="pav-megamenu" role="navigation">
                                <div class="navbar-header pull-right">
                                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                                        <span class="sr-only">Toggle navigation</span>
                                        <span class="fa fa-bars"></span>
                                    </button>
                                </div>

                                <div class="collapse navbar-collapse navbar-ex1-collapse">
                                    <ul class="nav navbar-nav">
                                        <li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
                                        <?php foreach ($categories as $category) { ?>

                                        <?php if ($category['children']) { ?>
                                        <li class="parent dropdown deeper ">
                                            <a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
                                                <b class="fa fa-angle-down"></b>
                                                <span class="triangles"></span>
                                            </a>
                                            <?php } else { ?>
                                        <li>
                                            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                            <?php } ?>
                                            <?php if ($category['children']) { ?>
                                            <ul class="dropdown-menu">
                                                <?php for ($i = 0; $i < count($category['children']);) { ?>
                                                <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                                                <?php for (; $i < $j; $i++) { ?>
                                                <?php if (isset($category['children'][$i])) { ?>
                                                <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
                                                <?php } ?>
                                                <?php } ?>
                                                <?php } ?>
                                            </ul>
                                            <?php } ?>
                                        </li>
                                        <?php } ?>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                        <?php } ?>
                    </div>
                    <div class="btn-group box-search inner">
                        <div class="btn-search" data-toggle="dropdown">
                            <span class="fa fa-search"></span>
                        </div>
                        <div class="nav-search dropdown-menu">
                            <div class="input-group-search">
                                <input type="text" name="search" placeholder="<?php echo $text_search; ?>..." value="<?php echo $search; ?>" class="form-control search-control" />
                                <button type="button" class="btn button-search btn-outline-inverse">Search</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>





