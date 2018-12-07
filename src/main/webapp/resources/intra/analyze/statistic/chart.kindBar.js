Ext.require(['Ext.chart.*',
             'Ext.data.*',
             'Ext.layout.container.Fit']); 

var initChartKindBar = function() {
    var baseCount = $('#baseCount').val();
    
    // 최대 SNS 사용갯수에 맞춰 준비된 Fields 배열을 반환
    /*var arrField1 = ['data'];
    var arrField2 = ['Twitter','Facebook'];
    var arrField3 = ['data','data1','data2'];
    var arrField4 = ['data','data1','data2','data3'];
    var arrField5 = ['data','data1','data2','data3','data4'];
    var arrField6 = ['data','data1','data2','data3','data4','data5'];*/
    var getFields = function(baseCount) {
        var arrFields = [];

        for(var i=0; i < baseCount; i++){
            var name = $('table.boardList thead tr').find('th').eq(i+1).text();
            arrFields.push(name);
        }
        return arrFields;
        /*switch(parseInt(baseCount)) {
            case 1:
                return arrField1;
                break;
            case 2:
                return arrField2;
                break;
            case 3:
                return arrField3;
                break;
            case 4:
                return arrField4;
                break;
            case 5:
                return arrField5;
                break;
            case 6:
                return arrField6;
                break;
            default:
                break;
        }*/
    };


    var getData = function () {

        var fileds = ['name'];
        /*var arrFields = getFields(baseCount);
        for(var i=0 ; i < arrFields.length ; i++) {
            fileds.push(arrFields[i]);
        }*/
        for(var i=0; i < baseCount; i++){
            var name = $('table.boardList thead tr').find('th').eq(i+1).text();
            fileds.push(name);
        }

        var data = [];

        $('table.boardList tbody tr').each(function (index) {
            //공통코드  PRV_CD = 86 번 추가시
            //data[index]에 추가
            //prv_nm : getTdVal($(this),prv_cd)
                
            data[index] = 
                {
                    name : $(this).find('td').eq(0).text().replace(/\s/g, ''),
                    Twitter : getTdVal($(this), 1001),
                    Facebook : getTdVal($(this), 1002),
                    요즘 : getTdVal($(this), 1003),
                    공감 : getTdVal($(this), 1004),
                    미투데이 : getTdVal($(this), 1005)
                    
                };
            
        });

        return Ext.create('Ext.data.JsonStore', {
            fields : fileds,
            data   : data
        });
    };

    // 대상 TD 값을 구해서 반환
    var getTdVal = function($tr, idx) {
        var intVal = 0;
        /*var val = $tr.find('td').eq(idx);*/
        var val = $tr.find('td#'+idx);
        if(val) {
            intVal = parseInt(val.text(),10);
            if(isNaN(intVal)) {
                intVal = 0;
            }
        }

        return intVal;
    };

    var chart = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        shadow: true,
        store: getData(),
        legend: {
            position: 'right'
        },
        axes: [{
            type: 'Numeric',
            position: 'bottom',
            fields: getFields(baseCount),
//            title: '댓글수',//$('table.boardList thead tr th').eq(1).text(),
            title : false,
            grid: true,
            minimum: 0
        }, {
            type: 'Category',
            position: 'left',
            fields: ['name'],
            title: $('table.boardList thead tr th').eq(0).text()
        }],
        series: [{
            type: 'bar',
            axis: 'bottom',
            
            xField: 'name',
            yField: getFields(baseCount),
            stacked: true,
            tips: {
                trackMouse: true,
                width: 74,
                height: 38,
                renderer: function(storeItem, item) {
                    // this.setTitle(item.value);
                    this.setTitle(item.value[1]);
                }
            },
            label: {
                display: 'insideEnd',
                  field: getFields(baseCount),
                  renderer: Ext.util.Format.numberRenderer(),
                  orientation: 'horizontal',
                  color: '#333',
                  'text-anchor': 'middle'
              }

//            style: {
//                fill: '#38B8BF'
//            }
            
        }]
    });

    
    
    $("#_chartKindBar").html('');
    Ext.create('widget.panel', {
        height: (65 * $('#lCount').val()) + 65,
        
        //title: '권한그룹별통계',
        renderTo: '_chartKindBar',
        layout: 'fit',
        items: chart
    });
};