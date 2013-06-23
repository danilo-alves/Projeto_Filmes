// Funções AJAx para avaliação de Filme
// Data criacao: 16/06
// Autor: Danilo

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