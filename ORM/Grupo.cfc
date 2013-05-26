<cfcomponent name="Grupo" persistent="true" table="tbl_Grupo">
	<cfproperty name="Id_Grupo" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario"><!--- chave estrangeira --->
	<cfproperty name="Nome_Grupo" fieldtype="column" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string">
	<cfproperty name="Descricao" fieldtype="column" type="string" sqltype="VARCHAR(250)" required="false" ormtype="string">
	
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
</cfcomponent>