<cfif GetAuthUser() NEQ "">

	<cfparam name="form.txtAvaliacao" default="">
	<cfparam name="form.Nota" default="">

	<!--- Retorna um registro unico (true) do Filme de Id recebido pela URL --->
    <cfset filme = EntityLoad('Filme', {Id_Filme = #url.Id#}, true)>
    <cfset usuario = EntityLoad('Usuario', {Email = getAuthUser()}, true)>

	<cfset avaliacao = EntityNew('Avaliacao') >
	<cfset avaliacao.setFilme(filme)>
	<cfset avaliacao.setUsuario(usuario)>
	<cfset avaliacao.setNota(form.Nota)>
	<cfset avaliacao.setCritica(form.txtAvaliacao)>

	<cfif filme.getNotaMedia() EQ "">
		<cfset filme.setNotaMedia(0) >
		<cfset qtdAval = 1>
	<cfelse>
	</cfif>

	<!--- Calcula a media de avaliacao com a nova nota --->
	<cfset qtdAval = arrayLen(EntityLoad('Avaliacao', {Filme = #filme#})) >
	<cfset qtdAval = qtdAval + 1 >

	<cfset filme.setNotaMedia(filme.getNotaMedia() + (avaliacao.getNota() / qtdAval)) >

	<cftry>
		<cfset EntitySave(avaliacao) />

		<!--- <cfoutput>
			<div class="hero-unit">
				<p class="lead">#GetAuthUser()# em #DateFormat(Now())#</p>
				<p>Nota; #form.Nota#</p>
				<p>#form.txtAvaliacao#</p>
				<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
			</div>
		</cfoutput> --->

		<!--- Envia os dados modificados ou adicionais para a base de dados --->
		<!--- Caso esta tag não seja especificada o ColdFusion ORM atualiza automaticamente em um determinado tempo --->
		<cfflush>
	<cfcatch>
		<p>Não foi possível avaliar este filme. Tente novamente.</p>
	</cfcatch>
	</cftry>
<cfelse>
	<div class="alert warning-alert">
		<p class="alert warning-alert">Faca o login para poder dar sua opinião ou cadastre-se aqui</p>
	</div>
</cfif>
