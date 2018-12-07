package zes.base.spring.multipart;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.util.Assert;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import zes.openworks.common.GlobalConfig;
import zes.openworks.common.filter.support.XssMultipartHttpServletRequest;

public class CustomMultipartResolver extends CommonsFileUploadSupport
    implements MultipartResolver, ServletContextAware {

    private boolean resolveLazily = false;

    /**
     * Constructor for use as bean. Determines the servlet container's
     * temporary directory via the ServletContext passed in as through the
     * ServletContextAware interface (typically by a WebApplicationContext).
     * 
     * @see #setServletContext
     * @see org.springframework.web.context.ServletContextAware
     * @see org.springframework.web.context.WebApplicationContext
     */
    public CustomMultipartResolver() {
        super();
    }

    /**
     * Constructor for standalone usage. Determines the servlet container's
     * temporary directory via the given ServletContext.
     * 
     * @param servletContext the ServletContext to use
     */
    public CustomMultipartResolver(ServletContext servletContext) {
        this();
        setServletContext(servletContext);
    }

    /**
     * Set whether to resolve the multipart request lazily at the time of
     * file or parameter access.
     * <p>
     * Default is "false", resolving the multipart elements immediately,
     * throwing corresponding exceptions at the time of the
     * {@link #resolveMultipart} call. Switch this to "true" for lazy multipart
     * parsing, throwing parse exceptions once the application attempts to
     * obtain multipart files or parameters.
     */
    public void setResolveLazily(boolean resolveLazily) {
        this.resolveLazily = resolveLazily;
    }

    /**
     * Initialize the underlying
     * <code>org.apache.commons.fileupload.servlet.ServletFileUpload</code>
     * instance. Can be overridden to use a custom subclass, e.g. for testing
     * purposes.
     * 
     * @param fileItemFactory the Commons FileItemFactory to use
     * @return the new ServletFileUpload instance
     */
    @Override
    protected FileUpload newFileUpload(FileItemFactory fileItemFactory) {
        return new ServletFileUpload(fileItemFactory);
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        if(!isUploadTempDirSpecified()) {
            getFileItemFactory().setRepository(WebUtils.getTempDir(servletContext));
        }
    }

    @Override
    public boolean isMultipart(HttpServletRequest request) {
        return (request != null && ServletFileUpload.isMultipartContent(request));
    }

    /**
     * XssMultipartHttpServletRequest 클레스는 XSS 취약점 보안 적용 클레스이다.
     */
    @Override
    public MultipartHttpServletRequest resolveMultipart(final HttpServletRequest request)
        throws MultipartException {

        Assert.notNull(request, "Request must not be null");

        // XSS 보안 취약점 보안 대상인 경우 Request 객체를 변경한다.
        if(isTarget(request)) {

            if(this.resolveLazily) {
                return new XssMultipartHttpServletRequest(request) {

                    @Override
                    protected void initializeMultipart() {
                        MultipartParsingResult parsingResult = parseRequest(request);
                        setMultipartFiles(parsingResult.getMultipartFiles());
                        setMultipartParamMap(parsingResult.getMultipartParameters());
                        /*-- Added by openworks --*/
                        request.setAttribute(GlobalConfig.FILE_LIST_KEY, parsingResult.getMultipartList());
                    }
                };
            }
            MultipartParsingResult parsingResult = parseRequest(request);
            /*-- Added by openworks --*/
            request.setAttribute(GlobalConfig.FILE_LIST_KEY, parsingResult.getMultipartList());

            return new XssMultipartHttpServletRequest(
                request, parsingResult.getMultipartFiles(), parsingResult.getMultipartParameters());

        }

        if(this.resolveLazily) {
            return new DefaultMultipartHttpServletRequest(request) {

                @Override
                protected void initializeMultipart() {
                    MultipartParsingResult parsingResult = parseRequest(request);
                    setMultipartFiles(parsingResult.getMultipartFiles());
                    setMultipartParameters(parsingResult.getMultipartParameters());
                    /*-- Added by openworks --*/
                    request.setAttribute(GlobalConfig.FILE_LIST_KEY, parsingResult.getMultipartList());
                }
            };
        } else {
            MultipartParsingResult parsingResult = parseRequest(request);
            /*-- Added by openworks --*/
            request.setAttribute(GlobalConfig.FILE_LIST_KEY, parsingResult.getMultipartList());

            return new DefaultMultipartHttpServletRequest(
                request, parsingResult.getMultipartFiles(), parsingResult.getMultipartParameters());
        }

    }

    /**
     * web.xml 파일의 XssFilter 설정에서 대상 URI를 설정하고, 그에 따라 적용여부를 결정한다.
     * 
     * @param req
     * @return
     */
    private boolean isTarget(HttpServletRequest request) {

        String uri = request.getRequestURI();
        String includeUri = request.getSession().getServletContext().getInitParameter("XssInclude");

        if(includeUri != null) {
            String[] arrExclude = includeUri.split(",");

            for(String exclude : arrExclude) {
                exclude = exclude.trim();
                if(uri.startsWith(exclude)) {
                    return Boolean.TRUE;
                }
            }
        }
        return Boolean.FALSE;
    }

    /**
     * Parse the given servlet request, resolving its multipart elements.
     * 
     * @param request the request to parse
     * @return the parsing result
     * @throws MultipartException if multipart resolution failed.
     */
    @SuppressWarnings("unchecked")
    protected MultipartParsingResult parseRequest(HttpServletRequest request)
        throws MultipartException {
        String encoding = determineEncoding(request);
        FileUpload fileUpload = prepareFileUpload(encoding);
        try {
            List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
            return parseFileItems(fileItems, encoding);
        } catch (FileUploadBase.SizeLimitExceededException ex) {
            throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
        } catch (FileUploadException ex) {
            throw new MultipartException("Could not parse multipart servlet request", ex);
        }
    }

    /**
     * Determine the encoding for the given request.
     * Can be overridden in subclasses.
     * <p>
     * The default implementation checks the request encoding, falling back to
     * the default encoding specified for this resolver.
     * 
     * @param request current HTTP request
     * @return the encoding for the request (never <code>null</code>)
     * @see javax.servlet.ServletRequest#getCharacterEncoding
     * @see #setDefaultEncoding
     */
    protected String determineEncoding(HttpServletRequest request) {
        String encoding = request.getCharacterEncoding();
        if(encoding == null) {
            encoding = getDefaultEncoding();
        }
        return encoding;
    }

    @Override
    @SuppressWarnings("unchecked")
    public void cleanupMultipart(MultipartHttpServletRequest request) {

        if(request != null) {
            try {
                /*-- Modified by wisepms
                cleanupFileItems(request.getFileMap().values());
                --*/

                cleanupFileItems((List<MultipartFile>) request
                    .getAttribute(GlobalConfig.FILE_LIST_KEY));
            } catch (Throwable ex) {
                logger.warn("Failed to perform multipart cleanup for servlet request", ex);
            }
        }
    }
}
