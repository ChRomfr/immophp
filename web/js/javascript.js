function getXMLHttpRequest() {
    var xhr = null;

    if (window.XMLHttpRequest || window.ActiveXObject) {
            if (window.ActiveXObject) {
                    try {
                            xhr = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch(e) {
                            xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    }
            } else {
                    xhr = new XMLHttpRequest();
            }
    } else {
            alert("Votre navigateur ne supporte pas l'objet XMLHTTPRequest...");
            return null;
    }

    return xhr;
}

function verifFormatEmail(elm){
    if (elm.indexOf("@") != "-1" &&
        elm.indexOf(".") != "-1" &&
        elm != "")
        return true;

        return false;

}

function showid(idelem)
{
    if(document.getElementById(idelem).style.display=='none') document.getElementById(idelem).style.display='block';
    else document.getElementById(idelem).style.display='none';
}

function showPopup(lien){
window.open(lien, "ouverture", "toolbar=no, status=yes, scrollbars=yes, resizable=no, width=600, height=600");
}

function CheckDate(d) {
  // Cette fonction vérifie le format JJ/MM/AAAA saisi et la validité de la date.
  // Le séparateur est défini dans la variable separateur
  var amin=1999; // année mini
  var amax=2100; // année maxi
  var separateur="/"; // separateur entre jour/mois/annee
  var j=(d.substring(0,2));
  var m=(d.substring(3,5));
  var a=(d.substring(6));
  var ok=1;
  if ( ((isNaN(j))||(j<1)||(j>31)) && (ok==1) ) {
	 alert("Le jour n'est pas correct."); ok=0;
  }
  if ( ((isNaN(m))||(m<1)||(m>12)) && (ok==1) ) {
	 alert("Le mois n'est pas correct."); ok=0;
  }
  if ( ((isNaN(a))||(a<amin)||(a>amax)) && (ok==1) ) {
	 alert("L'année n'est pas correcte."); ok=0;
  }
  if ( ((d.substring(2,3)!=separateur)||(d.substring(5,6)!=separateur)) && (ok==1) ) {
	 alert("Les séparateurs doivent être des "+separateur); ok=0;
  }
  if (ok==1) {
	 var d2=new Date(a,m-1,j);
	 j2=d2.getDate();
	 m2=d2.getMonth()+1;
	 a2=d2.getFullYear();
	 if (a2<=100) {a2=1900+a2}
	 if ( (j!=j2)||(m!=m2)||(a!=a2) ) {
		alert("La date "+d+" n'existe pas !");
		ok=0;
	 }
  }
  return ok;
}

function CheckHeure(h){
	var heure = (h.substring(0,2));
	var minute = (h.substring(3,5));
	var ok = 1;
	
	if( (isNaN(heure)) || heure<0 || heure>24 ){
		ok=0;
	}
	
	if( (isNaN(minute)) || minute<0 || minute>60 ){
		ok=0;
	}
	
	return ok;	
}