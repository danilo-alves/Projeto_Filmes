<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<div class="row">
	    	<div class="span8 offset2">
	    		<div id="myCarousel" class="carousel slide">
	    			<ol class="carousel-indicators">
	    				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	    				<li data-target="#myCarousel" data-slide-to="1"></li>
	    				<li data-target="#myCarousel" data-slide-to="2"></li>
	    			</ol>
	    			
	    			<!-- Imagens do Slider -->
	    			<div class="carousel-inner">
	    				<div class="active item" align="center">
	    					<img src="assets/img/GoT_Baratheon.jpg"/>
	    					<div class="carousel-caption">
	    						<h4>Game of Thrones</h4>
	    						<p>Série Game of Thrones começa sua 3 temporada.</p>
	    					</div>
	    				</div>
	    				<div class="item" align="center"><img src="assets/img/GoT_Lannister.jpg"/></div>
	    				<div class="item" align="center"><img src="assets/img/GoT_Targaryen.jpg"/></div>
	    			</div>
	    			
	    			<!-- Setas de navegação -->
	    			<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
	    			<a class="carousel-control right" href="#myCarousel" data-slide="prev">&rsaquo;</a>
	    		</div>
	    	</div>
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
		    		<button name="submit" type="submit" class="btn"><i class="icon-search"></i></button>
		    	</cfform>		    
	    	</div>
	    </div>
	    <hr>
		<cfif isDefined('form.submit')>
			<cfset result = ORMSearch('form.txtSearch', 'Filme', [ "Titulo" ])>
			<cfdump var="#result#">
		</cfif>
	    
	    <!-- Corpo do site  -->
	    <div class="row">
	    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
	    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
	    	<div class="span10">
	    		<ul class="thumbnails">
	    			
					<!--- Carrega os ultimos filmes adicionados --->
					<cfset ultimosFilmes = EntityLoad('Filme', {}, "Data_Adicao Asc") > 
					<!---<cfdump var="#ultimosFilmes#">--->
	    			<cfloop index="filme" array="#ultimosFilmes#">
						<cfset imgCapa = entityLoad('Imagem', {Id_Filme=filme}, true) />	
					  	<li class="span3">
					    	<div class="thumbnail">
					    		<cfoutput>
					      			<a class="thumbnail" href="InfoFilme.cfm?Id=#filme.getId_Filme()#">
					      				<cfset imgPath = #imgCapa.getImagem_Path()#>
												  
					      				<!--- Carrega a imagem --->
										<cfif isDefined('imgPath') || isNull(imgPath) >
											<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
										<cfelse>
											<img data-src="holder.js/260x160">
										</cfif>
					      			</a>
						  			<h5>#filme.getTitulo()#</h5>
	      							<p>#Mid(filme.getSinopse(), 1, 15)#...</p>
								</cfoutput>
					    	</div>
					  	</li>	
					 </cfloop>
				 </ul>
	    	</div>
	    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">