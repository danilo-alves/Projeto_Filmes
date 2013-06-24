<!--- Inclui o conteudo de cabe&ccedil;alho padr&atilde;o --->
<cfinclude template="Header.cfm">

	<!--- X-Editable plugin --->
<!--- <link href="assets/x-editable-1.4.4/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet"> --->
<!--- <script src="assets/x-editable-1.4.4/bootstrap-editable/js/bootstrap-editable.min.js"></script> --->

<cfif isUserLoggedin()>
	<cfparam name="imgCapa" default=""> 
	<cfparam name="editEnabled" default="false">
	
	<!--- Necess&aacute;rio para formul&aacute;rio Ajax --->
	<cfajaximport/>

  	<!--- Avaliacao de filme utilizando Ajax --->
	<script  src="avaliarAction.js"></script>
	<script  src="listaDesejoAction.js"></script>
	<script  src="pontuacaoCritica.js"></script>

	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="CheckMenuBar.cfm"> <!--- Inclui a barra de menus --->

    	<cfset id_usuario = url.Id >

		<!--- Retorna um registro unico (true) do Filme de Id recebido pela URL --->
		
		<cfset dadosUsuario = EntityLoadByPk('Usuario', url.Id)>
		
		<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
		<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

		<!--- Habilita o modo de edi&ccedil;&atilde;o --->
		<cfif dadosUsuario.getEmail() EQ user.getEmail()>
			<cfset editEnabled = "true">
		<cfelse>
			<cfset editEnabled = "false">
		</cfif>

		<cfset imgCapa = EntityLoad('ImagemUsuario', {Id_Usuario = #dadosUsuario#}, true)>
		
		<!--- Exibe um thumbnail padrao caso n&atilde;o exista imagem --->
		<div class="span6">
			<div class="row">
	    		<div class="span2" style="float: left">
					<cfif isDefined('imgCapa')>
						<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
					<cfelse>
						<img data-src="holder.js/260x160">
					</cfif>
				</div>
			
				<!--- CONTEUDO --->
				<cfoutput>
					<div class="span4">
						<cfif #editEnabled# EQ "true">
							<h2>#dadosUsuario.getNome()#</h2>
							<p class="lead">Email: <a href="mailto:#dadosUsuario.getEmail()#">#dadosUsuario.getEmail()#</a></p>
		    			</cfif>
					</div>

					<div class="span2">
						<cfif #editEnabled#>
							<cfoutput><a href="Cadastro.cfm?Id=#url.Id#" class="btn bnt-mini btn-warning">Editar</a></cfoutput>
						</cfif>
					</div>
				</cfoutput>
			</div>
    
	    	<cfset desc = #dadosUsuario.getDescricao()#>
	    	<cfif isDefined('desc') >
	    	<div class="row">
	    		<div class="span10">
	    			<h2>Descri&ccedil;&atilde;o</h2>
					<cfoutput><p>#desc#</p></cfoutput>
				</div>
			</div>
	    	</cfif>

			<div class="row">
				<div class="span10">
			    	<cfset grupos = EntityLoad('Grupo', {Id_Usuario = #dadosUsuario#})>
			    	<cfif isDefined('grupos')>
			    		<hr/>
			    		<h4>Grupos</h4>
			    		<cfloop array="#grupos#" index="grp">
			    			<cfset imgCapa = entityLoad('ImagemGrupo', {Id_Grupo=grp}, true) />
						  	<li class="span3">
						    	<div class="thumbnail">
						    		<cfoutput>
						      			<a class="thumbnail" href="InfoGrupo.cfm?Id=#grp.getId_Grupo()#">
						      			<cftry>
					      					<cfset imgPath = #imgCapa.getImagem_Path()#>
												  
						      				<!--- Carrega a imagem --->
											<cfif isDefined('imgPath') || isNull(imgPath) >
												<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
											<cfelse>
												<img data-src="holder.js/260x160">
											</cfif>
										<cfcatch>
											<!--- Exibe um thumbnail padrao caso n&atilde;o exista imagem --->
											<img data-src="holder.js/260x160">
										</cfcatch>
										</cftry>
										</a>
							  			<h5>#grp.getNome_Grupo()#</h5>
									</cfoutput>
						    	</div>
						  	</li>	
			    		</cfloop>
			    	</cfif>
			    </div>
	    	</div>

			<div class="row">
				<div class="span10">
		    	<cfset listaFilmes = EntityLoad('ListaDesejo', {Usuario = #dadosUsuario#})>
				<cfif isDefined('listaFilmes')>
		    	<hr/>
		    		<h4>Filmes a assistir</h4>
		    		<cfloop array="#listaFilmes#" index="grp">
		    			<cfset imgCapa = entityLoad('Imagem', {Id_Filme=grp.getFilme()}, true) />
					  	<li class="span3">
					    	<div class="thumbnail">
					    		<cfoutput>
					      			<a class="thumbnail" href="InfoFilme.cfm?Id=#grp.getFilme().getId_Filme()#">
					      			<cftry>
				      					<cfset imgPath = #imgCapa.getImagem_Path()#>
											  
					      				<!--- Carrega a imagem --->
										<cfif isDefined('imgPath') || isNull(imgPath) >
											<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
										<cfelse>
											<img data-src="holder.js/260x160">
										</cfif>
									<cfcatch>
										<!--- Exibe um thumbnail padrao caso n&atilde;o exista imagem --->
										<img data-src="holder.js/260x160">
									</cfcatch>
									</cftry>
									</a>
						  			<h5>#grp.getFilme().getTitulo()#</h5>
								</cfoutput>
					    	</div>
					  	</li>	
		    		</cfloop>
		    	</cfif>
		    	</div>
		    </div>
    	</div>
	</div>
</cfif>

<!--- Inclui o conteudo de rodapé padr&atilde;o --->
<cfinclude template="Footer.cfm">
