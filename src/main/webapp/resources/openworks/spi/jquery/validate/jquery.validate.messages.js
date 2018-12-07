/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ko-Kr
 */
jQuery.extend(jQuery.validator.messages, {
    required    : Message.msg.required,
    email       : Message.msg.email,
    email2      : Message.msg.email,
    url         : Message.msg.url,
    date        : Message.msg.date,
    formatDate  : Message.msg.formatDate,
    number      : Message.msg.number,
    digits      : Message.msg.digits,
    equalTo     : Message.msg.equalTo,

    maxlength   : $.validator.format(Message.msg.maxlength),
    minlength   : $.validator.format(Message.msg.minlength),
    rangelength : $.validator.format(Message.msg.rangelength),
    range       : $.validator.format(Message.msg.range),
    max         : $.validator.format(Message.msg.max),
    min         : $.validator.format(Message.msg.range),
    maxByte     : $.validator.format(Message.msg.maxByte),
    mixByte     : $.validator.format(Message.msg.mixByte),
    
    alphabetic  : Message.msg.alphabetic,
    alphalower  : Message.msg.alphalower,
    alphanumeric: Message.msg.alphanumeric,
    alphaupper  : Message.msg.alphaupper,

    nowhitespace: Message.msg.nowhitespace,

    pattern     : Message.msg.pattern,
    remote      : Message.msg.remote,
    dateISO     : Message.msg.dateISO,
    creditcard  : Message.msg.creditcard,
    accept      : Message.msg.accept

});