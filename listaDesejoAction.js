// Funções AJAx para avaliação de Filme
// Data criacao: 16/06
// Autor: Danilo

function adicionaLista(id) {
	var urlString = 'addListaDesejo.cfm?Id=';
	urlString = urlString.concat(id);

    ColdFusion.Ajax.submitForm('formAvaliacao', urlString, callback,
        errorHandler);
}

function callback(text)
{
    alert("Filme adicionado!");
}

function errorHandler(code, msg)
{
    alert("Error!!! " + code + ": " + msg);
}