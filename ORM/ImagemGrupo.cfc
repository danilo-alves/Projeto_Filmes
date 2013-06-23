<cfcomponent entityName="ImagemGrupo" persistent="true" table="tbl_ImagemGrupo">
	<cfproperty name="Id_Imagem" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Grupo" fieldtype="many-to-one" cfc="Grupo" fkcolumn="Id_Grupo">
	<cfproperty name="Imagem_Path" fieldtype="column" type="string" sqltype="VARCHAR(300)" required="true" ormtype="string">
</cfcomponent>