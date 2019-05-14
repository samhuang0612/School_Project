package subscribers;


/**
 * @author kkontog, ktsiouni, mgrigori 
 *
 */
public class SubscriberIDMaker {

	private static int subscriberIDs = 0;
	
	/**
	 * 
	 * @return the next number of type {@link long}in the series of UID for the AbstractEvent derived classes
	 */
	protected static int getNewEventID() {
		return subscriberIDs++;
	}
	
}
