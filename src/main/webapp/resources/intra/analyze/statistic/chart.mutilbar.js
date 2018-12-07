Ext.require(['Ext.chart.*',
             'Ext.data.*',
             'Ext.layout.container.Fit']);
var initChartMutilBar = function() {
    var getData = function () {
     
        return Ext.create('Ext.data.JsonStore', {
            fields : fileds,
            data   : data
        });
    };

    var chart = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        shadow: true,
        store: getData(),
        axes: [{
            type: 'Numeric',
            position: 'left',
            fields: dataFileds,
            title: xTitle,
            grid: true,
            minimum: 0
        }, {
            type: 'Category',
            position: 'bottom',
            fields: ['name'],
            title: yTitle
        }],
        series: [{
            type: 'column',
            axis: 'left',
            gutter: 80,
            xField: 'name',
            yField: dataFileds,
            tips: {
                trackMouse: true,
                width: 74,
                height: 38,
                renderer: function(storeItem, item) {
                   
                    var title   = "";
                    var dataSeq = "";
                    
                    for( var i = 0; i < item.series.items.length; i++ ){
                        if( item == item.series.items[i] ){
                          
                          itemsPerRec = item.series.items.length / item.storeItem.store.getCount();                          
                          var j       = i % itemsPerRec;  
                          title       = $('table.tipsNmList tbody tr').eq(j).find('td').eq(0).text().replace(/\s/g, '');   
                          dataSeq     = "data"+j;
                        }
                    }
                    //  alert(dataSeq);
                    
                    if(title != "") this.setTitle(title+" / "+storeItem.get(dataSeq+""));
                    else            this.setTitle(storeItem.get(dataSeq+""));
                    
                    //this.update();
                }
            },
            style: {
                fill: '#38B8BF'
            }
        }]
    });
 
    $("#_chartMutildBar").html('');
    Ext.create('widget.panel', {
        height: 350,
        //title: '권한그룹별통계',
        renderTo: '_chartMutildBar',
        layout: 'fit',
        items: chart
    });
    
    
};