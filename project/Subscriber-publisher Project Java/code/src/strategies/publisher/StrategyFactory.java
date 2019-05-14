package strategies.publisher;

/**
 * @author kkontog, ktsiouni, mgrigori
 * creates new {@link IStrategy } objects
 * contributes to the Strategy design pattern
 * implements the FactoryMethod design pattern   
 */
public class StrategyFactory {

	
	/**
	 * creates a new {@link IStrategy} using an entry from the {@link StrategyName} enumeration
	 * @param strategyName a value from the {@link StrategyName} enumeration specifying the strategy to be created 
	 * @return the newly created {@link IStrategy} instance 
	 */
	public static IStrategy createStrategy(StrategyName strategyName) {
		IStrategy strategy;
		switch(strategyName) {
			case TransportStrategy:
				strategy = new TransportStrategy();
				return strategy;
			case ManagerStrategy:
				strategy = new ManagerStrategy();
				return strategy;
			case FoodStrategy:
				strategy = new FoodStrategy();
				return strategy;
			default:
				strategy = new DefaultStrategy();
				return strategy;
		}
	}
	
	
}
