var chartTotal = 0;

Ext.require(['Ext.chart.*',
             'Ext.data.*',
             'Ext.layout.container.Fit']);
 
var initChartPie = function() {

    var getData = function () {
        var fileds = ['name', 'data'];
        var data = [];
    
        $('._chartData').each(function (index) {
            var text = $("._chartTitle")[index].innerText;
            var value = $(this).text();
            data[index] = {name : text,
                           data : value};
            chartTotal += parseInt(value);
        });
        
        return Ext.create('Ext.data.JsonStore', {
            fields : fileds,
            data   : data
        });
    };

    var chart = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        id: 'chartCmp',
        animate: true,
        store: getData(),
        shadow: true,
        legend: {
            position: 'right'
        },
        insetPadding: 15,
        theme: 'Base:gradients',
        series: [{
            type: 'pie',
            field: 'data',
            //showInLegend: true,
            donut: false,
            tips: {
              trackMouse: true,
              width: 140,
              height: 25,
              renderer: function(storeItem, item) {
                this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / chartTotal * 100) + '%');
              }
            },
            highlight: {
              segment: {
                margin: 10
              }
            },
            label: {
                field: 'name',
                display: 'rotate',
                contrast: true,
                font: '12px Arial'
            }  ,
            colorSet : ['rgb(205, 62, 62)',
                        'rgb(226, 145, 41)', 
                        'rgb(156, 177, 17)', 
                        'rgb(17, 177, 69)', 
                        'rgb(38, 93, 193)', 
                        'rgb(151, 38, 193)', 
                        'rgb(219, 68, 143)', 
                        'rgb(177, 177, 177)']
        }]
    });


    $("#_chartPie").html('');
    Ext.create('widget.panel', {
        height: 350,
        title: '',
        renderTo: '_chartPie',
        layout: 'fit',
        items: chart
    });
};