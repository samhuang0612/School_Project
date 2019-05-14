package events;


/**
 * @author kkontog, ktsiouni, mgrigori 
 *
 */
public abstract class AbstractEvent {
	private long eventId = -1;
	private int eventPublisherId;
	private long ID;
	private EventMessage payload = null;
	
	/**
	 * Default Constructor for the abstract class AbstractEvent
	 * @param eventID must be a number of type long generated from the {@link EventIDMaker#getNewEventID()} method 
	 * @param eventPublisher must be a number (currently is the hashCode of the object) designating the object issuing the event
	 * @param payload is a {@link EventMessage} which contains a title and a message for the event. Normally there should be a rich hierarchy of 
	 * EventMessage types.
	 */
	public AbstractEvent(long eventID, int eventPublisher, EventMessage payload) {
		this.eventId = eventID;
		this.eventPublisherId = eventPublisher;
		this.payload = payload;
	}
	public long ID() {
		return ID;
	}
	
	/**
	 * 
	 * @return a long value designating the EventType
	 */
	public long getEventType() {
		return eventId;
	}
	
	
	/**
	 * 
	 * @return Event Publisher's hashcode
	 */
	public int getEventPublisher() {
		return eventPublisherId;
	}
	
	
	/**
	 * 
	 * @return an object of the Class {@link EventMessage}
	 */
	public EventMessage getPayload() {
		return payload;
	}
	
	
	
	
}
