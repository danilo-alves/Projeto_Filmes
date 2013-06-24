// Fun&ccedil;ões AJAx para avalia&ccedil;&atilde;o de Filme
// Data criacao: 16/06
// Autor: Danilo

function submitPont(id, login){
	if(login == "YES"){
		var urlString = 'pontCritica.cfm?pont=';
		urlString = urlString.concat(id);

	    ColdFusion.Ajax.submitForm('formPont', urlString, callback,
	        errorHandler);
	}
	else
		alert("Realize o login para poder pontuar");
	// alert(login);
}

function callback(text){
	hero = "hero_" + text;
	hero = hero.trim();

    var divAval = document.getElementById(hero);
    divAval.parentNode.removeChild(divAval);
}

function errorHandler(code, msg){
    alert("Error!!! " + code + ": " + msg);
}