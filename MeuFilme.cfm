<!--- Inclui o conteudo de cabeçalho padrão --->
<cfinclude template="Header.cfm">
	
	<cfparam name="imgCapa" default=""> 
	
	<!-- Corpo do site  -->
    <div class="row">
    	<!-- spanN em que N se refere ao numero de colunas, Maximo de 12 colunas -->
    	<cfinclude template="MenuBar.cfm"> <!--- Inclui a barra de menus --->

    	<div class="span10">
			<h3>Meus Filmes</h3>
			<hr/>
			
			<cfloop index="i" from="0" to="10" step="1">
				<div class="media">
					 <a class="pull-left" href="#">
						<img class="media-object" data-src="holder.js/64x64">
					</a>
					<div class="media-body">
					<h4 class="media-heading">Filme <cfoutput>#i#</cfoutput></h4>	
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas gravida faucibus pharetra. Vivamus ut pulvinar risus. Suspendisse arcu quam, tincidunt nec augue eget, euismod malesuada dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla luctus quam vulputate rhoncus porta</p>
				</div>
			</cfloop>
	</div>

<!--- Inclui o conteudo de rodapé padrão --->
<cfinclude template="Footer.cfm">