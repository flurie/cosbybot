// ==UserScript==
// @name           Auto-send cosby
// @description    Sends data instantly to cosbybot
// @include        http://utopia-game.com/*
// @version        0.2
// @grant          GM_xmlhttpRequest
// ==/UserScript==

function getBodyhtml(win){
    var source = document.documentElement.innerHTML;
    return source;
}

function getBodyText(win){
    var doc=win.document,body=doc.body,selection,range,bodyText;
    if(body.createTextRange){
        return body.createTextRange().text;
    }
    else if(win.getSelection){
        selection=win.getSelection();
        range=doc.createRange();
        range.selectNodeContents(body);
        selection.addRange(range);
        bodyText=selection.toString();
        selection.removeAllRanges();
        return bodyText;
    }
}

//not using this one now
function setCookie(c_name,value,exdays)
{
var exdate=new Date();
exdate.setDate(exdate.getDate() + exdays);
var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
document.cookie=c_name + "=" + c_value;
}

/*function setCookie(cname, cvalue, cexpire) {
    document.cookie = cname + '=' + escape(cvalue) +
    (typeof cexpire == 'date' ? 'expires=' + cexpire.toUTCString() : '') +
    ',path=/;domain=utopia-game.com';
 }*/

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

var page = document.URL;
var send = false;
//need to check to see if this player is sitting a prov
var sitting = (page.match("/sit/")) ? true : false;
//check for pages that we can scrape
if (page.match("com/wol/(sit/)?game/throne")) {
    //this is a page we can send
    send = true;
    //check for sitting; if so, check value of sitting identity cookie against provname
    var provname = document.body.innerHTML.match(/The Province of ([\d\s\w]+) \(/)[1];
    if (sitting) {
        if (!getCookie("sitname") || (getCookie("sitname") != provname)) {
            setCookie("sitname", provname, null);
        }
    }
    //not sitting, check cookie
    else if (!getCookie("provname")) {
         setCookie("provname", provname, null);
    }
}
else if (page.match("com/wol/(sit/)?game/council_military")) {
    /*NOTE HERE: I have NO WAY to check if the names are right. I can only check to see
    //if they're there. So there are edge cases where you:
    1) previously sat a prov
    2) start sitting a new prov and somehow skip logging into the throne page
    3) send data with the previously sat provname
    Not sure if there's a way to fix this. Maybe make the provname a session cookie?
    */
    send = ((sitting && getCookie("sitname")) || getCookie("provname"));
}

if (send) {
    GM_xmlhttpRequest({
        method: "POST",
        url: "http://flurie.net:3000/agent",
        data: "url=" + escape(document.URL) + "&data=" +
            escape(getBodyhtml(window)) + "&prov=" + (sitting ?
                                                      escape(getCookie("sitname")) :
                                                      escape(getCookie("provname"))),
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        }
    });
    alert("sent data!")
} 
