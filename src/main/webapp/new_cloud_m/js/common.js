function fn_mobMainSearch(){
    totalKeyword = document.getElementById("totalKeyword");
    if(totalKeyword.value == ""){
        alert(Message.msg.enterSrchWrd);
        totalKeyword.focus();
        return;
    }else{
        location.href="/korean/m/search/BD_index.do?totalKeyword="+encodeURIComponent(totalKeyword.value);
    }
}