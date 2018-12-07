jQuery(function($){
	$.datepicker.regional['ko'] = {
        changeMonth: true,
        changeYear: true,
        showOtherMonths: true,
		closeText: '�リ린',
		prevText: '�댁쟾��',
		nextText: '�ㅼ쓬��',
		currentText: '�ㅻ뒛',
        monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
        monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		dayNames: ['��','��','��','��','紐�','湲�','��'],
		dayNamesShort: ['��','��','��','��','紐�','湲�','��'],
		dayNamesMin: ['��','��','��','��','紐�','湲�','��'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '��'};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
});