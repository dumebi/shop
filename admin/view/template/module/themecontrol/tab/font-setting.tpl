<table class="form">
						
						<tr class="highlight">
							<td><?php echo $this->getLang('entry_enable_customfont');?></td>
							<td>
								<select name="themecontrol[enable_customfont]">
								
								<?php foreach( $yesno as $v=>$op ): ?>
									<option value="<?php echo $v;?>" <?php if( $v==$module['enable_customfont']){ ?> selected="selected" <?php } ?>><?php echo $op;?></option>
								<?php endforeach;?>
								</select>
							</td>
						</tr>
					</table>
						<?php  //  echo '<pre>'.print_r( $module,1 );die;?>
					<table class="form">
						<?php for( $i=1; $i<=3;$i++ ){ ?>	
						<tr  <?php if($i%2==0) { ?> class="highlight" <?php } ?> >
							<td><b><?php echo $fontbase[$i]['label']?></b></td>
							<td>
							
								<div  class="group-change">
									<select name="themecontrol[type_fonts<?php echo $i;?>]" class="type-fonts">

										<?php foreach( $type_fonts as $font ) {   ?>
										<option value="<?php echo $font[0];?>"<?php if( $module['type_fonts'.$i] == $font[0]) { ?> selected="selected"<?php } ?>><?php echo $font[1];?></option>
										<?php } ?>
									</select>
									
									<table class="form">
											<tr class="items-group-change group-standard">
												<td><?php echo $this->language->get('entry_normal_font');?></td>
												<td>
													<select name="themecontrol[normal_fonts<?php echo $i;?>]">
														<option value="inherit"><?php echo $this->language->get('text_inherit');?></option>
														<?php foreach( $normal_fonts as $font ) {   ?>
														<option value="<?php echo htmlspecialchars($font[0]);?>"<?php if( $module['normal_fonts'.$i] == htmlspecialchars($font[0])) { ?> selected="selected"<?php } ?>><?php echo $font[1];?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											<tr class="items-group-change group-google">
												<td><?php echo $this->language->get('entry_body_google_url');?>
												
												</td>
												<td>
													<input type="text" name="themecontrol[google_url<?php echo $i;?>]" size="65" value="<?php echo $module['google_url'.$i];?>"/>
													<p><i><?php echo $this->language->get('text_explain_google_url')?></i></p>
												</td>
											</tr>
											<tr class="items-group-change group-google">
												<td>Google Family:</td>
												<td><input type="text" name="themecontrol[google_family<?php echo $i?>]" size="65" value="<?php echo $module['google_family'.$i];?>"/>
												<p><i><?php echo $this->language->get('text_explain_google_family');?></i></p>
												</td>
											</tr>
									</table>
								</div>
								<div>
									<p><?php echo $this->getLang("fontsize");?> 
										<select name="themecontrol[fontsize<?php echo $i;?>]">
											<option value="inherit"><?php echo $this->language->get('text_inherit');?></option>
										<?php foreach ( $fontsizes as $key => $value ): ?>
											<?php  $selected = $value == $module['fontsize'.$i]?'selected="selected"':'';	?>	
											<option value="<?php echo $value;?>" <?php echo $selected; ?>><?php echo  $value; ?></option>
										<?php endforeach; ?>
										</select>
									</p>
								</div>
							</td>
						</tr>
						
						<tr style="display:none">
							<td><?php echo $this->language->get('entry_body_selector');?></td>
							<td>
								<textarea  name="themecontrol[body_selector<?php echo $i?>]" rows="5" cols="50"><?php echo $fontbase[$i]['selector']?></textarea>
								<p><i><?php echo $this->language->get('text_explain_body_selector');?></i></p>
							</td>
						</tr>
					<?php } ?>
					</table>
					<table class="form">
						<?php for( $i=4; $i<=4;$i++ ){ ?>	
						<tr class="highlight">
							<td><b><?php echo $this->language->get('entry_font_setting');?></b></td>
							<td>
								<div  class="group-change">
									<select name="themecontrol[type_fonts<?php echo $i;?>]" class="type-fonts">
										<?php foreach( $type_fonts as $font ) {   ?>
										<option value="<?php echo $font[0];?>"<?php if( $module['type_fonts'.$i] == $font[0]) { ?> selected="selected"<?php } ?>><?php echo $font[1];?></option>
										<?php } ?>
									</select>
									
									<table class="form">
											<tr class="items-group-change group-standard">
												<td><?php echo $this->language->get('entry_normal_font');?></td>
												<td>
													<select name="themecontrol[normal_fonts<?php echo $i;?>]">
														<?php foreach( $normal_fonts as $font ) {   ?>
														<option value="<?php echo htmlspecialchars($font[0]);?>"<?php if( $module['normal_fonts'.$i] == htmlspecialchars($font[0])) { ?> selected="selected"<?php } ?>><?php echo $font[1];?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											<tr class="items-group-change group-google">
												<td><?php echo $this->language->get('entry_body_google_url');?>
												
												</td>
												<td>
													<input type="text" name="themecontrol[google_url<?php echo $i;?>]" size="65" value="<?php echo $module['google_url'.$i];?>"/>
													<p><i><?php echo $this->language->get('text_explain_google_url')?></i></p>
												</td>
											</tr>
											<tr class="items-group-change group-google">
												<td>Google Family:</td>
												<td><input type="text" name="themecontrol[google_family<?php echo $i?>]" size="65" value="<?php echo $module['google_family'.$i];?>"/>
												<p><i><?php echo $this->language->get('text_explain_google_family');?></i></p>
												</td>
											</tr>
									</table>
								</div>
								
							</td>
						</tr>
						
						<tr class="highlight">
							<td><?php echo $this->language->get('entry_body_selector');?></td>
							<td>
								<textarea name="themecontrol[body_selector<?php echo $i?>]" rows="5" cols="50"><?php echo $module['body_selector'.$i];?></textarea>
								<p><i><?php echo $this->language->get('text_explain_body_selector');?></i></p>
							</td>
						</tr>
					<?php } ?>
					</table>