<cfcomponent name="Avaliacao" persistent="true" table="Avaliacao">
	<cfproperty name="Id_Avaliacao" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Filme" fieldtype="many-to-one" cfc="Filme" fkcolumn="Id_Filme" required="true">
	<cfproperty name="Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario" required="true">
	<cfproperty name="Nota" fieldtype="column" ormtype="int" required="true">
	<cfproperty name="Critica" fieldtype="column" ormType="string" required="true" sqlType="VARCHAR(300)">
</cfcomponent>