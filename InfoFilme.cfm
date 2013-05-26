<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">
	
	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
    	
    	<div class="span10">
    		<div class="span2" style="float: left">
    			<img src="assets/img/GoT_Lannister.jpg" class="img-rounded" height="340" width="240"/>
			</div>
			<div class="span6">
    			<h2>Titulo do Filme</h2>
    			<p class="lead">Ano de lançamento: 2012</p>
				
				<div id="star" data-score="1"></div>
				<script>
					$('#star').raty('score', 4);
				</script>
			</div>
			<div class="span10">
				<h3>Sinopse</h3>
				<hr/>
				
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet cursus congue.
				 Quisque porttitor luctus mauris, ac rhoncus libero dignissim vel. Sed eget posuere orci. 
				 Proin elit libero, feugiat sed suscipit sit amet, congue vitae eros. In vulputate scelerisque dui,
				 vitae mollis nisl aliquam sed. Proin consectetur velit non lacus faucibus tempus. Duis rhoncus luctus ipsum,
				 porttitor lobortis risus venenatis id. Vivamus ac tempus augue. Nam at quam et nisi blandit viverra vel 
				 et libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
				 
				<h3>Trailer</h3>
				<hr/>
				
				<!--- Carrega o embeb do banco de dados --->
				<center></center><iframe width="560" height="315" src="http://www.youtube.com/embed/AWemNKXIou4" frameborder="0" allowfullscreen></iframe></center>
			</div>
			<!--- Carrega as avaliacoes feitas pelos usuarios --->
			<div class="span10">
				<h3>Avaliação</h3>
				<hr/>
				<div class="hero-unit">
					<p class="lead">Usuario</p>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet cursus congue.
					 Quisque porttitor luctus mauris, ac rhoncus libero dignissim vel. Sed eget posuere orci. 
				 	Proin elit libero, feugiat sed suscipit sit amet, congue vitae eros. In vulputate scelerisque dui,
				 	vitae mollis nisl aliquam sed. Proin consectetur velit </p>
					<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
				</div>
				<div class="hero-unit">
					<p class="lead">Usuario</p>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet cursus congue.
					 Quisque porttitor luctus mauris, ac rhoncus libero dignissim vel. Sed eget posuere orci. 
				 	Proin elit libero, feugiat sed suscipit sit amet, congue vitae eros. In vulputate scelerisque dui,
				 	vitae mollis nisl aliquam sed. Proin consectetur velit </p>
					<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
				</div>
			</div>
    	</div>
    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">
