package zes.core.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AbstractTraceInterceptor;

public class MakeExcel {
    static final Logger LOGGER = LoggerFactory.getLogger(AbstractTraceInterceptor.class);

    public MakeExcel() {}

    public String get_Filename() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddmmmm");
        return ft.format(new Date());
    }

    public String get_Filename(String pre) {
        return pre + get_Filename();
    }
    
    /**
     * Make Excel & Download. 
     */
    
    public void download(HttpServletRequest request, HttpServletResponse response, Map<String , Object> beans, String filename, String templateFile) {
        String tempPath = request.getSession().getServletContext().getRealPath("/WEB-INF/templete") ;
        
        try {
            InputStream is = new BufferedInputStream(new FileInputStream(tempPath + "/" + templateFile));
            XLSTransformer transformer = new XLSTransformer();
            Workbook resultWorkbook = transformer.transformXLS(is, beans);
            response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(filename,"UTF-8") + ".xlsx\"");
            
            OutputStream os = response.getOutputStream();
            resultWorkbook.write(os);
        } catch (Exception ex) {
            LOGGER.error("MakeExcel");
        }
    }
}