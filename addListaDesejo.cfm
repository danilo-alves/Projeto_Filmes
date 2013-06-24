<cfif GetAuthUser() NEQ "">

	<cfparam name="form.txtAvaliacao" default="">
	<cfparam name="form.Nota" default="">

	<!--- Retorna um registro unico (true) do Filme de Id recebido pela URL --->
    <cfset filme = EntityLoad('Filme', {Id_Filme = #url.Id#}, true)>
    <cfset usuario = EntityLoad('Usuario', {Email = getAuthUser()}, true)>

	<cfset listaDesejo = EntityNew('ListaDesejo') >
	<cfset listaDesejo.setFilme(filme)>
	<cfset listaDesejo.setUsuario(usuario)>

	<cftry>
		<cfset EntitySave(listaDesejo) />

		<!--- Envia os dados modificados ou adicionais para a base de dados --->
		<!--- Caso esta tag n&atilde;o seja especificada o ColdFusion ORM atualiza automaticamente em um determinado tempo --->
		<cfflush>
	<cfcatch>
		<p>N&atilde;o foi possível avaliar este filme. Tente novamente.</p>
	</cfcatch>
	</cftry>
<cfelse>
	<div class="alert warning-alert">
		<p class="alert warning-alert">Faca o login para poder dar sua opini&atilde;o ou cadastre-se aqui</p>
	</div>
</cfif>
