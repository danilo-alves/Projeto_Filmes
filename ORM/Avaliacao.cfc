<cfcomponent name="Avaliacao" persistent="true" table="Avaliacao">
	<cfproperty name="Id_Avaliacao" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Nota" fieldtype="column" ormtype="int" required="true">
</cfcomponent>