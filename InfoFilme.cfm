<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">
	
	<cfparam name="imgCapa" default=""> 
	
	<!--- Necessário para formulário Ajax --->
	<cfajaximport/>

  	<!--- Avaliacao de filme utilizando Ajax --->
	<script>
	function submitForm() {
        ColdFusion.Ajax.submitForm('formAvaliacao', 'avaliarFilme.cfm', callback,
            errorHandler);
    }
    
    function callback(text)
    {
        divAval = document.getElementById('myModal');
        
        divAval.innerHTML += text;
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

		<cftry>
			<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = url.Id}, true)>

			<cfdump var="==#imgCapa#==">
			
			<div class="span10">
	    		<div class="span2" style="float: left">
					<cfset imgPath = #imgCapa.getImagem_Path()#>

	    			<!--- Carrega a imagem --->
					<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
				</div>

		<cfcatch>
			<!--- Exibe um thumbnail padrao caso não exista imagem --->
			<div class="span10">
	    		<div class="span2" style="float: left">
					<img data-src="holder.js/260x160">
				</div> 
		</cfcatch>
		</cftry>

		<!---<cfdump var="#dadosFilme#">--->

		<cfoutput>
				<div class="span6">
	    			<h2>#dadosFilme.getTitulo()#</h2>
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
				    	</div>
					    <div class="modal-footer">
					    	<a href="javascript:submitForm()" class="btn btn-primary">Avaliar</a>
					    </div>
				    </cfform>
			    </div>
	
				<div class="hero-unit">
					<p class="lead">Usuario</p>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet cursus congue.
					 Quisque porttitor luctus mauris, ac rhoncus libero dignissim vel. Sed eget posuere orci. 
				 	Proin elit libero, feugiat sed suscipit sit amet, congue vitae eros. In vulputate scelerisque dui,
				 	vitae mollis nisl aliquam sed. Proin consectetur velit </p>
					<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
				</div>
				<div class="hero-unit">
					<p class="lead">Usuario</p>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet cursus congue.
					 Quisque porttitor luctus mauris, ac rhoncus libero dignissim vel. Sed eget posuere orci. 
				 	Proin elit libero, feugiat sed suscipit sit amet, congue vitae eros. In vulputate scelerisque dui,
				 	vitae mollis nisl aliquam sed. Proin consectetur velit </p>
					<p><a class="btn btn-success">Gostei!</a>	<a class="btn btn-danger">Não Gostei!</a></p>
				</div>
			</div>
    	</div>
    </div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">
