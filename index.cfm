<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<cfparam name="form.txtSearch" default=""/>

<div class="row">
			<cfif NOT isDefined('form.submitSearch')>
		    	<div class="span8 offset2">
				    <!--=================  CAROUSEL  ==================== -->
					<div id="myCarousel" class="carousel slide">
						<div class="carousel-inner">
							<div class="item active">
								<img src="assets/img/GoT_Lannister.jpg" />
							</div>
							<div class="item">
								<img src="assets/img/GoT_Targaryen.jpg" />
							</div>
							<div class="item">
								<img src="assets/img/GoT_Stark.jpg" />
							</div>
							<div class="item">
								<img src="assets/img/GoT_Baratheon.jpg" />
							</div>
						</div><!---fim do carousel-inner--->
						<a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
						<a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
						<div class="carousel-caption">
							<h4>Game of Thrones</h4>
							<p>Série Game of Thrones começa sua 3 temporada.</p>
						</div>
					</div>
					<!-- FIM CAROUSEL -->
	    		</div>
			</cfif>
	    </div>
	    
	    <hr>
	    <!-- Campo de busca  -->
	    <div class="row" align="center">
	    	<div class="span12">    		
		    	<cfform class="form-search">
					<cfset i = 0>
					<cfset filmeData = ''>
					<cfset filmes = entityLoad('Filme')>
					<cfloop condition="i LT ArrayLen(filmes)">                                
                       	<cfset i = i + 1>                                
                        <cfset filmeData = filmeData & ",&quot;" & #filmes[i].getTitulo()# & "&quot;">                                
                    </cfloop>
		    		<cfinput name="txtSearch" type="text" class="input-xxlarge search-query" placeholder="Buscar Filmes, S&eacute;ries..." datasource="[#filmeData#]">
		    		<button name="submitSearch" type="submit" class="btn"><i class="icon-search"></i></button>
		    	</cfform>		    
	    	</div>
	    </div>
	    <hr>
	    
	    <!-- Corpo do site  -->
	    <div class="row">
	    	
			<!--- Verifica se o usuário esta logado e oculta a barra de opcoes caso o usuário não esteja logado --->
	    	<cfinclude template="CheckMenuBar.cfm">
	    		
	    		<!--- Exibe os resultados de busca somente quando é passado algum conteudo pelo campo de busca --->
	    		<cfif isDefined("form.submitSearch") AND form.txtSearch NEQ "">
		    		<cfoutput><div class="#spanNum#"></cfoutput>
		    		
					<h4>Você procurou por "<cfoutput>#form.txtSearch#</cfoutput>"</h4>
		    		<ul class="thumbnails">
						 
						<cfset resultSearch = ORMSearch('#form.txtSearch#*', "Filme", [ "Titulo", "Sinopse", "Ano"])>
						

						<cfif len('resultSearch.data') EQ 0>
							<p class="offset1">Nenhum resultado encontrado.</p>
						</cfif>
						<!---<cfdump var="#ultimosFilmes#">--->
		    			<cfloop index="filmeRes" array="#resultSearch.data#">
							<cfset filme = filmeRes.entity>
							
							<cfset imgCapa = entityLoad('Imagem', {Id_Filme=filme}, true) />	

							  	<li class="span3">
							    	<div class="thumbnail">
							    		<cfoutput>
							      			<a class="thumbnail" href="InfoFilme.cfm?Id=#filme.getId_Filme()#">
												<cfif isDefined("imgCapa")>
								      				<cfset imgPath = #imgCapa.getImagem_Path()#>
															  
								      				<!--- Carrega a imagem --->
													<cfif isDefined('imgPath') || NOT isNull(imgPath) >
														<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
													<cfelse>
														<img data-src="holder.js/260x160">
													</cfif>
												<cfelse>
													<img data-src="holder.js/260x160">
												</cfif>
							      			</a>
								  			<h5>#filme.getTitulo()#</h5>
			      							<p>#Mid(filme.getSinopse(), 1, 50)#...</p>
										</cfoutput>
							    	</div>
							  	</li>	
						 </cfloop>
					 </ul>
		    		</div>
				</cfif>
	    		
	    		<cfoutput><div class="#spanNum#"></cfoutput>
	    		<hr>
				<h4>Ultimos Filmes</h4>
	    		<ul class="thumbnails">
					<!--- Carrega os ultimos filmes adicionados --->
					<cfset ultimosFilmes = EntityLoad('Filme', {}, "Data_Adicao Desc") > 
					<!---<cfdump var="#ultimosFilmes#">--->
	    			<cfloop index="filme" array="#ultimosFilmes#">
						<cfset imgCapa = entityLoad('Imagem', {Id_Filme=filme}, true) />
					  	<li class="span3">
					    	<div class="thumbnail">
					    		<cfoutput>
					      			<a class="thumbnail" href="InfoFilme.cfm?Id=#filme.getId_Filme()#">
					      			<cftry>
					      					<cfset imgPath = #imgCapa.getImagem_Path()#>
												  
						      				<!--- Carrega a imagem --->
											<cfif isDefined('imgPath') || isNull(imgPath) >
												<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
											<cfelse>
												<img data-src="holder.js/260x160">
											</cfif>
										<cfcatch>
											<!--- Exibe um thumbnail padrao caso não exista imagem --->
											<img data-src="holder.js/260x160">
										</cfcatch>
									</cftry>
									</a>
						  			<h5>#filme.getTitulo()#</h5>
	      							<p>#LJustify(Mid(filme.getSinopse(), 1, 100), 100)#...</p>
								</cfoutput>
					    	</div>
					  	</li>	
					 </cfloop>
				 </ul>
	    	</div>
	    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">