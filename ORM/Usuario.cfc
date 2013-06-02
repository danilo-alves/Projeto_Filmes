<cfcomponent entityName="Usuario" persistent="true" table="tbl_Usuario">
	<!---// Campo de identificacao que gera os Ids automaticamente--->
	<cfproperty name="Id_Usuario" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Nome" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string">
 	<cfproperty name="Email" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string" unique="true">
	<cfproperty name="Senha" type="string" required="true">
	
	<!---Relacionamento muito para muitos --->
	<!--- As chaves primária de Usuario e Grupo serão chave estrangeira da tabela Usuario_Grupo --->
	<cfproperty name="Id_Grupo" 
			   	fieldtype="many-to-many" 
			   	CFC="Grupo" 
			   	linktable="Usuario_Grupo" 
			   	FKColumn="Id_Usuario" 
			   	inversejoincolumn="Id_Grupo" 
			   	lazy="true"
				cascade="all">
				
	<!---Relacionamento muito para muitos --->
	<cfproperty name="Id_Filme_Aval" 
			   	fieldtype="many-to-many" 
			   	CFC="Filme" 
			   	linktable="Avaliacao" 
			   	FKColumn="Id_Usuario" 
			   	inversejoincolumn="Id_Filme" 
			   	lazy="true"
				cascade="all">
</cfcomponent>