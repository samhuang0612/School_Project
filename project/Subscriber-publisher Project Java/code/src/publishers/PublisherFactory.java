package publishers;

import strategies.publisher.StrategyFactory;
import strategies.publisher.StrategyName;
import subscribers.SubscriberIDMaker;


/**
 * @author kkontog, ktsiouni, mgrigori
 * creates new {@link AbstractPublisher} objects
 * contributes to the Strategy design pattern
 * implements the FactoryMethod design pattern   
 */
public class PublisherFactory {

	
	/**
	 * This is an implementation of the Factory Method design pattern
	 * Creates an instance of any of the classes implementing the top level Interface IPublisher
	 * 
	 * note we have multiple entries that return instances of the same ConcretePublisher class
	 * 
	 * @param publisherType an entry from the {@link PublisherType} enumeration
	 * @param strategyName an entry from the {@link StrategyName} enumeration
	 * @return an instance of the specified IPublisher implementation with the specified strategyName attached to it
	 */
	public static AbstractPublisher createPublisher(PublisherType publisherType, StrategyName strategyName) {
		AbstractPublisher ip;
		 int id =PublisherIDMaker.getNewEventID();
		switch (publisherType) {
			case Food : 
				ip = new FoodPublisher(id,StrategyFactory.createStrategy(strategyName));
				System.out.println("Publisher "+ip.getID()+" created.");
				System.out.println("Publisher "+ip.getID()+" has strategy "+strategyName.toString());
				return ip;
			case Transport : 
				ip = new TransportPublisher(id,StrategyFactory.createStrategy(strategyName));
				System.out.println("Publisher "+ip.getID()+" created.");
				System.out.println("Publisher "+ip.getID()+" has strategy "+strategyName.toString());
				return ip;
			case Manager : 
				ip = new ManagerPublisher(id,StrategyFactory.createStrategy(strategyName));
				System.out.println("Publisher "+ip.getID()+" created.");
				System.out.println("Publisher "+ip.getID()+" has strategy "+strategyName.toString());
				return ip;
			default:
				ip = new GeneralPublisher(id,StrategyFactory.createStrategy(strategyName));
				System.out.println("Publisher "+ip.getID()+" created.");
				System.out.println("Publisher "+ip.getID()+" has strategy "+strategyName.toString());
				return ip;
		}
	}
	
}
