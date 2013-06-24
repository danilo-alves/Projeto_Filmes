<cfinclude template="Header.cfm">

<!---Se os avalores n&atilde;o estiverem definidos, define com uma strign vazia --->
<cfparam name="form.inputNome" default="">
<cfparam name="form.inputEmail" default="">
<cfparam name="form.inputSenha" default="">
<cfparam name="form.inputSenha2" default="">
<cfparam name="form.fileData" default="">
<cfparam name="form.txtDesc" default="">

<!--- Avisos para os campso do formul&aacute;rio --->
<cfparam name="emailError" default="">
<cfparam name="passwordError" default="">

<cfif isUserLoggedin()>
	<cfif isDefined('url.Id')>
		<cfset userUpd = EntityLoadByPK('Usuario', #url.Id#) >

		<!--- Habilita o modo de edi&ccedil;&atilde;o --->
		<cfif userUpd.getEmail() EQ user.getEmail()>
			<cfset editEnabled = "true">
		<cfelse>
			<cfset editEnabled = "false">
		</cfif>
	</cfif>
</cfif>


<!--- <cftry> --->
	<cfif (isDefined('form.btnCadastrar')) >

		<cfset emailUser = entityLoad('Usuario', {Email="#form.inputEmail#"}) />
		
		<!--- // Verifica se ja existe um email cadastrado igual ao informado  --->
		<cfif(arrayLen(emailUser) NEQ 0) AND NOT isDefined('editEnabled')>
			<cfset emailError="error" >
		<cfelse>
			<!--- // Verifica se ambas as senhas s&atilde;o iguais --->
			<cfif(form.inputSenha NEQ form.inputSenha2) >
				<cfset passwordError="error"/>
			<cfelse>
				<cfif NOT isDefined('editEnabled')>
					<cfset novoUsuario = entityNew('Usuario') />
					<cfset novoUsuario.setEMAIL(form.inputEmail) />
					<!--- /* Guarda a senha criptografa com SHA-1 */ --->
					<cfset novoUsuario.setSENHA(HASH(form.inputSenha, "SHA-1")) />
				<cfelse>
					<cfset novoUsuario = user />
				</cfif>

				<cfset novoUsuario.setNOME(form.inputNome) />
				<cfset novoUsuario.setDescricao(form.txtDesc) />
				
				<cfset entitySave(novoUsuario) />

				<!--- // obtem o id do novo usu&aacute;rio para utilizar na cria&ccedil;ao do diretório --->
				<cfset userId = novoUsuario.getId_Usuario() />
				
				<cfif NOT isDefined('editEnabled')>
					<!--- // Cria uma pasta com o nome do usu&aacute;rio --->
					<cfset basePath = ExpandPath("./UserData/") />
					<cfset newDirectory = "USER#novoUsuario.getId_Usuario()#" />
					<cfset newDirectoryPath =  "#basePath#" & "#newDirectory#" />
					<cfif(NOT DirectoryExists(newDirectoryPath)) >
						<cftry>
							<cfset DirectoryCreate(newDirectoryPath) />
							
						<cfcatch>
							<cfset WriteOutput("<div class='alert alert-error'><h1>Erro!</h1><p>#ex.message#</p></div>") />
							<cfabort>
						</cfcatch>
						</cftry>
					</cfif>
				</cfif>

				<cfset basePath = ExpandPath("/Projeto_Filmes/UserData/User#novoUsuario.getId_Usuario()#/") />
				<!--- // realiza o upload da imagem com base no padrao de diretorio para usuario --->
				<cffile action="upload" fileField="fileData" destination="#basePath#" nameconflict="makeUnique" />
				
				<!--- Obtem o caminho completo da imagem para armazenar na base de dados --->
				<cfset imgCapaPath = "#cffile.ServerDirectory#" & "/" & "#cffile.ServerFile#">
				<cfif NOT isDefined('editEnabled')>
					<cfset imgCapa = EntityNew('ImagemUsuario')>
				<cfelse>
					<cfset imgCapa = EntityLoad('ImagemUsuario', {Id_Usuario = #novoUsuario#}, true) >
				</cfif>
				<cfset imgCapa.setId_Usuario(novoUsuario) >
				<cfset imgCapa.setImagem_Path(#imgCapaPath#) > 
				<cfset EntitySave(imgCapa) >

				<cfflush>
				
				<cfset aviso = "<div class='alert alert-success'><h3>Sucesso!</h3><p>#form.inputNome# foi criado com sucesso</p></div>" />
				<!--- // Redirecionar para a pagina de Filmes a adicionar --->
				<!--- //location(url="index.cfm"); --->
					
				<!--- // verifca se ha uma pagina anterior definida pelo GET para redimensionar apos o cadastro ser efetuado  --->
				// <cfif isDefined('url.prevPage') >
					<cfset location(url="index.cfm") />
				<!--- </cfif> --->
			</cfif>
		</cfif>
	</cfif>
	
	<!--- // Pede para os dados do objeto criado serem atualizados no banco --->
	<cfflush>

<!--- <cfcatch>
	<cfoutput><div class='alert alert-error'><h1>Erro!</h1><p>Erro ao cadastrar. Tente novamente!</p></div></cfoutput>
</cfcatch>
</cftry> --->

<cfif isDefined('aviso')>
	<cfoutput>
			#aviso#
	</cfoutput>	
</cfif>

<div class="row">
	<cfif NOT isDefined('editEnabled')>
		<div class="span8">
			<p class="lead">Cadastre-se e adicione filmes e conteúdos sobre seus filmes favoritos.</p>
		</div>
	</cfif>
	<div class="span8">
		<cfoutput>
		<cfform class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
			<fieldset>
				<legend>Informa&ccedil;ões para Cadastro</legend>
				<div class="control-group">
					<label class="control-label" for="inputNome">Nome</label>
					<div class="controls">
						<cfif NOT isDefined('editEnabled')>
							<cfinput name="inputNome" type="text" required="true" class="input-xxlarge" placeholder="Informe seu nome completo">
						<cfelse>
							<cfinput name="inputNome" type="text" required="true" class="input-xxlarge" placeholder="Informe seu nome completo" value="#user.getNome()#">
						</cfif>
					</div>
				</div>
				<cfoutput><div id="emailInput" class="control-group #emailError#"></cfoutput>
					<label class="control-label" for="inputEmail">Email</label>
					<div class="controls">
						<cfif NOT isDefined('editEnabled')>
							<cfinput name="inputEmail" type="email" required="true" class="input-xlarge" placeholder="Informe seu email" message="Informe um email v&aacute;lido">
						<cfelse>
							<cfinput name="inputEmail" type="email" required="true" class="input-xlarge" placeholder="Informe seu email" message="Informe um email v&aacute;lido" value="#user.getEmail()#" disabled="true">
						</cfif>
					</div>
				</div>
				<cfif NOT isDefined('editEnabled')>
					<div class="control-group">
						<label class="control-label" for="inputSenha">Senha</label>
						<div class="controls">
							<cfinput name="inputSenha" type="password" required="true" class="input-medium" placeholder="Senha" message="Informe uma senha valida.">
						</div>
					</div>
					<cfoutput><div class="control-group #passwordError#"></cfoutput>
						<label class="control-label" for="inputSenha2">Senha (novamente)</label>
						<div class="controls">
							<cfinput name="inputSenha2" type="password" required="true" class="input-medium" placeholder="Repita a Senha"  message="Informe uma senha correspondente">
						</div>
					</div>
				</cfif>
			<fieldset>
				<legend>Imagem</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Imagem do perfil:</label>
					<div class="controls">
						<cfinput type="file" name="fileData" required="true" message="Adicione uma imagem para o seu perfil">
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Sobre voc&ecirc;</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Descri&ccedil;&atilde;o:</label>
					<div class="controls">
						<textarea name="txtDesc" rows="5" cols="0" maxlength="300" width="300">
							<cfif isDefined('editEnabled')>
								#user.getDescricao()#
							</cfif>
						</textarea>	
					</div>
				</div>
			</fieldset>
				<div class="form-actions">
					<cfif NOT isDefined('editEnabled')>
						<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
					<cfelse>
						<button name="btnCadastrar" class="btn btn-warning" type="submit">Editar</button>
					</cfif>
					<a href="index.cfm" class="btn">Cancelar</a>
				</div>
			</fieldset>
		</cfform>
		</cfoutput>
	</div>
</div>


<cfinclude template="Footer.cfm">
