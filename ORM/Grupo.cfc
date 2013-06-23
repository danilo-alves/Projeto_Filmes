<cfcomponent name="Grupo" persistent="true" table="tbl_Grupo" autoindex="true" indexable="true">
	<cfproperty name="Id_Grupo" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario"><!--- chave estrangeira --->
	<cfproperty name="Nome_Grupo" fieldtype="column" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string" indexable="true">
	<cfproperty name="Descricao" fieldtype="column" type="string" sqltype="VARCHAR(2000)" required="false" ormtype="string" indexable="true">
	
	<!---Relacionamento muito para muitos --->
	<!--- As chaves primária de Usuario e Grupo serão chave estrangeira da tabela Usuario_Grupo --->
	<cfproperty name="Id_Usuario_Membro" 
			   	fieldtype="many-to-many" 
			   	CFC="Usuario" 
			   	linktable="Usuario_Grupo" 
			   	FKColumn="Id_Grupo" 
			   	inversejoincolumn="Id_Usuario" 
			   	lazy="true"
				cascade="all">

	<!--- Métodos --->
	<cffunction name="grupoExiste" hint="Função com retorno tipo Bool que retorna TRUE se há um grupo existente com mesmo titulo" returntype="boolean">
		<cfargument name="tituloGrupo" />
		
		<cfset grupo = EntityLoad('Grupo', {Nome_Grupo="#tituloGrupo#"}) />
		<cfif arrayLen(grupo) NEQ 0>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
		
	</cffunction>
</cfcomponent>