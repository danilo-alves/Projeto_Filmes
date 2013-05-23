<cfcomponent name="Resenha" persistent="true" table="tbl_Resenha">
	<cfproperty name="Id_Resenha" fieldtype="id" generator="identity" type="numeric" ormtype="int">
	<cfproperty name="Conteudo" fieldtype="column" type="string" sqltype="VARCHAR(300)" required="true" ormtype="string">
</cfcomponent>