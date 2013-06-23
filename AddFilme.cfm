<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<cfparam name="form.inputTitulo" default="">
<cfparam name="form.sldrAno" default="#YEAR(NOW())#"> 
<cfparam name="form.sldrDuracao" default="">
<cfparam name="form.dropdown_Genero" default="">
<cfparam name="form.fileData" default="">
<cfparam name="form.inputTrailer" default="">
<cfparam name="form.txtSinopse" default="">

<cfparam name="dadosFilme" default="">

<cfparam name="tituloErro" default="">

<cfif isUserLoggedin()>
			
	<cfif isDefined("url.Id")>
		
		<cfset dadosFilme = EntityLoadByPk('FIlme', #url.Id#) >

		<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
		<cfset userCriador = dadosFilme.getId_Usuario()>
		<!--- <cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)> --->

		<!--- Habilita o modo de edição --->
		<cfif userCriador.getEmail() EQ user.getEmail()>
			<cfset editEnabled = "true">
		</cfif>
	</cfif>
</cfif>

<cftry>

	<!--- // Condicao satisfeita somente quando o formulário é enviado via POST contendo os dados do formulário --->
	<cfif isDefined('form.btnCadastrar')>
		<cfif NOT isDefined('editEnabled')>
			<cfset filmeNovo = entityNew('Filme') />
		<cfelse>
			<cfset filmeNovo = dadosFilme />
		</cfif>

		<!--- // Verifica se já existe um filme com mesmo titulo --->
		<cfif filmeNovo.filmeExists('#form.inputTitulo#') AND NOT isDefined('editEnabled')>
			<cfset tituloErro = "error" />
		<cfelse>
			<cfif NOT isDefined('editEnabled')>
				<cfset filmeNovo.setTitulo(form.inputTitulo) />
			</cfif>
			<cfset filmeNovo.setAno(form.sldrAno) />
			<cfset filmeNovo.setDuracao(form.sldrDuracao) />
			<cfset filmeNovo.setTrailer(form.inputTrailer) />
			<cfset filmeNovo.setSinopse(form.txtSinopse) />
			<cfset filmeNovo.setData_Adicao(NOW()) />
			
			<cfset user = EntityLoad("Usuario", {Email="#GetAuthUser()#"}, true)>
						
			<!---// chaves estrangeiras--->
			<cfset filmeNovo.setId_Usuario(user) /> 
			<cfset filmeNovo.setId_Genero(entityLoad("Genero", {Id_Genero="#form.dropdown_Genero#"}, true)) />
			<cfset EntitySave(filmeNovo) />
			
			<cfset ormFlush('ds_Projeto_Filme') />
			
			<!--- //writeDump(form); --->
			<!--- // Cria uma pasta com o nome do usuário --->
			<!--- ExpandPath obtem o caminho completo para a diretório do projeto na pasta de imagens --->
			<cfset basePath = ExpandPath("/Projeto_Filmes/UserData/User#user.getId_Usuario()#/") />
				<cftry>
					<!--- // realiza o upload da imagem com base no padrao de diretorio para usuario --->
					<cffile action="upload" fileField="fileData" destination="#basePath#" nameconflict="makeUnique" />
					
					<!--- Obtem o caminho completo da imagem para armazenar na base de dados --->
					<cfset imgCapaPath = "#cffile.ServerDirectory#" & "/" & "#cffile.ServerFile#">
					
					<cfif NOT isDefined('editEnabled')>
						<cfset imgCapa = EntityNew('Imagem')>
					<cfelse>
						<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = #dadosFilme#}, true) >
					</cfif>

					<cfset imgCapa.setId_Filme(filmeNovo) >
					<cfset imgCapa.setImagem_Path(#imgCapaPath#) > 
					<cfset EntitySave(imgCapa) >
					
					<!--- <cfdump var="#cffile#"> --->
					<div class='alert alert-success'>
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<h1>Sucesso!</h1>
						<cfif NOT isDefined('editEnabled')>
							<p>Filme adicionado a nossa base de filmes!</p>
						<cfelse>
							<p>Filme editado com sucesso!</p>
						</cfif>
						<cfoutput>
							<p>Clique <a href="InfoFilme.cfm?Id=#dadosFilme.getId_Filme()#">aqui</a> para visualizar e modificar as informações deste filme</p>
						</cfoutput>
					</div>
					<cfcatch type="application">
						<cfoutput><div class='alert alert-error'><h1>Erro!</h1><p>#cfcatch.message#</p></div></cfoutput>
					</cfcatch>
				</cftry>
				<cfset ormFlush('ds_Projeto_Filme') />
		</cfif>
	</cfif>		
<cfcatch>
		<cfoutput>#cfcatch.Message#</cfoutput>
		<cfdump var="#form#">
</cfcatch>
</cftry>


<!--- Verifica se o usuário esta logado para poder cadastrar o filme
	isUserLoggedin é uma função do módulo de autenticação do ColdFusion.
	Caso contrário redireciona o usuário para a pagina de cadastro --->
<cfif isUserLoggedin() >
<!-- Corpo do site  -->
    <div class="row">
    	
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
    	<div class="span10">
    		<cfform name="form" class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
			<fieldset>
				<legend>Informações Gerais</legend>
				<div class="control-group">
					<label class="control-label" for="inputTitulo">Titulo:</label>
					<div class="controls">
						<cfif isDefined('editEnabled')>
							<cfinput name="inputTitulo" type="text" required="true" class="input-xxlarge" placeholder="Titulo do filme" value="#dadosFilme.getTitulo()#" disabled="true" message="Informe o título do filme">
						<cfelse>
							<cfinput name="inputTitulo" type="text" required="true" class="input-xxlarge" placeholder="Titulo do filme" message="Informe o título do filme">
						</cfif>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="sldrAno">Ano:</label>
					<div class="controls">
						<cfoutput>
							<input name="sldrAno" type="number" step="1"  min="1900" max="#YEAR(NOW())#" required="true" message="Informe o ano de lançamento" 
								<cfif isDefined('editEnabled')>
									value="#dadosFilme.getAno()#"
								</cfif>
							>
						</cfoutput>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="sldrDuracao">Tempo de duração:</label>
					<div class="controls">
						<cfoutput>
							<input name="sldrDuracao" type="number" step="1"  min="1" max="1000" required="true"
								<cfif isDefined('editEnabled')>
									value="#dadosFilme.getDuracao()#"
								</cfif>	
							>
						</cfoutput>
					</div>
				</div>


				<div class="control-group">
					<label class="control-label" for="dropDown_Genero">Gênero</label>
					<cfquery name="getGeneros" datasource="ds_Projeto_Filmes">
						SELECT Id_Genero, Descricao FROM tbl_Genero
					</cfquery>
					<div class="controls">
						<cfselect name="dropDown_Genero" 
								  query="getGeneros"
								  value="Id_Genero"
								  display="Descricao"
								  required="true"
								  multiple="false">
						</cfselect>
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Imagens e Trailer</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Imagem de capa:</label>
					<div class="controls">
						<cfif isDefined('editEnabled')>
							<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = #dadosFilme#}, true)>
							<cfif isDefined('imgCapa')>
								<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="100" width="100">
							<cfelse>
								<img data-src="holder.js/260x160">
							</cfif>
						</cfif>
						<cfinput type="file" name="fileData">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputTrailer">Trailer:</label>
					<div class="controls">
						<cfoutput>
							<input name="inputTrailer" type="text" maxlength="100" required="true" class="input-xxlarge" placeholder="Link do filme"
								<cfif isDefined('editEnabled')>
									value="#dadosFilme.getTrailer()#"
								</cfif>
							>
						</cfoutput>
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Sinopse</legend>
				<div class="control-group">
					<cfoutput>
						<textarea name="txtSinopse" rows="5" cols="0" maxlength="300" width="300">
							<cfif isDefined('editEnabled')>
								#dadosFilme.getSinopse()#
							</cfif>
						</textarea>							
					</cfoutput>
				</div>
			</fieldset>
			<div class="form-actions">
				<button name="btnCadastrar" class="btn btn-primary" type="submit">
					<cfif isDefined('editEnabled')>
						Editar
					<cfelse>
						Cadastrar
					</cfif>
				</button>
				<button name="btnCancelar" class="btn" type="button">Cancelar</button>
			</div>
		</cfform>
    	</div>
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
