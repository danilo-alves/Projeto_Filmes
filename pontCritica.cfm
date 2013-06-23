<!--- <cfif getAuthUser() NEQ ""> --->
	<cfif isDefined('form.id')>
		<cfset aval = EntityLoadByPk('Avaliacao', #form.id#)>
		
		<cfif #aval.getPontuacao()# EQ "">
			<cfset aval.setPontuacao(0)>
		</cfif>

		<cfif #url.pont# EQ 1>
			<cfset aval.setPontuacao(aval.getPontuacao() + 1)>
		<cfelse>
			<cfset aval.setPontuacao(aval.getPontuacao() - 1)>
		</cfif>

		<!--- Atualiza o registro --->
		<cfset EntitySave(aval) >
		<cfflush>

		<!--- Imprime o id da avaliacao para ser utilizada na funcao de callback do javascript --->
		<cfoutput>#aval.getId_Avaliacao()#</cfoutput>
	</cfif>
<!--- <cfelse>
	<cfoutput>Cadastre-se para poder pontuar!</cfoutput> --->
<!--- </cfif> --->