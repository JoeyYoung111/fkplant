
package service.web.kaituo.org;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

/**
 * This object contains factory methods for each Java content interface and Java
 * element interface generated in the service.web.kaituo.org package.
 * <p>
 * An ObjectFactory allows you to programatically construct new instances of the
 * Java representation for XML content. The Java representation of XML content
 * can consist of schema derived interfaces and classes representing the binding
 * of schema type definitions, element declarations and model groups. Factory
 * methods for each of these are provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

	private final static QName _AcceptLogsSendID_QNAME = new QName("http://service.web.kaituo.org", "SendID");
	private final static QName _AcceptLogsLogs_QNAME = new QName("http://service.web.kaituo.org", "Logs");
	private final static QName _AcceptLogsLogType_QNAME = new QName("http://service.web.kaituo.org", "LogType");
	private final static QName _AcceptLogsRegID_QNAME = new QName("http://service.web.kaituo.org", "RegID");
	private final static QName _AcceptLogsResponseReturn_QNAME = new QName("http://service.web.kaituo.org", "return");

	/**
	 * Create a new ObjectFactory that can be used to create new instances of
	 * schema derived classes for package: service.web.kaituo.org
	 * 
	 */
	public ObjectFactory() {
	}

	/**
	 * Create an instance of {@link AcceptLogs }
	 * 
	 */
	public AcceptLogs createAcceptLogs() {
		return new AcceptLogs();
	}

	/**
	 * Create an instance of {@link AcceptLogsResponse }
	 * 
	 */
	public AcceptLogsResponse createAcceptLogsResponse() {
		return new AcceptLogsResponse();
	}

	/**
	 * Create an instance of {@link QueryResponse }
	 * 
	 */
	public QueryResponse createQueryResponse() {
		return new QueryResponse();
	}

	/**
	 * Create an instance of {@link Query }
	 * 
	 */
	public Query createQuery() {
		return new Query();
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "SendID", scope = AcceptLogs.class)
	public JAXBElement<String> createAcceptLogsSendID(String value) {
		return new JAXBElement<String>(_AcceptLogsSendID_QNAME, String.class, AcceptLogs.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "Logs", scope = AcceptLogs.class)
	public JAXBElement<String> createAcceptLogsLogs(String value) {
		return new JAXBElement<String>(_AcceptLogsLogs_QNAME, String.class, AcceptLogs.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "LogType", scope = AcceptLogs.class)
	public JAXBElement<String> createAcceptLogsLogType(String value) {
		return new JAXBElement<String>(_AcceptLogsLogType_QNAME, String.class, AcceptLogs.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "RegID", scope = AcceptLogs.class)
	public JAXBElement<String> createAcceptLogsRegID(String value) {
		return new JAXBElement<String>(_AcceptLogsRegID_QNAME, String.class, AcceptLogs.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "return", scope = AcceptLogsResponse.class)
	public JAXBElement<String> createAcceptLogsResponseReturn(String value) {
		return new JAXBElement<String>(_AcceptLogsResponseReturn_QNAME, String.class, AcceptLogsResponse.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "return", scope = QueryResponse.class)
	public JAXBElement<String> createQueryResponseReturn(String value) {
		return new JAXBElement<String>(_AcceptLogsResponseReturn_QNAME, String.class, QueryResponse.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "SendID", scope = Query.class)
	public JAXBElement<String> createQuerySendID(String value) {
		return new JAXBElement<String>(_AcceptLogsSendID_QNAME, String.class, Query.class, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link String
	 * }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://service.web.kaituo.org", name = "RegID", scope = Query.class)
	public JAXBElement<String> createQueryRegID(String value) {
		return new JAXBElement<String>(_AcceptLogsRegID_QNAME, String.class, Query.class, value);
	}

}
