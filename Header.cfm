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
  			
  			<!-- Bot&atilde;o com 3 barras que ir&aacute; aparecer em dispositivos com tela menor -->
  			<!-- HINT: Para testar no desktop redimensione a janela do navegador -->
  			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
  				<span class="icon-bar"></span>
  				<span class="icon-bar"></span>
  				<span class="icon-bar"></span>
  			</a>
  			
  			<!-- Parte do menu superior que ser&aacute; oculto em telas menores -->
  			<div class="nav-collapse collapse">
  				<!-- Op&ccedil;oes do menu -->
	  			<ul class="nav">
	  				<li class="divider-vertical"></li><!-- linha vertical divisora-->
	  				<cfswitch expression="#CGI.script_name#">
					
					<cfcase value="/Projeto_Filmes/Grupos.cfm">
						<li><a href="index.cfm">Home</a></li>
		  				<li>
							<!-- Label do dropdown -->
			  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
			  						Filmes
			  					</a>
			  					
			  					<!-- Op&ccedil;&atilde;o do dropdown -->
			  					<ul class="dropdown-menu" aria-labellely="dlabel">
			  						<cfquery name="getGeneros" datasource="ds_Projeto_Filmes">
										SELECT Id_Genero, Descricao FROM tbl_Genero
									</cfquery>
									<cfloop query="getGeneros" endRow="10">
											<!--- Coloca como link o id do genero a ser pesquisado --->
											<cfoutput><li><a href="Index.cfm?search=#Id_Genero#">#Descricao#</a></li></cfoutput>
									</cfloop>
			  					</ul></li>
		  				<li class="active"><a href="Grupos.cfm">Grupos</a></li>
		  				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
					</cfcase>
					
					<cfcase value="/Projeto_Filmes/MinhaListaDesejo.cfm">
						<li><a href="index.cfm">Home</a></li>
		  				<li>
							<!-- Label do dropdown -->
			  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
			  						Filmes
			  					</a>
			  					
			  					<!-- Op&ccedil;&atilde;o do dropdown -->
			  					<ul class="dropdown-menu" aria-labellely="dlabel">
			  						<cfquery name="getGeneros" datasource="ds_Projeto_Filmes">
										SELECT Id_Genero, Descricao FROM tbl_Genero
									</cfquery>
									<cfloop query="getGeneros" endRow="10">
											<!--- Coloca como link o id do genero a ser pesquisado --->
											<cfoutput><li><a href="Index.cfm?search=#Id_Genero#">#Descricao#</a></li></cfoutput>
									</cfloop>
			  					</ul></li>
		  				<li><a href="Grupos.cfm">Grupos</a></li>
		  				<li class="active"><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
					</cfcase>
					
					
					
					<cfdefaultcase>
		  				<li><a href="index.cfm">Home</a></li>
		  				<li>
							<!-- Label do dropdown -->
			  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
			  						Filmes
			  					</a>
			  					
			  					<!-- Op&ccedil;&atilde;o do dropdown -->
			  					<ul class="dropdown-menu" aria-labellely="dlabel">
			  						<cfquery name="getGeneros" datasource="ds_Projeto_Filmes">
										SELECT Id_Genero, Descricao FROM tbl_Genero
									</cfquery>
									<cfloop query="getGeneros" endRow="10">
											<!--- Coloca como link o id do genero a ser pesquisado --->
											<cfoutput><li><a href="Index.cfm?search=#Id_Genero#">#Descricao#</a></li></cfoutput>
									</cfloop>
			  					</ul></li>
		  				<li><a href="Grupos.cfm">Grupos</a></li>
		  				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
					</cfdefaultcase>
					</cfswitch>
	  			</ul>
	  		
  				<cfif isUserLoggedin()>	
  					<!-- Dropdown para usu&aacute;rio logado -->
		  			<ul class="nav pull-right">
		  				<li class="dropdown">
		  					<!-- Label do dropdown -->
		  					<a href="dropdown-toggle" id="dLabel" role="button" data-toggle="dropdown">
		  						<!---Obtem o nome do usuario (neste caso o email) --->
		  						<cfoutput>#GetAuthUser()#</cfoutput>
		  						<b class="caret"></b>
		  					</a>
		  					
		  					<!-- Op&ccedil;&atilde;o do dropdown -->
		  					<cfoutput>
			  					<ul class="dropdown-menu" aria-labellely="dlabel">
			  						<li><a href="PerfilUsuario.cfm?Id=#user.getId_Usuario()#">Meu Perfil</a></li>
			  						<li><a href="MinhaListaDesejo.cfm?Id=#user.getId_Usuario()#">Lista de Desejos</a></li>
			  						<li><a href="index.cfm?logout">Sair</a></li>
			  					</ul>
		  					</cfoutput>
		  				</li>
		  			</ul>
	  			<cfelse>
				  	
		  			<!--- Formulario de login na barra de menu --->
					<!--- Esta form ir&aacute; executar por meio do atributo action esta mesma pagina (CGI.script_name) --->
					<!--- A verifica&ccedil;&atilde;o do usu&aacute;rio e o login é efetuado no método OnRequestStart que é executado a cada
						nova requisi&ccedil;&atilde;o de carregamento de qualquer p&aacute;gina --->
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