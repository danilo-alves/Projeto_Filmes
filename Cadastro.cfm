<cfinclude template="Header.cfm">

<!---Se os avalores não estiverem definidos, define com uma strign vazia --->
<cfparam name="form.inputNome" default="">
<cfparam name="form.inputEmail" default="">
<cfparam name="form.unputSenha" default="">

<cfscript>
	try {
		if (isDefined('form.btnCadastrar'))
		{
			novoUsuario = entityNew('Usuario');
			novoUsuario.setNOME(form.inputNome);
			novoUsuario.setEMAIL(form.inputEmail);
			novoUsuario.setSENHA(form.inputSenha);
			
			entitySave(novoUsuario);
			
			aviso = "<div class='alert alert-success'><h3>Sucesso!</h1><p>#form.inputNome# foi criado com sucesso</p></div>"; 
			
			// Cria uma pasta com o nome do usuário
			basePath = ExpandPath("./");
			newDirectory = "#form.inputNome#";
			newDirectoryPath =  "#basePath#" & "#newDirectory#";
			if(NOT DirectoryExists(newDirectoryPath))
			{
				try {
					DirectoryCreate(newDirectoryPath);
					/*FileCopy('#basePath#index_sample.cfm', '#newDirectoryPath#/index.cfm');*/
				}
				catch(Exception ex) {
					WriteOutput("<div class='alert alert-error'><h1>Erro!</h1><p>#ex.message#</p></div>");
					abort;
				}

				// Redirecionar para a pagina de Filmes a adicionar
				//location(url="index.cfm");
			}
		}
		
		// Pede para os dados do objeto criado serem atualizados no banco
		ormflush("ds_Projeto_Filmes");
	}
	catch(Exception ex) {
		WriteOutput("<div class='alert alert-error'><h1>Erro!</h1><p>#ex.message#</p></div>");
	} 
	
</cfscript>

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
		<cfform class="form-horizontal" action="" method="POST">
			<fieldset>
				<legend>Informações para Cadastro</legend>
				<div class="control-group">
					<label class="control-label" for="inputNome">Nome</label>
					<div class="controls">
						<cfinput name="inputNome" type="text" required="true" class="input-xlarge" placeholder="Informe seu nome completo">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">Email</label>
					<div class="controls">
						<cfinput name="inputEmail" type="email" required="true" class="input-large" placeholder="Informe seu email">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputSenha">Senha</label>
					<div class="controls">
						<cfinput name="inputSenha" type="password" required="true" class="input-medium" placeholder="Senha">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputSenha2">Senha (novamente)</label>
					<div class="controls">
						<cfinput name="inputSenha2" type="password" required="true" class="input-medium" placeholder="Repita a Senha">
					</div>
				</div>
				<div class="form-actions">
					<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
					<button name="btnCancelar" class="btn" type="button">Cancelar</button>
				</div>
			</fieldset>
		</cfform>
	</div>
</div>


<cfinclude template="Footer.cfm">
