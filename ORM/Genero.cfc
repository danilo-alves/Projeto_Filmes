<cfcomponent name="Genero" persistent="true" table="tbl_Genero">
	<cfproperty name="Id_Genero" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Descricao" fieldtype="column" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string">
</cfcomponent>