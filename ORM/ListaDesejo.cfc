<cfcomponent name="ListaDesejo" persistent="true" table="tbl_ListaDesejo">
	<cfproperty name="Id_Lista" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Filme" fieldtype="many-to-one" cfc="Filme" fkcolumn="Id_Filme" required="true">
	<cfproperty name="Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario" required="true">
</cfcomponent>