<cfcomponent entityName="Imagem" persistent="true" table="tbl_Imagem">
	<cfproperty name="Id_Imagem" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Filme" fieldtype="many-to-one" cfc="Filme" fkcolumn="Id_Filme">
	<cfproperty name="Imagem_Path" fieldtype="column" type="string" sqltype="VARCHAR(300)" required="true" ormtype="string">
</cfcomponent>