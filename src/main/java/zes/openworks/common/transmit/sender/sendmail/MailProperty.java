package zes.openworks.common.transmit.sender.sendmail;

import zes.core.spi.commons.configuration.Config;

/**
 * <p>
 * 메일 전송에 필요한 정보를 가지고 있는 저장소
 * </p>
 * 
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: MailProperty.java 23 2011-07-13 05:20:04Z oworks $
 */
public final class MailProperty {

    static final String CHAR_SET = Config.getString("encoding");
    static final String MAIL_HOST = Config.getString("sender.mailServer");
    static final String MAIL_PORT = Config.getString("sender.mailPort");
    static final String MAIL_SENDER = Config.getString("sender.senderNm") + " <" + Config.getString("sender.senderEmail") + ">";

    static final boolean IS_SSL = Config.getBoolean("sender.isSsl");
    static final boolean IS_DEBUG = Config.getBoolean("sender.isDebug");

    static final String MAIL_ID = Config.getString("sender.mailId");
    static final String MAIL_PASSWORD = Config.getString("sender.mailPassword");
}
