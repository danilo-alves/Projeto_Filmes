<!--- O arquivo Application é onde devem ser feitas configurações e implementados eventos executados em determinadas situações
como OnRequestStart(), OnSessionStart() --->
<!---Este site mostra alguns eventos e também é uma boa fonte de consulta  <http://www.bennadel.com/blog/726-ColdFusion-Application-cfc-Tutorial-And-Application-cfc-Reference.htm> --->
<cfcomponent>
	<!--- Nome da aplicação--->
	<cfset this.name="Filmes">
	
	<!---// Habilita o Object-Relational Mapping que converte as classes definidas como persistent="true"
	// em tabelas relacionais --->
	<cfset this.ormenabled="true">
	
	<!---// Datasource de acesso ao banco de dados
	// Criar em http://localhost:8500/CFIDE/administrator/index.cfm 
	// na seção 'Data Sources'--->
	<cfset this.datasource="ds_Projeto_Filmes">
	
	<!---// Configuração que indica que qualquer estrutura do banco 
	// quando modifcada nos arquivos cfc atualiza no banco de dados--->
	<cfset this.ormSettings.dbcreate = "update">
	<cfset this.ormSettings.searchEnabled = "true">
	<cfset this.ormSettings.Search.autoindex = "true">
	<cfset this.ormSettings.indexdir = getDirectoryFromPath(getCurrentTemplatePath())&"/ormindex">
	<cfset this.ormSettings.search.language = "Portuguese">
	
	<!---Métodos --->
	<!---Método executado a cada nova requisição de página  --->
	<cffunction name="OnRequestStart">
		<cfargument name="request" required="true">
		
		<cfif IsDefined("url.logout")> 
	        <cflogout> 
	    </cfif> 
	 
	 	<!--- Container para  autenticação do usuário, obtem cflogin.name automaticamente por meio do campo de texto j_username
		 	e a cflogin.password por meio de j_password --->
	    <cflogin> 
	        <cfif IsDefined("cflogin")>  
	            <cfif cflogin.name IS "" OR cflogin.password IS ""> 
	                
					<cfoutput><div class="alert alert-block span5 offset3"> 
	                    <h4>Oh Shit!</h4>
						Digite todos os dados requeridos. 
	                     </div>
	                </cfoutput> 
	                <!---<cfabort>---> 
	            <cfelse> 
					<!--- Criptgrafa a senha para comparação --->
					<cfset senhaCripto=HASH(cflogin.password, "SHA-1")>
					
	                <!--- Busca na tabela Usuario um usuario com os dados fornecidos em j_username e com senha j_password --->
	                <cfset loginUserData = entityLoad('Usuario', {Email='#cflogin.name#', Senha="#senhaCripto#"})>
					
					<!--- Verifica se houve algum registro retornado --->
	                <cfif arraylen(loginUserData) NEQ 0> 
						
						<!--- Se foi o admin aplica as roles adequadas senão considera como usuario comum --->
						<cfif cflogin.name EQ "admin">
							<cfset roles="admin">
						<cfelse>
							<cfset roles="user">
						</cfif>
						
						<!--- Autentica o usuário logado --->
	                    <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" roles="#roles#"> 
						<!---<cflocation url="home.cfm" addToken="yes"> -> Usar caso for redirecionar para outra pagina. 'Meu Perfil' por exemplo--->
	                <cfelse>
						<cfoutput>
							<div class="alert alert-error span12">
								<button type="button" class="close" data-dismiss="alert">&times;</button> 
		                    	<h4>Erro</h4>
								Dados incorretos! Tente novamente ou cadastre-se. 
		                     </div>
	                	</cfoutput> 
	                </cfif>
	            </cfif>     
	        </cfif> 
	    </cflogin> 
	</cffunction>
</cfcomponent>