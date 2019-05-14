package subscribers;

import events.EventIDMaker;
import states.subscriber.StateName;
import subscribers.SubscriberMan;
import subscribers.SubscriberType;


/**
 * @author kkontog, ktsiouni, mgrigori
 *  
 */
/**
 * @author kkontog, ktsiouni, mgrigori
 * creates new {@link AbstractSubscriber} objects
 * contributes to the State design pattern
 * implements the FactoryMethod design pattern   
 */
public class SubscriberFactory {

	
	/**
	 * creates a new {@link AbstractSubscriber} using an entry from the {@link SubscriberType} enumeration
	 * @param subscriberType a value from the {@link SubscriberType} enumeration specifying the type of Subscriber to be created 
	 * @return the newly created {@link AbstractSubscriber} instance 
	 */
	public static AbstractSubscriber createSubscriber(SubscriberType subscriberType, StateName stateName) {
       int id =SubscriberIDMaker.getNewEventID();
       System.out.println("Subscriber "+ id + " type "+ subscriberType.toString() + " is created");
	   System.out.println("Subscriber "+ id + " type "+ subscriberType.toString() + " is on state "+ stateName.toString());
		switch (subscriberType) {
			case man : 
				return new SubscriberMan(id,stateName);
			case woman :
				return new SubscriberWoman(id,stateName);
			default :
				return new SubscriberUnset(id,stateName);
		}
	}
	
}
