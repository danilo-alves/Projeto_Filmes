<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">
	
<!--- Necessário para formulário Ajax --->
<cfajaximport/>

<cfif getAuthUser() NEQ "">		

	<cfparam name="imgCapa" default=""> 

	<script  src="joinGrupoAction.js"></script>

	<!-- Corpo do site  -->
    <div id="maincontent" class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->

		<cfset grupos = EntityLoad("Grupo")/>

		<!--- <cfdump var="#listaDesejo#"> --->
    	<div class="span10">
			<h3>Grupos</h3>
			<hr/>
			
			<cfif arrayLen(grupos) NEQ 0>
				
				<cfloop index="grupo" array="#grupos#">

				<!--- obtem os usuários pertencentes ao grupo --->
				<cfset usersGrupo = EntityLoad("Usuario_Grupo", {Grupo = #grupo#}) />

					<div class="media">
						 <cfoutput><a class="pull-left" href="InfoGrupo.cfm?Id=#grupo.getId_Grupo()#"></cfoutput>
						 	<!--- Carrega a imagem de capa do filme --->
							<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #grupo#}, true)>			
							<cfif isDefined('imgCapa') >	
								<cfset imgPath = #imgCapa.getImagem_Path()#>
								<cfimage class="media-object" action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
							<cfelse>
								<img class="media-object" data-src="holder.js/100x100">
							</cfif>
							
						</a>

						<div class="media-body">
							<h4 class="media-heading"><cfoutput>#grupo.getNome_Grupo()#</cfoutput></h4>	
							<cfoutput>
								<p>#arrayLen(usersGrupo)# Membros</p>
								<p>#Mid(grupo.getDescricao(), 1, 350)#...</p>
								
								<!--- Dados de identificação a serem passados --->
								<cfform name="formJoin" method="POST">
									<cfinput name="id_grupo" type="hidden" required="true" value="#grupo.getId_Grupo()#"/>								
									<cfinput name="id_user" type="hidden" required="true" value="#user.getId_Usuario()#"/>								
									<p class="pull-right"><a href="javascript:submitJoin()" class="btn btn-success">Join</a></p>
								</cfform>
							</cfoutput>
						</div>
					</div>
				</cfloop>
			<cfelse>
				<div class="alert alert-warning">
					<p class="lead=">Não há grupos. <a href="AddGrupo.cfm">Adicionar</a></p>
				</div>
			</cfif>
	</div>
<cfelse>
	<!--- Redireciona para a pagina de cadastro --->
	<div class='alert alert-warning'>
		<h3>Usuario n&atilde;o autenticado!</h3>
		<p>Fa&ccedil;a o login ou <a href="Cadastro.cfm?prevPage=AddFilme.cfm">cadastre-se</a> agora. &Eacute; simples!</p>
	</div> 
</cfif>
<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">