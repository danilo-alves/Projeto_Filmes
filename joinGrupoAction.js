// Funções AJAx para avaliação de Filme
// Data criacao: 16/06
// Autor: Danilo

function submitJoin() {
	var urlString = 'JoinGrupo.cfm';

    ColdFusion.Ajax.submitForm('formJoin', urlString, callback,
        errorHandler);
}

function callback(text)
{
    divAval = document.getElementById('maincontent');

    divAval.innerHTML += text;

    alert('Thanks');
}

function errorHandler(code, msg)
{
    alert("Error!!! " + code + ": " + msg);
}