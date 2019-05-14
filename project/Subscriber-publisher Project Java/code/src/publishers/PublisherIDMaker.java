package publishers;


/**
 * @author kkontog, ktsiouni, mgrigori 
 *
 */
public class PublisherIDMaker {

	private static int publisherIDs = 0;
	
	/**
	 * 
	 * @return the next number of type {@link long}in the series of UID for the AbstractEvent derived classes
	 */
	protected static int getNewEventID() {
		return publisherIDs++;
	}
	
}
