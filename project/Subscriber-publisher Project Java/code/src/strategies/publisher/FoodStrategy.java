package strategies.publisher;

import java.util.ArrayList;
import java.util.List;

import events.AbstractEvent;
import events.EventFactory;
import events.EventType;
import pubSubServer.ChannelEventDispatcher;
import publishers.AbstractPublisher;

public class FoodStrategy implements IStrategy {
	private int publisherId;
	private AbstractEvent event;
	private List<String> channelListPub;
	private DefaultStrategy ds;
	
	public FoodStrategy() {
		 ds = new DefaultStrategy();
		channelListPub = new ArrayList<>() ;
		channelListPub.add("food");
		channelListPub.add("snack");
	}
	
	/**
	 * Whenever a publisher's {@link AbstractPublisher#publish()} is called, the call is forwarded to the particular Publisher's
	 * IStrategy implementation of this method 
	 * @param publisherId the hashCode or any other unique identifier of the publisher of an AbstractEvent
	 */
	@Override
	public void doPublish(int publisherId) {
		this.publisherId=publisherId;
//		this.event= new AbstractEvent();
		AbstractEvent dEvent = EventFactory.createEvent(EventType.food, publisherId, null);	
		System.out.println("Publisher "+this.publisherId+" publishes event "+dEvent.ID() + " successfully.");
		System.out.println(" Here is how subscribers handle notification: ");
		ChannelEventDispatcher.getInstance().postEvent(dEvent, channelListPub);
		ChannelEventDispatcher.getInstance().postEvent(dEvent, ds.getMainList());
	}
	
	
	/**
	 * 
	 * Whenever a publisher's {@link AbstractPublisher#publish(Abs tractEvent)} is called, the call is forwarded to the particular Publisher's
	 * IStrategy implementation of this method
	 * 
	 * @param event the event to be published
	 * @param publisherId  the hashCode or any other unique identifier of the publisher of an AbstractEvent 
	 */
	@Override
	public void doPublish(AbstractEvent event, int publisherId) {
		this.publisherId=publisherId;
		this.event=event;
		System.out.println("Publisher "+this.publisherId+" publishes event "+event.ID() + " successfully.");
		System.out.println(" Here is how subscribers handle notification: ");
		ChannelEventDispatcher.getInstance().postEvent(event, channelListPub);
		ChannelEventDispatcher.getInstance().postEvent(event, ds.getMainList());

		
	}
	
	
	public int getpid() {
		return publisherId;
	}
}
