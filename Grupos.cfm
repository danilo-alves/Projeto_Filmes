<!--- Inclui o conteudo de cabe&ccedil;alho padr&atilde;o --->
<cfinclude template="Header.cfm">
	
<!--- Necess&aacute;rio para formul&aacute;rio Ajax --->
<cfajaximport/>
<script  src="joinGrupoAction.js"></script>

<cfif getAuthUser() NEQ "">		

	<cfparam name="imgCapa" default=""> 


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
					<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
					<cfset userCriador = grupo.getId_Usuario()>

					<!--- Habilita o modo de edi&ccedil;&atilde;o --->
					<cfif userCriador.getEmail() EQ user.getEmail()>
						<cfset editEnabled = "true">
					<cfelse>
						<cfset editEnabled = "false">
					</cfif>

					<!--- obtem os usu&aacute;rios pertencentes ao grupo --->
					<cfset usersGrupo = EntityLoad("Usuario_Grupo", {Grupo = #grupo#}) />

					<div class="media">
						 <cfoutput><a class="pull-left" href="InfoGrupo.cfm?Id=#grupo.getId_Grupo()#"></cfoutput>
						 	<!--- Carrega a imagem de capa do filme --->
							<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #grupo#}, true)>			
							<cfif isDefined('imgCapa') >	
								<cfset imgPath = #imgCapa.getImagem_Path()#>
								<cfimage class="media-object" action="writeToBrowser" source="#imgPath#" height="100" width="100">
							<cfelse>
								<img class="media-object" data-src="holder.js/100x100"/>
							</cfif>
						</a>

						<div class="media-body">
							<h4 class="media-heading"><cfoutput>#grupo.getNome_Grupo()#</cfoutput></h4>	
							<cfoutput>
								<div class="row-fluid">
									<div class="span8">
										<p>#arrayLen(usersGrupo)# Membros</p>
										<p>#Mid(grupo.getDescricao(), 1, 350)#...</p>
									</div>
									<div class="span4">
										<!--- Verifica se o usu&aacute;rio j&aacute; participa deste grupo ocultando ou n&atilde;o o bot&atilde;o de participe, caso
										contrario oferece a opcao de sair do grupo --->
										<cfset isMember = EntityLoad('Usuario_Grupo', {Grupo = #grupo#, Usuario = #user#})>
										<cfif #editEnabled#>
											<cfoutput><p><a href="addGrupo.cfm?Id=#grupo.getID_Grupo()#" class="btn bnt-mini btn-warning">Editar</a></p></cfoutput>
											<cfoutput><a href="dropGrupo.cfm?Id=#grupo.getID_Grupo()#" class="btn bnt-mini btn-danger">Excluir</a></cfoutput>
										<cfelse>
											<!--- Dados de identifica&ccedil;&atilde;o a serem passados --->
											<cfform name="formJoin#grupo.getId_Grupo()#" method="POST">
												<cfinput name="id_grupo" type="hidden" required="true" value="#grupo.getId_Grupo()#"/>								
												<cfinput name="id_user" type="hidden" required="true" value="#user.getId_Usuario()#"/>								
												<!--- Verifica se o usuario ja fa parte do grupo para adicionar ou remover --->
												<cfif arraylen('#isMember#') EQ 0>
													<p id="btnAction#grupo.getId_Grupo()#" class="pull-right"><a href="javascript:submitJoin(#grupo.getId_Grupo()#,1)" class="btn btn-success">Participar</a></p>
												<cfelse>
													<p id="btnAction#grupo.getId_Grupo()#" class="pull-right"><a href="javascript:submitJoin(#grupo.getId_Grupo()#,0)" class="btn btn-danger">Sair deste grupo</a></p>
												</cfif>
											</cfform>
										</cfif>
									</div>
								</div>
							</cfoutput>
						</div>
					</div>
					<hr/>
				</cfloop>
			<cfelse>
				<div class="alert alert-warning">
					<p class="lead=">N&atilde;o h&aacute; grupos. <a href="AddGrupo.cfm">Adicionar</a></p>
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
<!--- Inclui o conteudo de rodapé padr&atilde;o --->
<cfinclude template="Footer.cfm">