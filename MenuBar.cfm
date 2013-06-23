<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
<div class="span2 muted">
	<ul class="nav nav-list nav-stacked">
		<li class="nav-header">Op&ccedil;&otilde;es</li>

		<!--- Opcoes --->
		<cfswitch expression="#CGI.script_name#">
			<cfcase value="/Projeto_Filmes/AddFilme.cfm">
				<li class="active"><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li><a href="Grupos.cfm">Grupos</a></li>
				<li><a href="#">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfcase>
			<cfcase value="/Projeto_Filmes/MinhaListaDesejo.cfm">
				<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li class="active"><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li><a href="Grupos.cfm">Grupos</a></li>
				<li><a href="MeuFilme.cfm">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfcase>
			<cfcase value="/Projeto_Filmes/MeuFilme.cfm">
				<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li class="active"><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li><a href="Grupos.cfm">Grupos</a></li>
				<li><a href="MeuFilme.cfm">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfcase>
			<cfcase value="/Projeto_Filmes/MeuPerfil.cfm">
				<li class="active"><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li><a href="Grupos.cfm">Grupos</a></li>
				<li class="active"><a href="#">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfcase>
			<cfcase value="/Projeto_Filmes/Grupos.cfm">
				<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li class="active"><a href="Grupos.cfm">Grupos</a></li>
				<li><a href="#">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfcase>
			<cfdefaultcase>
				<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
				<li><a href="MinhaListaDesejo.cfm">Lista de Desejos</a></li>
				<li><a href="MeuFilme.cfm">Meus Filmes</a></li>
				<li><a href="Grupos.cfm">Grupos</a></li>
				<li><a href="#">Meu Perfil</a></li>
				<li><a href="index.cfm#?logout">Sair</a></li>
			</cfdefaultcase>
		</cfswitch>
	</ul>
</div>