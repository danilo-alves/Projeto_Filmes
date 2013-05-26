<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
    	<div class="span10">
    		<cfform class="form-horizontal" action="" method="POST">
			<fieldset>
				<legend>Informações Gerais</legend>
				<div class="control-group">
					<label class="control-label" for="inputTitulo">Titulo:</label>
					<div class="controls">
						<cfinput name="inputTitulo" type="text" required="true" class="input-xxlarge" placeholder="Titulo do filme">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="sldrAno">Ano:</label>
					<div class="controls">
						<cfslider name="sldrAno" range="1900, 2013" format="html" increment="1" width="300">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputDuracao">Tempo de duração:</label>
					<div class="controls">
						<cfslider name="sldrDuracao" range="0, 200" format="html" increment="1" width="300">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="inputE">Gênero</label>
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
				<legend>Sinopse</legend>
				<div class="control-group">
						<cftextarea name="txtSinopse" rows="5" maxlength="300" width="300" richtext="false"></cftextarea>
				</div>
			</fieldset>
			<fieldset>
				<legend>Imagens e Trailer</legend>
				<div class="control-group">
					<label class="control-label" for="imgCapa">Imagem de capa:</label>
					<div class="controls">
						<cfinput type="file" name="imgCapa">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="imgCapa">Trailer:</label>
					<div class="controls">
						<cfinput name="inputTrailer" type="text" maxlength="100" required="true" class="input-xxlarge" placeholder="Link do filme">
					</div>
				</div>
			</fieldset>
			<div class="form-actions">
				<button name="btnCadastrar" class="btn btn-primary" type="submit">Cadastrar</button>
				<button name="btnCancelar" class="btn" type="button">Cancelar</button>
			</div>
		</cfform>
    	</div>
    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">
