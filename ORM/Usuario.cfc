component entityName="Usuario" persistent="true" table="tbl_Usuario"
{
	// Campo de identificacao que gera os Ids automaticamente
	property name="Id_cliente" fieldtype="id" generator="identity" type="numeric" ormtype="int";
	property name="Nome" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string";
	property name="Email" type="string" sqltype="VARCHAR(100)" required="true" ormtype="string";
	property name="Senha" type="string" required="true";
}