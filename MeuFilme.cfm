<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">
	
<cfif getAuthUser() NEQ "">		

	<cfparam name="imgCapa" default=""> 
	
	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->

		<!--- Retorna um array com os filmes criados por determinado usuário --->
		<cfset meusFilmes = user.getFilmeByUser()/>

    	<div class="span10">
			<h3>Meus Filmes</h3>
			<hr/>
			
			<cfif arrayLen(meusFilmes) NEQ 0>
				
				<cfloop index="filme" array="#meusFilmes#">

					<div class="media">
						 <cfoutput><a class="pull-left" href="InfoFilme.cfm?Id=#filme.getId_Filme()#"></cfoutput>
						 	<!--- Carrega a imagem de capa do filme --->
							<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = #filme#}, true)>			
							<cfif isDefined('imgCapa') >	
								<cfset imgPath = #imgCapa.getImagem_Path()#>
								<cfimage class="media-object" action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
							<cfelse>
								<img class="media-object" data-src="holder.js/100x100">
							</cfif>
							
						</a>
						<div class="media-body">
							<h4 class="media-heading"><cfoutput>#filme.getTitulo()#</cfoutput></h4>	
							<cfoutput><p>#Mid(filme.getSinopse(), 1, 350)#...</p></cfoutput>
						</div>
					</div>
				</cfloop>
			<cfelse>
				<div class="alert alert-warning">
					<p class="lead=">Não há filmes adicionados por você. <a href="AddFilme.cfm">Adicionar</a></p>
				</div>
			</cfif>
	</div>
<cfelse>
	<!--- Redireciona para a pagina de cadastro --->
	<div class='alert alert-warning'>
		<h3>Usuário não autenticado!</h3>
		<p>Faça o login ou <a href="Cadastro.cfm?prevPage=AddFilme.cfm">cadastre-se</a> agora. É simples!</p>
	</div> 
</cfif>
<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">