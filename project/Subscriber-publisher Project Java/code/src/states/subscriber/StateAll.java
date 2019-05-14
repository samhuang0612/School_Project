package states.subscriber;

import java.util.LinkedList;

import events.AbstractEvent;

public class StateAll implements IState{
//	state A  means subscribers like food the food channel and the event of this channel
    protected LinkedList<AbstractEvent> favor = new LinkedList<AbstractEvent>();
	@Override
	public void handleEvent(AbstractEvent event, String channelName) {
		// TODO Auto-generated method stub
			favor.add(event);
	}
	public boolean transport (){
		return false;
	}
	public boolean all() {
		return true;
	}
	public boolean unset() {
		return false;
	}
	public boolean food() {
		return false;
	}
	public StateName state() {
		return StateName.all;
	}
	public String toString() {
		return StateName.all.toString();
	}
	
	
	
}