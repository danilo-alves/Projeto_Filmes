<!--- Inclui o conteudo de cabe&ccedil;alho padr&atilde;o --->
<cfinclude template="Header.cfm">

<!--- Necess&aacute;rio para formul&aacute;rio Ajax --->
<cfajaximport/>
<script  src="joinGrupoAction.js"></script>

	
<!--- Carrega o registro correspondente ao id passado por parametro --->
<cfset grupo = EntityLoadByPK("Grupo", #url.Id#)/>
<cfset membrosGrupo = EntityLoad('Usuario_Grupo', {Grupo = #grupo#}) >
<!--- <cfdump var="#getGrupo#">
<cfdump var="#grupo#"> --->

<!--- Caso n&atilde;o receba o Id do grupo como parametro redireciona para a pagina que lista os grupos  --->
<cfif NOT isDefined('url.Id') OR NOT isDefined('grupo')>
	<cflocation url="Grupos.cfm"/>
</cfif>

<cfif isUserLoggedin()>		
	<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
	<cfset userCriador = grupo.getId_Usuario()>
	<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

	<!--- Habilita o modo de edi&ccedil;&atilde;o --->
	<cfif userCriador.getEmail() EQ user.getEmail()>
		<cfset editEnabled = "true">
	<cfelse>
		<cfset editEnabled = "false">
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
		<div class="row-fluid">
		
		<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #grupo#}, true)>
		<cfif isDefined('imgCapa')>
			
			<!--- spanNum obtido em CheckMenuBar.cfm --->
    		<div class="span2" style="float: left">
				<cfset imgPath = #imgCapa.getImagem_Path()#>
	    		<!--- Carrega a imagem --->
				<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
			</div>
		<cfelse>
			<!--- Exibe um thumbnail padrao caso n&atilde;o exista imagem --->
	    		<div class="span2" style="float: left">
					<img data-src="holder.js/160x160">
				</div>
		</cfif>
		
	
		<div class="span7">
			<h2>#grupo.getNome_Grupo()#</h2>
			<p>#arrayLen(membrosGrupo)# membro(s) cadastrado neste grupo</p>
			<!--- Verifica se o usu&aacute;rio j&aacute; participa deste grupo ocultando ou n&atilde;o o bot&atilde;o de participe, caso
			contrario oferece a opcao de sair do grupo --->
			<cfset isMember = EntityLoad('Usuario_Grupo', {Grupo = #grupo#, Usuario = #user#})>
		</div>				
		
		<div class="span1">
			<cfif #editEnabled#>
				<p><a href="addGrupo.cfm?Id=#grupo.getId_Grupo()#" class="btn bnt-mini btn-warning">Editar</a></p>
				<a href="javascript:adicionaLista(#grupo.getId_Grupo()#)" class="btn bnt-mini btn-danger">Excluir</a>
			<cfelse>
				<!--- Dados de identifica&ccedil;&atilde;o a serem passados --->
				<cfform name="formJoin#grupo.getId_Grupo()#" method="POST">
					<cfinput name="id_grupo" type="hidden" required="true" value="#grupo.getId_Grupo()#"/>								
					<cfinput name="id_user" type="hidden" required="true" value="#user.getId_Usuario()#"/>								
					<!--- Verifica se o usuario ja fa parte do grupo para adicionar ou remover --->
					<cfif arraylen('#isMember#') EQ 0>
						<p id="btnAction#grupo.getId_Grupo()#"><a href="javascript:submitJoin(#grupo.getId_Grupo()#,1)" class="btn btn-success">Participar</a></p>
					<cfelse>
						<p id="btnAction#grupo.getId_Grupo()#"><a href="javascript:submitJoin(#grupo.getId_Grupo()#,0)" class="btn btn-danger">Sair deste grupo</a></p>
					</cfif>
				</cfform>
			</cfif>
		</div>
		</div>
		<hr/>
		
		<div class="#spanNum#">
			<h3>Descri&ccedil;&atilde;o</h3>
			<hr/>
			<p>#grupo.getDescricao()#</p>
			
			<h3>Membros</h3>
			<hr/>
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
	</div>
	</cfoutput>
</div>
<!--- Inclui o conteudo de rodapé padr&atilde;o --->
<cfinclude template="Footer.cfm">