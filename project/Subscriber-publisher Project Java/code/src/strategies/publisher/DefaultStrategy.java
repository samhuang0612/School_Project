package strategies.publisher;

import java.util.ArrayList;
import java.util.List;

import events.AbstractEvent;
import events.EventFactory;
import events.*;
import pubSubServer.ChannelEventDispatcher;

public class DefaultStrategy implements IStrategy {

	int publisherId;
	AbstractEvent event;
	int strategy;
	List<String> channelListPub;		//list to store general channel
	List<String> mainChannelList;		//list to store main channel(default channel)
	public DefaultStrategy() {
		 mainChannelList = new ArrayList<>();
		 channelListPub = new ArrayList<>() ;
			mainChannelList.add("main");
			channelListPub.add("general");
	}

	@Override
	public void doPublish(int publisherId) {
		this.publisherId=publisherId;
		AbstractEvent dEvent = EventFactory.createEvent(EventType.typeDefault, publisherId, null);
		System.out.println("Publisher "+this.publisherId+" publishes event "+ dEvent.ID() + " successfully.");
		System.out.println(" Here is how subscribers handle notification: ");
		ChannelEventDispatcher.getInstance().postEvent(dEvent, mainChannelList);
		
	}

	@Override
	public void doPublish(AbstractEvent event, int publisherId) {
		this.publisherId=publisherId;
		this.event=event;
		System.out.println("Publisher "+this.publisherId+" publishes event "+ event.ID() + " successfully.");
		System.out.println(" Here is how subscribers handle notification: ");
		ChannelEventDispatcher.getInstance().postEvent(event, channelListPub);
		ChannelEventDispatcher.getInstance().postEvent(event, mainChannelList);

	}
	public int getpid() {
		return publisherId;
	}
	public List<String> getMainList(){
		return mainChannelList;
	}
}
