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
		    	<form class="form-search">
		    		<input type="text" class="input-xxlarge search-query" placeholder="Buscar Filmes, S&eacute;ries...">
		    		<button type="submit" class="btn"><i class="icon-search"></i></button>
		    	</form>		    
	    	</div>
	    </div>
	    <hr>
	    
	    <!-- Corpo do site  -->
	    <div class="row">
	    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
	    	<div class="span2 muted">
	    		<ul class="nav nav-list">
	    			<li class="nav-header">Op&ccedil;&otilde;es</li>
	    			<li class="active"><a href="#">Adicionar Filme</a></li>
	    			<li><a href="#">Meus Filmes</a></li>
	    			<li><a href="#">Meus Perfil</a></li>
	    			<li><a href="#">Sair</a></li>
	    		</ul>
	    	</div>
	    	<div class="span10" style="background-color: gray">
	    		<h4>Coluna Direita</h4>
	    		<img src="" class="img-rounded">	
	    	</div>
	    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">