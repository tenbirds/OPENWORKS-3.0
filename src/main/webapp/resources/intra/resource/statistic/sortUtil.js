/** 공통변수 */
var heads = '';
var list = null;
var sortConfig = {
        sortIndex : -1,
        sortStatus : 'ASC',
        ascImage : '<img src="'+CTX_PATH + '/resources/openworks/spi/openworks/editor/LIVEEditor/scripts/icons/smiley-eek.png" alt="오름차순"/>',
        descImage : '<img src="'+CTX_PATH + '/resources/openworks/spi/openworks/editor/LIVEEditor/scripts/icons/smiley-cool.png" alt="내림차순"/>'        
};

/**
 * 정렬된 목록을 새로 그림
 */
var drawList = function() {
    $('#listBody > tr').each(function(idx, el) {
       $(this).html(list[idx][0]); 
    });
};

/**
 * 제목줄에 정렬표시 아이콘을 표시 
 */
var drawIcon = function() {
    $('#listHead > tr').html(heads);
    var head = $('#sortHead' + sortConfig.sortIndex);
    if (sortConfig.sortStatus === 'DESC') {
        head.html(head.text()+ sortConfig.descImage);
    } else{
        head.html(head.text()+ sortConfig.ascImage);    
    }
    
};

/**
 * 정렬에 필요한 값을 셋팅
 */
var initSort = function() {
    list = new Array();
    var listItem = null;
    $('#listBody > tr').each(function(idx, el) {
        listItem = new Array();
        listItem.push($(this).html());
        $(this).children('td').each(function(idx2, el2) {
            listItem.push($(this).attr('title'));
        });
        list.push(listItem);
    });
    heads = $('#listHead > tr').html();
};

/**
 * test
 */
var check = function() {
    for (var i = 0 ; i < list.length ; i++) {
        //alert(list[i][0]);
        for (var x = 0 ; x < list[i].length ; x++ ) {
            //alert(list[i][x]);
        }
    }
};

/**
 * array 타입 sort function
 */
var sortFunction = function (a,b){
    var _a = null;
    var _b = null;
    if (sortConfig.sortStatus === "ASC") {
        _a = a[sortConfig.sortIndex];
        _b = b[sortConfig.sortIndex];
    } else {
        _a = b[sortConfig.sortIndex];
        _b = a[sortConfig.sortIndex];
    }

    if (isNaN(_a) === true) {
        
        if(String(_a) > String(_b)) return 1;
        if(String(_a) < String(_b)) return -1;
        return 0;
    } else {
        return (Number(_a) - Number(_b));
    }
};


/**
 * 정렬
 */
var sorting = function(idx) {
    
    // 현재 컬럼이 정렬되어 있으면 정렬 상태를 바꿔주고,
    // 새로운 컬럼이라면 DESC 함
    if (sortConfig.sortIndex !== idx) {
        sortConfig.sortStatus = 'DESC'; 
    } else {
        if (sortConfig.sortStatus === 'DESC') {
            sortConfig.sortStatus = 'ASC'; 
        } else {
            sortConfig.sortStatus = 'DESC'; 
        }
    }
    
    // 정렬하고자 하는 컬럼 인덱스를 저장
    sortConfig.sortIndex = idx;
    
    // 리스트를 정렬한다
    list.sort(sortFunction);
    
    // 제목줄에 아이콘을 표시
    drawIcon();
    
    // 정렬된 목록을 화면에 표시
    drawList();
};