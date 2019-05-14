package states.subscriber;

import java.util.LinkedList;

import events.AbstractEvent;

public class StateFood implements IState{
//	state A  means subscribers like food the food channel and the event of this channel
    protected LinkedList<AbstractEvent> favor = new LinkedList<AbstractEvent>();
	@Override
	public void handleEvent(AbstractEvent event, String channelName) {
		// TODO Auto-generated method stub
		if(channelName.equals("food") || channelName.equals("snack")) {
			favor.add(event);
		}
	}
	public StateName state() {
		return StateName.food;
	}
	public String toString() {
		return StateName.food.toString();
	}
	
}