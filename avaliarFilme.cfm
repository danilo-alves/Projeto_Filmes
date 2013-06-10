<cfif GetAuthUser() NEQ "">
	<cfoutput>
		<div class="hero-unit">
			<p class="lead">#GetAuthUser()# em #DateFormat(Now())#</p>
			<p>#form.txtAvaliacao#</p>
			<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
		</div>
	</cfoutput>
</cfif>