package states.subscriber;

import java.util.LinkedList;

import events.AbstractEvent;

public class StateTransport implements IState{
//	state A  means subscribers like cars the planes channel and the event of this channel
	protected LinkedList<AbstractEvent> favor = new LinkedList<AbstractEvent>();
	@Override
	public void handleEvent(AbstractEvent event, String channelName) {
		// TODO Auto-generated method stub
		if(channelName.equals("cars") || channelName.equals("planes")) {
			favor.add(event);
		}
	}
	public StateName state() {
		return StateName.transport;
	}
	
	public String toString() {
		return StateName.transport.toString();
	}
}