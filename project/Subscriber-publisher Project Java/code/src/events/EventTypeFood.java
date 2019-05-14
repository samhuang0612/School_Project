package events;
import events.EventType;


/**
 * @author kkontog, ktsiouni, mgrigori
 * sample event type, simply creates a new event using the constructor 
 * {@link AbstractEvent#AbstractEvent(long, int, EventMessage)}   
 */
class EventTypeFood extends AbstractEvent {
	private long ID;
	private EventMessage py;
	private int epid;
	/**
	 * shouldn't be used outside the EventFactory
	 * for information on how to call it and what the parameters are please look 
	 * at the documentation {@link EventFactory#createEvent(EventType, int, EventMessage)}
	 * 
	 * @param eventID
	 * @param eventPublisherId
	 * @param payload
	 */
	protected EventTypeFood(long eventID, int eventPublisherId, EventMessage payload) {
		super(eventID, eventPublisherId, payload);
		ID = eventID;
		py=payload;
		epid=eventPublisherId;
	}
	public long ID() {
		return ID;
	}
	protected EventMessage payload() {
		return py;
	}
	protected EventType type() {
		return EventType.food;
	}


}
