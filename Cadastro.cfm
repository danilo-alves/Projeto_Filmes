<cfinclude template="Header.cfm">

<!---Se os avalores não estiverem definidos, define com uma strign vazia --->
<cfparam name="form.inputNome" default="">
<cfparam name="form.inputEmail" default="">
<cfparam name="form.inputSenha" default="">
<cfparam name="form.fileData" default="">

<!--- Avisos para os campso do formulário --->
<cfparam name="emailError" default="">
<cfparam name="passwordError" default="">


<cftry>
	<cfif (isDefined('form.btnCadastrar')) >
		<cfset emailUser = entityLoad('Usuario', {Email="#form.inputEmail#"}) />
		
		<!--- // Verifica se ja existe um email cadastrado igual ao informado  --->
		<cfif(arrayLen(emailUser) NEQ 0) >
			<cfset emailError="error" >
		<cfelse>
			<!--- // Verifica se ambas as senhas são iguais --->
			<cfif(form.inputSenha NEQ form.inputSenha2) >
				<cfset passwordError="error" />
			<cfelse>
				<cfset novoUsuario = entityNew('Usuario') />
				<cfset novoUsuario.setNOME(form.inputNome) />
				<cfset novoUsuario.setEMAIL(form.inputEmail) />
				<!--- /* Guarda a senha criptografa com SHA-1 */ --->
				<cfset novoUsuario.setSENHA(HASH(form.inputSenha, "SHA-1")) />
				
				<cfset entitySave(novoUsuario) />

				<!--- // obtem o id do novo usuário para utilizar na criaçao do diretório --->
				<cfset userId = novoUsuario.getId_Usuario() />
				
				
				<!--- // Cria uma pasta com o nome do usuário --->
				<cfset basePath = ExpandPath("./UserData/") />
				<cfset newDirectory = "USER#userID#" />
				<cfset newDirectoryPath =  "#basePath#" & "#newDirectory#" />
				<cfif(NOT DirectoryExists(newDirectoryPath)) >
					<cftry>
						<cfset DirectoryCreate(newDirectoryPath) />
						
						<cfset basePath = ExpandPath("/Projeto_Filmes/UserData/User#novoUsuario.getId_Usuario()#/") />
						
						<!--- // realiza o upload da imagem com base no padrao de diretorio para usuario --->
						<cffile action="upload" fileField="fileData" destination="#basePath#" nameconflict="makeUnique" />
						
						<!--- Obtem o caminho completo da imagem para armazenar na base de dados --->
						<cfset imgCapaPath = "#cffile.ServerDirectory#" & "/" & "#cffile.ServerFile#">
						<cfset imgCapa = EntityNew('ImagemUsuario')>
						<cfset imgCapa.setId_Usuario(novoUsuario) >
						<cfset imgCapa.setImagem_Path(#imgCapaPath#) > 
						<cfset EntitySave(imgCapa) >

						<cfflush>
						
						<cfset aviso = "<div class='alert alert-success'><h3>Sucesso!</h3><p>#form.inputNome# foi criado com sucesso</p></div>" />
					<cfcatch>
						<cfset WriteOutput("<div class='alert alert-error'><h1>Erro!</h1><p>#ex.message#</p></div>") />
						<cfabort>
					</cfcatch>
					</cftry>
					<!--- // Redirecionar para a pagina de Filmes a adicionar --->
					<!--- //location(url="index.cfm"); --->
					

					<!--- // verifca se ha uma pagina anterior definida pelo GET para redimensionar apos o cadastro ser efetuado  --->
					<cfif isDefined('url.prevPage') >
						<cfset location(url="#url.prevPage#") />
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	
	<!--- // Pede para os dados do objeto criado serem atualizados no banco --->
	<cfflush>

<cfcatch>
	<cfoutput><div class='alert alert-error'><h1>Erro!</h1><p>Erro ao cadastrar. Tente novamente!</p></div></cfoutput>
</cfcatch>
</cftry>

<cfif isDefined('aviso')>
	<cfoutput>
			#aviso#
	</cfoutput>	
</cfif>

<div class="row">
	<div class="span8">
		<p class="lead">Cadastre-se e adicione filmes e conteúdos sobre seus filmes favoritos.</p>
	</div>
	<div class="span8">
		<cfform class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
			<fieldset>
				<legend>Informações para Cadastro</legend>
				<div class="control-group">
					<label class="control-label" for="inputNome">Nome</label>
					<div class="controls">
						<cfinput name="inputNome" type="text" required="true" class="input-xlarge" placeholder="Informe seu nome completo">
					</div>
				</div>
				<cfoutput><div id="emailInput" class="control-group #emailError#"></cfoutput>
					<label class="control-label" for="inputEmail">Email</label>
					<div class="controls">
						<cfinput name="inputEmail" type="email" required="true" class="input-large" placeholder="Informe seu email" message="Email já existente">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputSenha">Senha</label>
					<div class="controls">
						<cfinput name="inputSenha" type="password" required="true" class="input-medium" placeholder="Senha">
					</div>
				</div>
				<cfoutput><div class="control-group #passwordError#"></cfoutput>
					<label class="control-label" for="inputSenha2">Senha (novamente)</label>
					<div class="controls">
						<cfinput name="inputSenha2" type="password" required="true" class="input-medium" placeholder="Repita a Senha">
					</div>
				</div>
			<fieldset>
				<legend>Imagem</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Imagem do perfil:</label>
					<div class="controls">
						<cfinput type="file" name="fileData" required="true">
					</div>
				</div>
			</fieldset>
				<div class="form-actions">
					<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
					<button name="btnCancelar" class="btn" type="button">Cancelar</button>
				</div>
			</fieldset>
		</cfform>
	</div>
</div>


<cfinclude template="Footer.cfm">
