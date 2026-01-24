
package service.web.kaituo.org;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for anonymous complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="RegID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SendID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "regID", "sendID" })
@XmlRootElement(name = "query")
public class Query {

	@XmlElementRef(name = "RegID", namespace = "http://service.web.kaituo.org", type = JAXBElement.class)
	protected JAXBElement<String> regID;
	@XmlElementRef(name = "SendID", namespace = "http://service.web.kaituo.org", type = JAXBElement.class)
	protected JAXBElement<String> sendID;

	/**
	 * Gets the value of the regID property.
	 * 
	 * @return possible object is {@link JAXBElement }{@code <}{@link String
	 *         }{@code >}
	 * 
	 */
	public JAXBElement<String> getRegID() {
		return regID;
	}

	/**
	 * Sets the value of the regID property.
	 * 
	 * @param value
	 *            allowed object is {@link JAXBElement }{@code <}{@link String
	 *            }{@code >}
	 * 
	 */
	public void setRegID(JAXBElement<String> value) {
		this.regID = ((JAXBElement<String>) value);
	}

	/**
	 * Gets the value of the sendID property.
	 * 
	 * @return possible object is {@link JAXBElement }{@code <}{@link String
	 *         }{@code >}
	 * 
	 */
	public JAXBElement<String> getSendID() {
		return sendID;
	}

	/**
	 * Sets the value of the sendID property.
	 * 
	 * @param value
	 *            allowed object is {@link JAXBElement }{@code <}{@link String
	 *            }{@code >}
	 * 
	 */
	public void setSendID(JAXBElement<String> value) {
		this.sendID = ((JAXBElement<String>) value);
	}

}
