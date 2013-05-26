<cfcomponent name="Resenha" persistent="true" table="tbl_Resenha">
	<cfproperty name="Id_Resenha" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Id_Filme" fieldtype="many-to-one" cfc="Filme" fkcolumn="Id_Filme">
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario">
	<cfproperty name="Conteudo" fieldtype="column" type="string" sqltype="VARCHAR(300)" required="true" ormtype="string">
</cfcomponent>