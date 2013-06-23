<!--- Verifica se o usuário esta logado e oculta a barra de opcoes caso o usuário não esteja logado --->
<cfif GetAuthUser() NEQ "">
	<cfset spanNum = "span10">
	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
<cfelse>
	<cfset spanNum = "span12">
</cfif>