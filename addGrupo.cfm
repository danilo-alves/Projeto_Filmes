<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<cfparam name="form.inputGrupo" default="">
<cfparam name="form.fileData" default="">
<cfparam name="form.txtDescricao" default="">

<cfparam name="tituloErro" default="">

<cftry>

	<!--- // Condicao satisfeita somente quando o formulário é enviado via POST contendo os dados do formulário --->
	<cfif isDefined('form.btnCadastrar')>
		<cfset novoGrupo = entityNew('Grupo') />
		
		<!--- // Verifica se já existe um filme com mesmo titulo --->
		<cfif novoGrupo.grupoExiste('#form.inputGrupo#')>
			<cfset tituloErro = "error" />
		<cfelse>
			<cfif NOT isDefined('user')>	
				<cfset user = EntityLoad("Usuario", {Email="#GetAuthUser()#"}, true)>
			</cfif>

			<cftry>
				
				<cfset novoGrupo.setNome_Grupo(form.inputGrupo) />
				<cfset novoGrupo.setDescricao(form.txtDescricao) />
				<cfset novoGrupo.setId_Usuario(user) />
				
				<cfset EntitySave(novoGrupo) />
				
				<cfset ormFlush('ds_Projeto_Filme') />
				
				<!--- //writeDump(form); --->
				<!--- // Cria uma pasta com o nome do usuário --->
				<!--- ExpandPath obtem o caminho completo para a diretório do projeto na pasta de imagens --->
				<cfset basePath = ExpandPath("/Projeto_Filmes/UserData/User#user.getId_Usuario()#/") />
					<!--- <cftry> --->
						<!--- // realiza o upload da imagem com base no padrao de diretorio para usuario --->
						<cffile action="upload" fileField="fileData" destination="#basePath#" nameconflict="makeUnique" />
						
						<!--- Obtem o caminho completo da imagem para armazenar na base de dados --->
						<cfset imgCapaPath = "#cffile.ServerDirectory#" & "/" & "#cffile.ServerFile#">
						<cfset imgCapa = EntityNew('ImagemGrupo')>
						<cfset imgCapa.setId_Grupo(novoGrupo) >
						<cfset imgCapa.setImagem_Path(#imgCapaPath#) > 
						<cfset EntitySave(imgCapa) >
						
						<!--- <cfdump var="#cffile#"> --->
				<div class='alert alert-success'>
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h1>Sucesso!</h1>
					<p>Grupo adicionado!</p>
					<p>Clique <a href="?id_grupo=#novoGrupo.getId_Grupo()#">aqui</a> para visualizar seu grupo</p>
				</div>
				<cfset ormFlush('ds_Projeto_Filme') />

				<cfcatch type="application">
					<cfoutput>
						<div class='alert alert-error'>
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<h1>Erro!</h1>
							<p>#cfcatch.message#</p>
						</div>
					</cfoutput>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>		
<cfcatch>
		<cfoutput>#cfcatch.Message#</cfoutput>
		<!--- <cfdump var="#form#"> --->
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
					<label class="control-label" for="inputGrupo">Nome do Grupo:</label>
					<div class="controls">
						<cfinput name="inputGrupo" type="text" required="true" class="input-xxlarge" placeholder="Nome do Grupo">
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Imagem</legend>
				<div class="control-group">
					<label class="control-label" for="fileData">Imagem de capa:</label>
					<div class="controls">
						<cfinput type="file" name="fileData">
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>Descrição</legend>
				<div class="control-group">
					<cftextarea name="txtDescricao" rows="5" maxlength="300" width="300" richtext="false"></cftextarea>
				</div>
			</fieldset>
			<div class="form-actions">
				<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
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
