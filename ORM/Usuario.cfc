<cfcomponent entityName="Usuario" persistent="true" table="tbl_Usuario">
	<!---// Campo de identificacao que gera os Ids automaticamente--->
	<cfproperty name="Id_Usuario" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Nome" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string">
 	<cfproperty name="Email" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string" unique="true">
	<cfproperty name="Senha" type="string" required="true">
	<cfproperty name="Descricao" type="string" required="false" sqltype="VARCHAR(2000)">
	<!---Relacionamento muito para muitos --->
	<!--- As chaves primária de Usuario e Grupo serão chave estrangeira da tabela Usuario_Grupo --->
	<!--- <cfproperty name="Id_Grupo" 
			   	fieldtype="many-to-many" 
			   	CFC="Grupo" 
			   	linktable="Usuario_Grupo" 
			   	FKColumn="Id_Usuario" 
			   	inversejoincolumn="Id_Grupo" 
			   	lazy="true"
				cascade="all">
				
	Relacionamento muito para muitos 
	<cfproperty name="Id_Filme_Aval" 
			   	fieldtype="many-to-many" 
			   	CFC="Filme" 
			   	linktable="Avaliacao" 
			   	FKColumn="Id_Usuario" 
			   	inversejoincolumn="Id_Filme" 
			   	lazy="true"
				cascade="all">
 --->

	<!--- Obtem os filmes criados pelo usuário --->
	<cffunction name="getFilmeByUser">
		<cfargument name="userSearch"/>

		<cfif NOT isDefined('userSearch') OR userSearch EQ NULL>
			<cfset userSearch = this/>
		</cfif>
		<cfset meusFilmes = EntityLoad('Filme', {Id_Usuario = #userSearch#}) />
		<cfreturn #meusFilmes#>
	</cffunction>

	<cffunction name="getListaFilmes">
		<cfargument name="userSearch"/>

		<!--- Caso não seja especificado nenhum arametro utiliza o usuário logado  --->
		<cfif NOT isDefined('userSearch') OR userSearch EQ NULL>
			<cfset userSearch = this/>
		</cfif>
		
		<cfset listaFilmes = EntityLoad('ListaDesejo', {Usuario = #userSearch#}) />
		<cfreturn #listaFilmes#>
	</cffunction>
</cfcomponent>