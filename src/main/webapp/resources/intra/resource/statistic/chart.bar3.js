Ext.require(['Ext.chart.*',
             'Ext.data.*',
             'Ext.layout.container.Fit']);
var initChartBar3 = function() {
    var getData = function () {
//        var fileds = ['date', 'name', 'data'];
        var fileds = ['name', 'data'];
        var data = [];
        
        $('table.boardList tbody tr').each(function (index) {
            //alert($(this).find('td').eq(0).text().replace(/\s/g, '') + " : " + parseInt($(this).find('td').eq(1).text(),10));
            data[index] = {
//                    date : $(this).find('td').eq(0).text().replace(/\s/g, ''),
                    name : $(this).find('td').eq(0).text().replace(/\s/g, ''),
                           data : parseInt($(this).find('td').eq(1).text(),10)};
        });
        //alert(data[0]);
        return Ext.create('Ext.data.JsonStore', {
            fields : fileds,
            data   : data
        });
    };
/*
    var chart = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        shadow: true,
        store: getData(),
        minWidth: 10,
        maxWidth: 20,
        axes: [{
            type: 'Numeric',
            position: 'left',
            fields: ['data'],
            title: $('table.boardList thead tr th').eq(1).text(),
            grid: true,
            minimum: 0
        }, {
            type: 'Category',
            position: 'bottom',
            fields: ['name'],
            title: $('table.boardList thead tr th').eq(0).text(),
        }],
        series: [{
            type: 'column',
            axis: 'left',
            gutter: 80,
            xField: 'name',
            yField: ['data'],
            tips: {
                trackMouse: true,
                width: 74,
                height: 38,
                renderer: function(storeItem, item) {
                    this.setTitle(storeItem.get('name'));
                    this.update(storeItem.get('data'));
                }
            },
            style: {
                fill: '#38B8BF'
            }
        }]
    });
*/
    var chart = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        shadow: true,
        store: getData(),
        axes: [{
            type: 'Category',
//            type: 'Numeric',
            position: 'left',
            fields: ['name'],
            title: $('table.boardList thead tr th').eq(0).text()
            ,grid: true
            ,minimum: 0
        }, {
//            type: 'Numeric',
            type: 'Numeric',
            position: 'bottom',
            fields: ['data'],
            title: $('table.boardList thead tr th').eq(1).text()
            ,grid: true
            ,minimum: 0
        }],
        series: [{
            type: 'bar',
            axis: 'left',
            gutter: 80,
            xField: 'name',
            yField: ['data'],
            tips: {
                trackMouse: true,
                width: 120,
                height: 80,
                renderer: function(storeItem, item ) {
                    this.setTitle(storeItem.get('name'));
                    this.update(storeItem.get('data'));// , storeItem.get('date'));
                    //this.update2();
                    //this.update(storeItem.get('date'));
                }
            },
            style: {
                fill: '#38B8BF'
            }
        }]
    });
    
    $("#_chartBar3").html('');
    Ext.create('widget.panel', {
        height: 350,
        //title: '권한그룹별통계',
        renderTo: '_chartBar3',
        layout: 'fit',
        items: chart
    });
};