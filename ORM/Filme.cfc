﻿<cfcomponent entityName="Filme" persistent="true" indexable="true" autoindex="true" table="tbl_Filme">
	<cfproperty name="Id_Filme" fieldtype="id" generator="identity" type="numeric" ormtype="int" indexable="true" >
	<cfproperty name="id_Usuario" fieldtype="many-to-one" cfc="Usuario" fkcolumn="Id_Usuario">
	<cfproperty name="Id_Genero" fieldtype="many-to-one" cfc="Genero" fkcolumn="Id_Genero">
	<cfproperty name="Titulo" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string" indexable="true">
	<cfproperty name="Ano" type="numeric" sqltype="INTEGER" required="true" ormtype="int" indexable="true">
	<cfproperty name="Duracao" type="numeric" sqltype="INTEGER" required="true" ormtype="int">
	<cfproperty name="Sinopse" type="string" sqltype="VARCHAR(2000)" required="true" ormtype="string" indexable="true">
	<cfproperty name="Trailer" type="string" sqltype="VARCHAR(500)" required="FALSE" ormtype="string">
	<cfproperty name="Data_Adicao" type="date" require="true" ormtype="date"> 
	<cfproperty name="NotaMedia" type="numeric" ormType="float">
	<!--- 
	<!---Relacionamento muito para muitos --->
	<cfproperty name="Id_Usuario_Aval" 
			   	fieldtype="many-to-many" 
			   	CFC="Usuario" 
			   	linktable="Avaliacao" 
			   	FKColumn="Id_Filme" 
			   	inversejoincolumn="Id_Usuario" 
			   	lazy="true"
				cascade="all"> --->
				
				
	<!--- Métodos --->
	<cffunction name="filmeExists" hint="Fun&ccedil;&atilde;o com retorno tipo Bool que retorna TRUE se h&aacute; um filme existente" returntype="boolean">
		<cfargument name="tituloFilme" />
		
		<cfset filme = EntityLoad('Filme', {Titulo="#tituloFilme#"}) />
		<cfif arrayLen(filme) NEQ 0>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
		
	</cffunction>
	
	<cffunction name="getResenha">
	</cffunction>
</cfcomponent>