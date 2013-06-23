<cfif getAuthUser() NEQ "">		

	<!--- <cftry> --->
		
		<cfset grupo = EntityLoadByPK("Grupo", #form.id_grupo#)/>
		<cfset user = EntityLoadByPk("Usuario", #form.id_user#)/>

		<cfif isDefined('grupo') AND isDefined('user') AND isDefined('url.join')>

			<!--- Caso o valor passado seja 1, adiciona ao grupo, caso contrário remove o usuario do grupo --->
			<cfif #url.join# EQ 1>
				<cfset grupoJoin = EntityNew('Usuario_Grupo') />
				<cfset grupoJoin.setGrupo(grupo) />
				<cfset grupoJoin.setUsuario(user) />
				<cfset grupoJoin.setData(Now()) />

				<!--- <cfdump var="#form#"> --->	

				<cfset EntitySave(grupoJoin) />

				<cfflush>

				<div class="alert alert-success">
					<a class="close" data-dismiss="alert" href="#">&times;</a>
					<cfoutput>
						<h5 class="alert-success">Novo grupo adicionado!</h5>
						<p class="alert-success">Bem-Vindo! Voc&ecirc; agora faz parte do grupo '#grupo.getNome_Grupo()#'</p>
						<a class="btn btn-success" href="InfoGrupo.cfm?Id=#grupo.getId_Grupo()#">Conhe&ccedil;a outros membros!</a>
					</cfoutput>
				</div>	

			<cfelse>
				<!--- verifica se o usuário não é o criador do grupo --->
				<cfif #grupo.getId_Usuario().getId_Usuario()# NEQ #user.getId_Usuario()#>
					
					<!--- obtem os registro com o usuario e grupo definidos --->
					<cfset vinculoGrupo = EntityLoad('Usuario_Grupo', {Usuario = #user#, Grupo = #grupo#}, true)>
					<!--- <cfdump var="#vinculoGrupo#"> --->

					<!--- remove os registros --->
					<cfset EntityDelete(vinculoGrupo)>

					<div class="alert alert-error">
						<a class="close" data-dismiss="alert" href="#">&times;</a>
						<cfoutput>
							<h5 class="alert-error">Remo&ccedil;&atilde;o efetuada!</h5>
							<p class="alert-error">Voc&ecirc; n&atilde;o faz mais parte deste grupo!</p>
						</cfoutput>
					</div>
				<cfelse>
					<div class="alert alert-error">
						<a class="close" data-dismiss="alert" href="#">&times;</a>
						<cfoutput>
							<h5 class="alert-error">Imposs&iacute;vel remover!</h5>
							<p class="alert-error">Voc&ecirc; &eacute; o criador deste grupo!</p>
						</cfoutput>
					</div>
				</cfif>
			</cfif> 
		<cfelse>
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">&times;</a>
				<cfoutput>
					<h5 class="alert-error">Erro ao adicionar-se ao grupo!</h5>
					<p class="alert-error">Não foi poss&iacute;vel adicionar-se ao grupo '#grupo.getNome_Grupo()#'. Tente novamente!</p>
				</cfoutput>
			</div>				
		</cfif>
		
		<!--- <cflocation url="Grupos.cfm"> --->
	<!--- <cfcatch>
		<div class="alert alert-error">
			<p class="alert alert-error">Erro!</p>
		</div>

	</cfcatch>
	</cftry> --->
</cfif>