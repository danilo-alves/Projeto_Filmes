﻿<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
<div class="span2 muted">
	<ul class="nav nav-list nav-stacked">
		<li class="nav-header">Op&ccedil;&otilde;es</li>
		
		<cfset userId = #user.getId_Usuario()#>

		<cfoutput>
			<!--- Opcoes --->
			<cfif isUserInRole("admin")>
				<cfswitch expression="#CGI.script_name#">
					<cfcase value="/Projeto_Filmes/AddFilme.cfm">
						<li class="active"><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/MinhaListaDesejo.cfm">
						<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li class="active"><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfPerfilUsuario.cfm">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/MeuFilme.cfm">
						<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li class="active"><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfPerfilUsuario.cfm">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/PerfilUsuario.cfm">
						<li class="active"><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li class="active"><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/Grupos.cfm">
						<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li class="active"><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/addGrupo.cfm">
						<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li class="active"><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfdefaultcase>
						<li><a href="AddFilme.cfm">Adicionar Filme</a></li>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfdefaultcase>
				</cfswitch>
			<cfelse>
				<cfswitch expression="#CGI.script_name#">
					<cfcase value="/Projeto_Filmes/AddGrupo.cfm">
						<li class="active"><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/MinhaListaDesejo.cfm">
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li class="active"><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/MeuFilme.cfm">
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li class="active"><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/PerfilUsuario.cfm">
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li class="active"><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfcase value="/Projeto_Filmes/Grupos.cfm">
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li class="active"><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfcase>
					<cfdefaultcase>
						<li><a href="AddGrupo.cfm">Adicionar Grupo</a></li>
						<li><a href="MinhaListaDesejo.cfm?Id=#userId#">Lista de Desejos</a></li>
						<li><a href="MeuFilme.cfm?Id=#userId#">Meus Filmes</a></li>
						<li><a href="Grupos.cfm">Meus Grupos</a></li>
						<li><a href="PerfilUsuario.cfm?Id=#userId#">Meu Perfil</a></li>
						<li><a href="index.cfm?logout">Sair</a></li>
					</cfdefaultcase>
				</cfswitch>
			</cfif>
		</cfoutput>
	</ul>
</div>