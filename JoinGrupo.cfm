<cfif getAuthUser() NEQ "">		

	<!--- <cftry> --->
		
		<cfset grupo = EntityLoadByPK("Grupo", #form.id_grupo#)/>
		<cfset user = EntityLoadByPk("Usuario", #form.id_user#)/>

		<cfif isDefined('grupo') AND isDefined('user')> 
			<cfset grupoJoin = EntityNew('Usuario_Grupo') />
			<cfset grupoJoin.setGrupo(grupo) />
			<cfset grupoJoin.setUsuario(user) />
			<cfset grupoJoin.setData(Now()) />

			<cfdump var="#grupoJoin#">	

			<cfset EntitySave(grupoJoin) />

			<cfflush>

			<div class="alert alert-success">
				<p class="alert alert-success">Sucesso!</p>
			</div>	
		</cfif>
	<!--- <cfcatch>
		<div class="alert alert-error">
			<p class="alert alert-error">Erro!</p>
		</div>

	</cfcatch>
	</cftry> --->
		<cfdump var="#user#">
		<cfdump var="#grupo#">
</cfif>