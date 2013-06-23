<cfcomponent name="Usuario_Grupo" persistent="true" table="tbl_Usuario_Grupo">
	<cfproperty name="idUsrGrp" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Grupo" fieldtype="many-to-one" cfc="Grupo" fkcolumn="Id_Grupo" required="true">
	<cfproperty name="Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario" required="true">
	<cfproperty name="Data" ormType="date"/>
</cfcomponent>