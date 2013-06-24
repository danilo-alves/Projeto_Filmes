<!--- Inclui o conteudo de cabe&ccedil;alho padr&atilde;o --->
<cfinclude template="Header.cfm">

<cfparam name="form.inputGrupo" default="">
<cfparam name="form.fileData" default="">
<cfparam name="form.txtDescricao" default="">

<cfparam name="tituloErro" default="">

<!--- Verifica se o usu&aacute;rio esta logado para poder cadastrar o filme
	isUserLoggedin é uma fun&ccedil;&atilde;o do módulo de autentica&ccedil;&atilde;o do ColdFusion.
	Caso contr&aacute;rio redireciona o usu&aacute;rio para a pagina de cadastro --->
<cfif isUserLoggedin() >
	<cfif isDefined("url.Id")>

		<cfset dadosGrupo = EntityLoadByPk('Grupo', #url.Id#) >

		<!--- Verifica se o visitante da pagina de grupo é o criador e entao permite a edicao --->
		<cfset userCriador = dadosGrupo.getId_Usuario()>

		<!--- Habilita o modo de edi&ccedil;&atilde;o --->
		<cfif userCriador.getEmail() EQ user.getEmail()>
			<cfset editEnabled = "true">
		</cfif>
	</cfif>

	<!--- <cftry> --->
		<!--- // Condicao satisfeita somente quando o formul&aacute;rio é enviado via POST contendo os dados do formul&aacute;rio --->
		<cfif isDefined('form.btnCadastrar')>
			<cfif NOT isDefined('editEnabled')>
				<cfset novoGrupo = entityNew('Grupo') />
			<cfelse>
				<cfset novoGrupo = dadosGrupo>
			</cfif>
			
			<!--- // Verifica se j&aacute; existe um filme com mesmo titulo --->
			<cfif novoGrupo.grupoExiste('#form.inputGrupo#') AND NOT isDefined('editEnabled')>
				<cfset tituloErro = "error" />
			<cfelse>
				<cfif NOT isDefined('user')>	
					<cfset user = EntityLoad("Usuario", {Email="#GetAuthUser()#"}, true)>
				</cfif>

				<!--- <cftry> --->
					
					<cfset novoGrupo.setNome_Grupo(form.inputGrupo) />
					<cfset novoGrupo.setDescricao(form.txtDescricao) />
					<cfset novoGrupo.setId_Usuario(user) />
					
					<cfset EntitySave(novoGrupo) />
					
					<cfset ormFlush('ds_Projeto_Filme') />
					
					<!--- //writeDump(form); --->
					<!--- // Cria uma pasta com o nome do usu&aacute;rio --->
					<!--- ExpandPath obtem o caminho completo para a diretório do projeto na pasta de imagens --->
					<cfset basePath = ExpandPath("/Projeto_Filmes/UserData/User#user.getId_Usuario()#/") />
						<cftry>
							<!--- // realiza o upload da imagem com base no padrao de diretorio para usuario --->
							<cfif fileExists(#fileData#)>
							<cffile action="upload" fileField="fileData" destination="#basePath#" nameconflict="makeUnique" />
								
							<!--- Obtem o caminho completo da imagem para armazenar na base de dados --->
							<cfset imgCapaPath = "#cffile.ServerDirectory#" & "/" & "#cffile.ServerFile#">
							

								<cfif NOT isDefined('editEnabled')>
									<cfset imgCapa = EntityNew('ImagemGrupo')>
								<cfelse>
									<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #dadosGrupo#}, true) >
									<!--- <cfif isDefined('imgCapa')>
										
									<cfdump var="#imgCapa#">
									</cfif> --->
								</cfif>

								

								<cfset imgCapa.setId_Grupo(novoGrupo) >
								<cfset imgCapa.setImagem_Path(#imgCapaPath#) > 
								<cfset EntitySave(imgCapa) >
							</cfif>
							
							<cfcatch type="application">
								<cfoutput>
									<div class='alert alert-error'>
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										<h1>Erro ao carregar a imagem!</h1>
										<p>Verifique o tipo de arquivo que voc&ecirc; est&aacute; tentando utilizar.</p>
									</div>
								</cfoutput>
							</cfcatch>
						</cftry>

							<!--- <cfdump var="#cffile#"> --->
					<div class='alert alert-success'>
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<h1>Sucesso!</h1>
						<p>Grupo adicionado!</p>
						<cfoutput><p>Clique <a href="InfoGrupo.cfm?id=#novoGrupo.getId_Grupo()#">aqui</a> para visualizar seu grupo</p></cfoutput>
					</div>
					<cfset ormFlush('ds_Projeto_Filme') />

			</cfif>
		</cfif>		
	<!--- <cfcatch>
			<cfoutput>#cfcatch.Message#</cfoutput>
			<!--- <cfdump var="#form#"> --->
	</cfcatch>
	</cftry> --->

	<!-- Corpo do site  -->
    <div class="row">
    	
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
    	<div class="span10">
    		<cfform name="form" class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
			<fieldset>
				<legend>Informa&ccedil;&otilde;es Gerais</legend>
				<div class="control-group">
					<label class="control-label" for="inputGrupo">Nome do Grupo:</label>
					<div class="controls">
						<cfif NOT isDefined('editEnabled')>
							<cfinput name="inputGrupo" type="text" required="true" class="input-xxlarge" placeholder="Nome do Grupo" message="Infome um nome de grupo válido.">
						<cfelse>
							<cfinput name="inputGrupo" type="text" required="true" class="input-xxlarge" placeholder="Nome do Grupo" value="#dadosGrupo.getNome_Grupo()#" message="Infome um nome de grupo válido.">
						</cfif>
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Imagem</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Imagem de capa:</label>
					<div class="controls">
						<cfif isDefined('editEnabled')>
							<cfset imgCapa = EntityLoad('ImagemGrupo', {Id_Grupo = #dadosGrupo#}, true)>
							<cfif isDefined('imgCapa')>
								<cfoutput><cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100"></cfoutput>
								<cfinput type="file" name="fileData" value="#imgCapa.getImagem_Path()#"  accept="image/jpg,image/gif,image/png,image/jpeg" message="Adicione um arquivo de imagem v&aacute;lido (png, jpg ou gif).">
							<cfelse>
								<img data-src="holder.js/160x160">
								<cfinput type="file" name="fileData"  accept="image/jpg,image/gif,image/png,image/jpeg" message="Adicione um arquivo de imagem v&aacute;lido (png, jpg ou gif)." >
							</cfif>
						<cfelse>
							<cfinput type="file" name="fileData"  accept="image/jpg,image/gif,image/png,image/jpeg" message="Adicione um arquivo de imagem v&aacute;lido (png, jpg ou gif).">
						</cfif>

					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Descri&ccedil;&atilde;o</legend>
				<div class="control-group">
					<cftextarea name="txtDescricao" rows="5" maxlength="300" width="300" richtext="false" message="Informe uma descri&ccedil;ão par identificar seu grupo.">
						<cfif isDefined('editEnabled')>
							<cfoutput>#dadosGrupo.getDescricao()#</cfoutput>
						</cfif>
					</cftextarea>
				</div>
			</fieldset>
			<div class="form-actions">
				<cfif NOT isDefined('editEnabled')>	
					<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
				<cfelse>
					<button name="btnCadastrar" class="btn btn-warning" type="submit">Editar</button>
				</cfif>

				<button name="btnCancelar" class="btn" type="button">Cancelar</button>
			</div>
		</cfform>
    	</div>
    </div>
<cfelse>
	<!--- Redireciona para a pagina de cadastro --->
	<div class='alert alert-warning'>
		<h3>Usu&aacute;rio n&atilde;o autenticado!</h3>
		<p>Fa&ccedil;a o login ou <a href="Cadastro.cfm?prevPage=AddFilme.cfm">cadastre-se</a> agora. &Eacute; simples!</p>
	</div> 
</cfif>
<!--- Inclui o conteudo de rodapé padr&atilde;o --->
<cfinclude template="Footer.cfm">
