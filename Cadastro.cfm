﻿<cfinclude template="Header.cfm">

<!---Se os avalores não estiverem definidos, define com uma strign vazia --->
<cfparam name="form.inputNome" default="">
<cfparam name="form.inputEmail" default="">
<cfparam name="form.unputSenha" default="">

<!--- Avisos para os campso do formulário --->
<cfparam name="emailError" default="">
<cfparam name="passwordError" default="">

<cfscript>
	try {
		if (isDefined('form.btnCadastrar'))
		{
			emailUser = entityLoad('Usuario', {Email="#form.inputEmail#"});
			
			// Verifica se ja existe um email cadastrado igual ao informado 
			if(arrayLen(emailUser) NEQ 0){
				emailError="error";
			}
			else{
				// Verifica se ambas as senhas são iguais
				if(form.inputSenha NEQ form.inputSenha2){
					passwordError="error";
				}
				else{
					novoUsuario = entityNew('Usuario');
					novoUsuario.setNOME(form.inputNome);
					novoUsuario.setEMAIL(form.inputEmail);
					/* Guarda a senha criptografa com SHA-1 */
					novoUsuario.setSENHA(HASH(form.inputSenha, "SHA-1"));
					
					entitySave(novoUsuario);
					// obtem o id do novo usuário para utilizar na criaçao do diretório
					userId = novoUsuario.getId_Usuario();
					
					aviso = "<div class='alert alert-success'><h3>Sucesso!</h3><p>#form.inputNome# foi criado com sucesso</p></div>"; 
					
					// Cria uma pasta com o nome do usuário
					basePath = ExpandPath("./UserData/");
					newDirectory = "USER#userID#";
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
						
						// verifca se ha uma pagina anterior definida pelo GET para redimensionar apos o cadastro ser efetuado 
						if(isDefined('url.prevPage')){
							location(url="#url['prevPage']#"); 
						}
					}
				}
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
				<div class="form-actions">
					<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
					<button name="btnCancelar" class="btn" type="button">Cancelar</button>
				</div>
			</fieldset>
		</cfform>
	</div>
</div>


<cfinclude template="Footer.cfm">
