// Fun&ccedil;ões AJAx para avalia&ccedil;&atilde;o de Filme
// Data criacao: 16/06
// Autor: Danilo

function submitJoin(idgrupo, join) {
	var urlString = 'JoinGrupo.cfm?join=' + join;
	
	// passa os dados do formul&aacute;rio de acordo com o id do grupo
	var formName = 'formJoin' + idgrupo;
	formName = formName.trim();

    ColdFusion.Ajax.submitForm(formName, urlString, callback,
        errorHandler);

    var botaoId = 'btnAction' + idgrupo;
    botaoId = botaoId.trim();
    var botao = document.getElementById(botaoId);
    botao.parentNode.removeChild(botao);
}

function callback(text)
{
    divAval = document.getElementById('maincontent');
    divAval.innerHTML = text + divAval.innerHTML;
}

function errorHandler(code, msg)
{
    alert("Error!!! " + code + ": " + msg);
}