package subscribers;

import events.AbstractEvent;

import pubSubServer.SubscriptionManager;
import states.subscriber.IState;
import states.subscriber.StateFactory;
import states.subscriber.StateName;


/**
 * @author kkontog, ktsiouni, mgrigori
 * an example concrete subscriber
 */
class SubscriberMan extends AbstractSubscriber {

	protected IState state;
	protected int ID;
	protected SubscriberMan(int id,StateName stateName) {
		state = StateFactory.createState(stateName);
		ID=id;
	}
	/* (non-Javadoc)
	 * @see subscribers.ISubscriber#setState(states.subscriber.StateName)
	 */
	public void setState(StateName stateName) {
		state = StateFactory.createState(stateName);
	}
	
	
	/* (non-Javadoc)
	 * @see subscribers.ISubscriber#alert(events.AbstractEvent, java.lang.String)
	 */
	@Override
	public void alert(AbstractEvent event, String channelName) {
		System.out.println("Subscriber " + this.ID + " handling event ::" + event.ID() + ":: published on channel " + channelName);
		state.handleEvent(event, channelName);
	}

	/* (non-Javadoc)
	 * @see subscribers.ISubscriber#subscribe(java.lang.String)
	 */
	@Override
	public void subscribe(String channelName) {
		SubscriptionManager.getInstance().subscribe(channelName, this);		
	}

	/* (non-Javadoc)
	 * @see subscribers.ISubscriber#unsubscribe(java.lang.String)
	 */
	@Override
	public void unsubscribe(String channelName) {
		SubscriptionManager.getInstance().subscribe(channelName, this);
		
	}
	public IState state() {
		return state;
	}
	
	public SubscriberType type() {
		return SubscriberType.man;
	}
	public int getID() {
		return ID;
	}


	
	
}
