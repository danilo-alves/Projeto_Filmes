<cfcomponent entityName="ImagemUsuario" persistent="true" table="tbl_ImagemUsuario">
	<cfproperty name="Id_Imagem" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario">
	<cfproperty name="Imagem_Path" fieldtype="column" type="string" sqltype="VARCHAR(300)" required="true" ormtype="string">
</cfcomponent>