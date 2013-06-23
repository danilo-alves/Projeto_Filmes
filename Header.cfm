<!DOCTYPE html>
<html>
  <head>
    <title>Projeto Untitled</title>

	<!-- Bootstrap -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" media="screen">
    
    <style>
		body {
			padding-top: 40px;
		}
	</style>
        
    <!-- CSS para layout responsive -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
	<!--- Star Rating - http://wbotelhos.com/raty/ --->
	<!--- <script type="text/javascript" src="assets/lib/jquery.raty.min.js"></script>
	<script type="text/javascript" src="assets/js/jquery.min.js"></script> --->
  </head>
  <body>
  	
	<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

  	<!-- Barra de Menu Superior -->
  	<!-- Fora do div container ocupa toda a pagina  -->
  	<div class="navbar navbar-fixed-top navbar-inverse"><!-- navbar-inverse para barra de menu preta -->
  		<div class="navbar-inner">
  			<!-- Nome do Projeto ou Logo -->
  			<a class="brand" href="index.cfm">Projeto Untitled</a>
  			
  			<!-- Botão com 3 barras que irá aparecer em dispositivos com tela menor -->
  			<!-- HINT: Para testar no desktop redimensione a janela do navegador -->
  			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
  				<span class="icon-bar"></span>
  				<span class="icon-bar"></span>
  				<span class="icon-bar"></span>
  			</a>
  			
  			<!-- Parte do menu superior que será oculto em telas menores -->
  			<div class="nav-collapse collapse">
  				<!-- Opçoes do menu -->
	  			<ul class="nav">
	  				<li class="divider-vertical"></li><!-- linha vertical divisora-->
	  				<li class="active"><a href="#">Home</a></li>
	  				
	  				<li>
						<!-- Label do dropdown -->
		  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
		  						Filmes
		  					</a>
		  					
		  					<!-- Opção do dropdown -->
		  					<ul class="dropdown-menu" aria-labellely="dlabel">
		  						<cfquery name="getGeneros" datasource="ds_Projeto_Filmes">
									SELECT Id_Genero, Descricao FROM tbl_Genero
								</cfquery>
								<cfloop query="getGeneros" endRow="10">
										<li><a href=""><cfoutput>#Descricao#</cfoutput></a></li>
								</cfloop>
		  					</ul></li>
	  				
	  				<li><a href="Grupos.cfm">Grupos</a></li>
	  				
	  				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
	  				
	  				<li><a href="#">Sobre</a></li>
	  			</ul>
	  		
  				<cfif GetAuthUser() NEQ "">	
  					<!-- Dropdown para usuário logado -->
		  			<ul class="nav pull-right">
		  				<li class="dropdown">
		  					<!-- Label do dropdown -->
		  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
		  						<!---Obtem o nome do usuario (neste caso o email) --->
		  						<cfoutput>#GetAuthUser()#</cfoutput>
		  						<b class="caret"></b>
		  					</a>
		  					
		  					<!-- Opção do dropdown -->
		  					<ul class="dropdown-menu" aria-labellely="dlabel">
		  						<li><a href="#">Meu Perfil</a></li>
		  						<li><a href="#">Favoritos</a></li>
		  						<li><a href="index.cfm?logout">Sair</a></li>
		  					</ul>
		  				</li>
		  			</ul>
	  			<cfelse>
				  	
		  			<!--- Formulario de login na barra de menu --->
					<!--- Esta form irá executar por meio do atributo action esta mesma pagina (CGI.script_name) --->
					<!--- A verificação do usuário e o login é efetuado no método OnRequestStart que é executado a cada
						nova requisição de carregamento de qualquer página --->
		  			<cfform class="navbar-search pull-right form-inline" method="POST" action="#CGI.script_name#?#CGI.query_string#">
					  	<a href="Cadastro.cfm">Cadastre-se</a>
		  				<cfinput name="j_username" type="email" class="input-medium" placeholder="Email" required="true">
		  				<cfinput name="j_password" type="password" class="input-mini" placeholder="Senha" required="true">
		  				<button name="Submit" type="submit"><i class="icon-circle-arrow-right"></i></button>
		  			</cfform>
		  		</cfif>
  			</div>
  		</div>
  	</div>
	<!--- Conteudo da pagina --->
	<div class="container">