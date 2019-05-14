package states.subscriber;

import java.util.LinkedList;

import events.AbstractEvent;

public class StateUnset implements IState{
//	state A  means subscribers like main the general channel and the event of this channel
	private String statename = "unset";
	protected LinkedList<AbstractEvent> favor = new LinkedList<AbstractEvent>();
	@Override
	public void handleEvent(AbstractEvent event, String channelName) {
		// TODO Auto-generated method stub
		if(channelName.equals("general") || channelName.equals("main")) {
			favor.add(event);
		}
	}
		
	public boolean unset(){
		return true;
	}
	public boolean food() {
		return false;
	}
	public boolean transport() {
		return false;
	}
	public boolean all() {
		return false;
	}
	public StateName state() {
		return StateName.unset;
	}
	
	public String getname() {
		return StateName.unset.toString();
	}
	
	
}