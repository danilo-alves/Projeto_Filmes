<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">

	<!--- X-Editable plugin --->
<!--- <link href="assets/x-editable-1.4.4/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet">
<script src="assets/x-editable-1.4.4/bootstrap-editable/js/bootstrap-editable.min.js"></script> --->
	
	<cfparam name="imgCapa" default=""> 
	<cfparam name="editEnabled" default="false">
	
	<!--- Necessário para formulário Ajax --->
	<cfajaximport/>

  	<!--- Avaliacao de filme utilizando Ajax --->
	<script>
	function submitForm(id) {
		var urlString = 'avaliarFilme.cfm?Id=';
		urlString = urlString.concat(id);

        ColdFusion.Ajax.submitForm('formAvaliacao', urlString, callback,
            errorHandler);
    }
    
    function callback(text)
    {
        divAval = document.getElementById('avaliacao');
        alert("Obrigado por avaliar!");
    }
    
    function errorHandler(code, msg)
    {
        alert("Error!!! " + code + ": " + msg);
    }
	</script>

	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->

    	<cfset id_filme = url.Id >

		<!--- Retorna um registro unico (true) do Filme de Id recebido pela URL --->
    	<cfset dadosFilme = EntityLoad('Filme', {Id_Filme = url.Id}, true)>
		
		<cfif getAuthUser() NEQ "">
			
			<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
			<cfset userCriador = dadosFilme.getId_Usuario()>
			<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

			<!--- Habilita o modo de edição --->
			<cfif userCriador.getEmail() EQ user.getEmail()>
				<cfset editEnabled = "true">
			</cfif>
		</cfif>

		<!--- <cftry> --->
			<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = #dadosFilme#}, true)>
			
			<div class="span10">
	    		<div class="span2" style="float: left">
					<cfset imgPath = #imgCapa.getImagem_Path()#>

	    			<!--- Carrega a imagem --->
					<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
				</div>

		<!--- <cfcatch>
			<!--- Exibe um thumbnail padrao caso não exista imagem --->
			<div class="span10">
	    		<div class="span2" style="float: left">
					<img data-src="holder.js/260x160">
				</div> 
		</cfcatch>
		</cftry> --->

		<!---<cfdump var="#dadosFilme#">--->

			<cfoutput>
				<div class="span6">
					<cfif #editEnabled# EQ "true">
						<a href="" id="titulo" data-type="text" data-pk="#url.Id#" data-url="/post" data-original-title="Filme"><h2>#dadosFilme.getTitulo()#</h2></a>
						<a href="" id="username" data-type="text" data-pk="1" data-url="/post" data-original-title="Enter username">superuser</a>
					<cfelse>
	    				<h2>#dadosFilme.getTitulo()#</h2>
	    			</cfif>
	    			<p class="lead">Ano de lançamento: #dadosFilme.getAno()#</p>
					
					<div id="star" data-score="1"></div>
					<!--- <script>
						$('#star').raty('score', 4);
					</script> --->
				</div>
				<div class="span10">
					<h3>Sinopse</h3>
					<hr/>
					
					<p>#dadosFilme.getSinopse()#</p>
					 
					<h3>Trailer</h3>
					<hr/>
					
					<!--- Carrega o embeb do banco de dados --->
					<center><iframe width="560" height="315" src="http://www.youtube.com/embed/#dadosFilme.getTrailer()#" frameborder="0" allowfullscreen></iframe></center>

				</div>
			</cfoutput>
			<!--- Carrega as avaliacoes feitas pelos usuarios --->
			<div id="avaliacao" class="span10">
				<h3>Avaliação</h3>
				<hr/>
				<a href="#myModal" role="button" class="btn" data-toggle="modal" class="btn btn-primary">Avalie este filme!</a>
				
				<hr/>
	    		<div id="myModal" class="modal hide fade">
				    <div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				    	<h3>Avaliação</h3>
				    </div>
				    <cfform name="formAvaliacao" method="POST" >
				    	<div class="modal-body">	
				    		<cftextarea name="txtAvaliacao" required="true" maxlength="300" height="300" width="300"/>	
				    		<hr/>
				    		<p>Avaliação</p>
				    		<cfinput name="Nota" type="radio" value="1" />
				    		<cfinput name="Nota" type="radio" value="2" />
				    		<cfinput name="Nota" type="radio" value="3" />
				    		<cfinput name="Nota" type="radio" value="4" />
				    		<cfinput name="Nota" type="radio" value="5" />
				    		
				    		<cfinput name="labelNota" bind="{Nota}"/>
				    	</div>
					    <div class="modal-footer">
					    	<cfoutput><a href="javascript:submitForm(#url.Id#)" class="btn btn-primary">Avaliar</a></cfoutput>
					    </div>
				    </cfform>
			    </div>
	
					<cfset avaliacoes = EntityLoad('Avaliacao', {Filme = #dadosFilme#}) />

					<cfif arrayLen(avaliacoes) GT 0>
						<cfloop index="aval" array="#avaliacoes#">
							<cfoutput>
								<div class="hero-unit">
									<cfset user = aval.getUsuario() />
									<p class="lead">#user.getNome()#</p>
									<p>Nota: #aval.getNota()# </p>
									<p>#aval.getCritica()#</p>
									<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
								</div>								
							</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput><p class="lead">Não há avaliações deste filme ainda, seja o primeiro a dar uma opinião.</p></cfoutput>
					</cfif>
			</div>
    	</div>
    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">
