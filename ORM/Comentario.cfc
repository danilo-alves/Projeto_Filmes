<cfcomponent name="Comentario" persistent="true" table="tbl_Comentario">
	<cfproperty name="Id_Comentario" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario"><!--- chave estrangeira --->
	<cfproperty name="Id_Filme" fieldtype="many-to-one" cfc="Filme" fkcolumn="Id_Filme"><!--- chave estrangeira --->
	<cfproperty name="Comentario" fieldtype="column" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string">
	<cfproperty name="Data" fieldtype="column" type="date" sqltype="DATETIME" required="true" ormtype="string">
</cfcomponent>