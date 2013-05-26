﻿<cfcomponent entityName="Filme" persistent="true" indexable="true" autoindex="true">
	<cfproperty name="Id_Filme" fieldtype="id" generator="identity" type="numeric" ormtype="int" indexable="true" >
	<cfproperty name="Id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario">
	<cfproperty name="Id_Genero" fieldtype="many-to-one" cfc="Genero" fkcolumn="Id_Genero">
	<cfproperty name="Titulo" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string" indexable="true">
	<cfproperty name="Duracao" type="numeric" sqltype="INTEGER" required="true" ormtype="int">
	<cfproperty name="Sinopse" type="string" sqltype="VARCHAR(250)" required="true" ormtype="string">
	<cfproperty name="Trailer" type="string" sqltype="VARCHAR(250)" required="true" ormtype="string">
	
	<!---Relacionamento muito para muitos --->
	<cfproperty name="Id_Usuario_Aval" 
			   	fieldtype="many-to-many" 
			   	CFC="Usuario" 
			   	linktable="Avaliacao" 
			   	FKColumn="Id_Filme" 
			   	inversejoincolumn="Id_Usuario" 
			   	lazy="true"
				cascade="all">
</cfcomponent>