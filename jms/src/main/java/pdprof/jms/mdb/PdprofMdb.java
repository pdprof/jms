package pdprof.jms.mdb;

import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.jms.Message;
import javax.jms.MessageListener;

/**
 * Message-Driven Bean implementation class for: PdprofMdb
 */
@MessageDriven(
		activationConfig = { @ActivationConfigProperty(
				propertyName = "destinationType", propertyValue = "javax.jms.Queue")
		})
public class PdprofMdb implements MessageListener {

    /**
     * Default constructor. 
     */
    public PdprofMdb() {
    }
	
	/**
     * @see MessageListener#onMessage(Message)
     */
    public void onMessage(Message message) {
		System.out.println("PdprofMdb.onMessage() - Message Received : " + message);
    }

}
