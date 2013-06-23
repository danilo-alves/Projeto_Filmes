<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<cfquery name="getGrupo" datasource="ds_Projeto_Filmes">
	SELECT * FROM tbl_Grupo WHERE Id_Grupo = #url.Id#;
</cfquery>
	
<!--- Carrega o registro correspondente ao id passado por parametro --->
<cfset grupo = EntityLoadByPK("Grupo", #url.Id#)/>

<!--- <cfdump var="#getGrupo#">
<cfdump var="#grupo#"> --->

<!--- Caso não receba o Id do grupo como parametro redireciona para a pagina que lista os grupos  --->
<cfif NOT isDefined('url.Id') OR NOT isDefined('grupo')>
	<cflocation url="Grupos.cfm"/>
</cfif>

<cfif getAuthUser() NEQ "">		
	<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
	<cfset userCriador = grupo.getId_Usuario()>
	<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

	<!--- Habilita o modo de edição --->
	<cfif userCriador.getEmail() EQ user.getEmail()>
		<cfset editEnabled = "true">
	</cfif>
</cfif>


<cfparam name="imgCapa" default=""> 

<!-- Corpo do site  -->
<div id="maincontent" class="row">
	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
	<cfinclude template="CheckMenuBar.cfm"> <!--- Inclui a barra de menus --->

	<!--- <cfdump var="#listaDesejo#"> --->
	<cfoutput>
	<div class="#spanNum#">
		<cftry>
			<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #grupo#}, true)>
			
			<!--- spanNum obtido em CheckMenuBar.cfm --->
			<cfoutput><div class="span10"></cfoutput>
	    		<div class="span2" style="float: left">
					<cfset imgPath = #imgCapa.getImagem_Path()#>

	    			<!--- Carrega a imagem --->
					<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
				</div>
		<cfcatch>
			<!--- Exibe um thumbnail padrao caso não exista imagem --->
			<cfoutput><div class="span10"></cfoutput>
	    		<div class="span2" style="float: left">
					<img data-src="holder.js/260x160">
				</div>
		</cfcatch>
		</cftry>
	
		<h2>#grupo.getNome_Grupo()#</h2>
		<hr/>
		
		<div class="#spanNum#">
			<h3>Descrição</h3>
			<hr/>
			<p>#grupo.getDescricao()#</p>
			
			<h3>Membros</h3>
			<hr/>
			<cfset membrosGrupo = EntityLoad('Usuario_Grupo', {Grupo = #grupo#}) >
			<!--- <cfdump var="#membrosGrupo#"> --->
			<cfloop index="membro" array="#membrosGrupo#">
				<div class="media">
					<cfoutput><a class="pull-left" href="InfoGrupo.cfm?Id=#membro.getUsuario().getId_Usuario()#"></cfoutput>
					 	<!--- Carrega a imagem de capa do filme --->
						<cfset imgCapa = EntityLoad('ImagemUsuario', {Id_Usuario = #membro.getUsuario()#}, true)>			

						<cfif isDefined('imgCapa') >
							<cfset imgPath = #imgCapa.getImagem_Path()#>
							<cfimage class="media-object" action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
						<cfelse>
							<img class="media-object" data-src="holder.js/100x100">
						</cfif>
					</a>

					<div class="media-body">
						<h4 class="media-heading"><cfoutput>#membro.getUsuario().getNome()#</cfoutput></h4>	
					</div>
				</div>
			</cfloop>

		</div>
	
	</cfoutput>
</div>
<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">