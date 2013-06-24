<!--- Inclui o conteudo de cabe&ccedil;alho padr&atilde;o --->
<cfinclude template="Header.cfm">

	<!--- X-Editable plugin --->
<!--- <link href="assets/x-editable-1.4.4/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet"> --->
<!--- <script src="assets/x-editable-1.4.4/bootstrap-editable/js/bootstrap-editable.min.js"></script> --->
<link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.4.4/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet">
<script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.4.4/bootstrap-editable/js/bootstrap-editable.min.js"></script>
	
	<cfparam name="imgCapa" default=""> 
	<cfparam name="editEnabled" default="false">
	
	<!--- Necess&aacute;rio para formul&aacute;rio Ajax --->
	<cfajaximport/>

  	<!--- Avaliacao de filme utilizando Ajax --->
	<script  src="avaliarAction.js"></script>
	<script  src="listaDesejoAction.js"></script>
	<script  src="pontuacaoCritica.js"></script>


	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="CheckMenuBar.cfm"> <!--- Inclui a barra de menus --->

    	<cfset id_filme = url.Id >

		<!--- Retorna um registro unico (true) do Filme de Id recebido pela URL --->
    	<cfset dadosFilme = EntityLoad('Filme', {Id_Filme = url.Id}, true)>
		
		<cfif isUserLoggedin()>
			
			<!--- Verifica se o visitante da pagina de filme é o criador e entao permite a edicao --->
			<cfset userCriador = dadosFilme.getId_Usuario()>
			<cfset user = EntityLoad('Usuario', {Email=getAuthUser()}, true)>

			<!--- Habilita o modo de edi&ccedil;&atilde;o --->
			<cfif userCriador.getEmail() EQ user.getEmail()>
				<cfset editEnabled = "true">
			<cfelse>
				<cfset editEnabled = "false">
			</cfif>
		</cfif>

		<cftry>
			<cfset imgCapa = EntityLoad('Imagem', {Id_Filme = #dadosFilme#}, true)>
			
			<!--- spanNum obtido em CheckMenuBar.cfm --->
			<div class="span10">
	    		<div class="span2" style="float: left">
					<cfset imgPath = #imgCapa.getImagem_Path()#>

	    			<!--- Carrega a imagem --->
					<cfimage action="writeToBrowser" source="#imgCapa.getImagem_Path()#" height="50%" width="50%">
				</div>

		<cfcatch>
			<!--- Exibe um thumbnail padrao caso n&atilde;o exista imagem --->
			<div class="span10">
	    		<div class="span2" style="float: left">
					<img data-src="holder.js/260x160">
				</div> 
		</cfcatch>
		</cftry>

			<!--- CONTEUDO --->
			<cfoutput>
				<div class="span7">
					<cfif #editEnabled# EQ "true">
						<div class="span8">
							<h2>#dadosFilme.getTitulo()#</h2>
						</div>
					<cfelse>
	    				<h2>#dadosFilme.getTitulo()#</h2>
	    			</cfif>

	    			<p class="lead">Ano de lan&ccedil;amento: #dadosFilme.getAno()#
	    			<br/>
	    			<cfif dadosfilme.getNotaMedia() EQ "">
						N&atilde;o h&aacute; avalia&ccedil;&atilde;o para este filme.
					<cfelse>
						M&eacute;dia: #dadosfilme.getNotaMedia()#
					</cfif>
	    			</p>
					
					<!--- Lista de Desejo --->
					<div class="span2 pull-right">
						<cfif isUserLoggedin()>
							<cfoutput><a href="javascript:adicionaLista(#url.Id#)" class="btn bnt-mini btn-info">Adicionar &aacute; Lista de Desejos</a></cfoutput>
						</cfif>

						<cfif #editEnabled#>
							<cfoutput><a href="AddFilme.cfm?Id=#url.Id#" class="btn bnt-mini btn-warning">Editar</a></cfoutput>
							<cfoutput><a href="javascript:adicionaLista(#url.Id#)" class="btn bnt-mini btn-error">Excluir</a></cfoutput>
						</cfif>
					</div>
					<div id="star" data-score="1"></div>
					<!--- <script>
						$('#star').raty('score', 4);
					</script> --->
				</div>
				<div class="#spanNum#">
					<h3>Sinopse</h3>
					<hr/>
					
					<p>#dadosFilme.getSinopse()#</p>
					 
					<h3>Trailer</h3>
					<hr/>
					
					<!--- Carrega o embeb do banco de dados --->
					<center><iframe width="560" height="315" src="http://www.youtube.com/embed/#dadosFilme.getTrailer()#" frameborder="0" allowfullscreen></iframe></center>
				</div>
			</cfoutput>


			<cfoutput><div id="avaliacao" class="#spanNum#"></cfoutput>
				<hr/>
				<cfoutput><h3>Avalia&ccedil;&atilde;o</h3></cfoutput>
				<a href="#myModal" role="button" class="btn" data-toggle="modal" class="btn btn-primary">Avalie este filme!</a>
				
				<hr/>
	    		<div id="myModal" class="modal hide fade">
				    <div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				    	<h3>Avalia&ccedil;&atilde;o</h3>
				    </div>
				    <cfform name="formAvaliacao" method="POST" >
				    	<div class="modal-body">	
				    		<cftextarea name="txtAvaliacao" required="true" maxlength="300" height="300" width="300"/>	
				    		<hr/>
				    		<p>Avalia&ccedil;&atilde;o</p>
				    		<cfinput name="Nota" type="radio" value="1" />
				    		<cfinput name="Nota" type="radio" value="2" />
				    		<cfinput name="Nota" type="radio" value="3" />
				    		<cfinput name="Nota" type="radio" value="4" />
				    		<cfinput name="Nota" type="radio" value="5" />
				    	</div>
					    <div class="modal-footer">
					    	<cfoutput><a href="javascript:submitForm(#url.Id#)" class="btn btn-primary" data-dismiss="modal">Avaliar</a></cfoutput>
					    </div>
				    </cfform>
			    </div>
	
					<cfset avaliacoes = EntityLoad('Avaliacao', {Filme = #dadosFilme#}, "Pontuacao as Desc",{maxResults=10}) />

					<cfif arrayLen(avaliacoes) GT 0>
						<cfloop index="aval" array="#avaliacoes#">
							<cfoutput>
								<div class="hero-unit">
									<cfset user = aval.getUsuario() />
									<p class="lead">#user.getNome()#<br/>
									Nota: #aval.getNota()#<br/>
									<p>#aval.getCritica()#</p>
									<cfform id="hero_#aval.getId_Avaliacao()#" name="formPont">
										<cfinput name="id" type="hidden" value="#aval.getId_Avaliacao()#"/>
										<p><a class="btn btn-success" href="javascript:submitPont(1,'#isUserLoggedin()#')">Gostei!</a>       <a class="btn btn-danger" href="javascript:submitPont(0,'#isUserLoggedin()#')">N&atilde;o Gostei!</a></p>
									</cfform>
								</div>								
							</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput><p class="lead">N&atilde;o h&aacute; avalia&ccedil;ões deste filme ainda, seja o primeiro a dar uma opini&atilde;o.</p></cfoutput>
					</cfif>
			</div>
    	</div>
    </div>

<!--- Inclui o conteudo de rodapé padr&atilde;o --->
<cfinclude template="Footer.cfm">
