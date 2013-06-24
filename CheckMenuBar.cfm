<!--- Verifica se o usu&aacute;rio esta logado e oculta a barra de opcoes caso o usu&aacute;rio n&atilde;o esteja logado --->
<cfif GetAuthUser() NEQ "">
	<cfset spanNum = "span10">
	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->
<cfelse>
	<cfset spanNum = "span12">
</cfif>