package publishers;

import events.AbstractEvent;
import strategies.publisher.IStrategy;
import strategies.publisher.StrategyFactory;


/**
 * @author kkontog, ktsiouni, mgrigori
 * 
 * the WeatherPublisher class is an example of a ConcretePublisher 
 * implementing the IPublisher interface. Of course the publish 
 * methods could have far more interesting logics
 */
public class FoodPublisher extends AbstractPublisher {
     int ID;
 	protected PublisherType type;
	
	
	
	
	/**
	 * @param concreteStrategy attaches a concreteStrategy generated from the {@link StrategyFactory#createStrategy(strategies.publisher.StrategyName)}
	 * method
	 */
	protected FoodPublisher(int id, IStrategy concreteStrategy) {
		this.publishingStrategy = concreteStrategy;
		ID=id;
		type=PublisherType.Food;
	}

	/* (non-Javadoc)
	 * @see publishers.IPublisher#publish(events.AbstractEvent)
	 */
	@Override
	public void publish(AbstractEvent event) {
		publishingStrategy.doPublish(event, this.getID());
		System.out.println("----------------------------------");
		System.out.println("");
	}

	/* (non-Javadoc)
	 * @see publishers.IPublisher#publish()
	 */
	@Override
	public void publish() {
		publishingStrategy.doPublish(this.getID());
		System.out.println("----------------------------------");
		System.out.println("");
	}
	public int getID() {
		return ID;
	}

}
