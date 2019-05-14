package orchestration;

import java.io.BufferedReader;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import events.AbstractEvent;
import events.EventFactory;
import events.EventMessage;
import events.EventType;
import pubSubServer.AbstractChannel;
import pubSubServer.ChannelAccessControl;
import pubSubServer.*;
import pubSubServer.ChannelDiscovery;
import pubSubServer.SubscriptionManager;
import publishers.AbstractPublisher;
import publishers.PublisherFactory;
import publishers.PublisherType;
import states.subscriber.StateName;
import strategies.publisher.StrategyName;
import subscribers.AbstractSubscriber;
import subscribers.*;
import subscribers.SubscriberFactory;
import subscribers.SubscriberType;

public class OrchestrationTest1  {
	static HashMap<Integer,AbstractPublisher> MapPublishers;
	static HashMap<Integer,AbstractSubscriber> MapSubscibers;
	private static List<AbstractChannel> channels;
	private static List<AbstractPublisher> listOfPublishers = new ArrayList<>();
	private static List<AbstractSubscriber> listOfSubscribers = new ArrayList<>();
	
	public static void main(String[] args) throws NumberFormatException, IOException {

		
		//List<ConcreteSubscriberA> listOfSubscribers = new ArrayList<>();
		OrchestrationTest1 testHarness = new OrchestrationTest1();
		
		try {
			listOfPublishers = testHarness.createPublishers();
			listOfSubscribers = testHarness.createSubscribers();
			System.out.println("Create Channel: ");
			 channels = ChannelDiscovery.getInstance().listChannels();
			System.out.println("----------------------------------");
			//For demonstration purposes only
			try {
				
			BufferedReader initialChannels = new BufferedReader(new FileReader(new File("Channels.chl")));
			List<String> channelList = new ArrayList<String>();
			String line = "";
			while((line = initialChannels.readLine()) != null )
				channelList.add(line);
			int subscriberIndex = 0;
		//	for(ConcreteSubscriberA subscriber : listOfSubscribers) {
			System.out.println("Subscriber subscribe channel: ");
			for(AbstractSubscriber subscriber : listOfSubscribers) {
				//System.out.print(listOfSubscribers);
				subscriber.subscribe(channelList.get(subscriberIndex%channelList.size()));
				subscriberIndex++;
				
			}
			System.out.println("----------------------------------");
			initialChannels.close();
			}catch(IOException ioe) {
				System.out.println("Loading Channels from file failed proceeding with random selection");
				for(AbstractSubscriber subscriber : listOfSubscribers) {
					int index = (int) Math.round((Math.random()*10))/3;
					SubscriptionManager.getInstance().subscribe(channels.get(index).getChannelTopic(), subscriber);
				}
			}
			for(AbstractPublisher publisher : listOfPublishers) {
				publisher.publish();
			}
			
		} catch (IOException ioe) {
			System.out.println(ioe.getMessage());
			System.out.println("Will now terminate");
			return;
		}
		for(AbstractPublisher publisher : listOfPublishers) {
			publisher.publish();
		}

		BufferedReader TestBufferedReader = new BufferedReader(new FileReader(new File("input.txt")));
		while(TestBufferedReader.ready()) {
			
			String testConfigLine = TestBufferedReader.readLine();
            
			String[] stringspliter = testConfigLine.split("\"");
					
			String command = stringspliter[0];
			//String[] readcommand = command.split(" "); 
			String[] testArray = command.split(" ");
			
			
			if(testArray[0].equals("SUB")) {
				//command: SUB <subscriber-ID> <channel-name>
				int subscriberid= Integer.parseInt(testArray[1]);
				if(MapSubscibers.containsKey(Integer.parseInt(testArray[1]))) {
				//set all new subscriber's state to unset(i.e. 2)
				AbstractSubscriber Sub = MapSubscibers.get(Integer.parseInt(testArray[1]));
				SubscriptionManager manager=SubscriptionManager.getInstance();
				manager.subscribe(testArray[2], Sub);
				}else {
					System.out.println("Subscriber " + testArray[1] + " does not exist.");
				}
			}
			if(testArray[0].equals("PUB") ){
				if(stringspliter.length>2) {
					int pubid = Integer.parseInt(testArray[1]);
					EventType type = EventType.values()[Integer.parseInt(testArray[2])];
					String emh = stringspliter[1];
					String emp = stringspliter[3];
					if(MapPublishers.containsKey(pubid)){
						EventMessage emsg =new EventMessage(emh,emp);
						AbstractEvent myEvent =null;
						myEvent = EventFactory.createEvent(type,pubid,emsg);
						AbstractPublisher mypub = MapPublishers.get(pubid);
			       		mypub.publish(myEvent);
					}else {
						System.out.println("Publisher "+ pubid + " does not exist");
					}
				}
				else {
					int pubid = Integer.parseInt(testArray[1]);
					if(MapPublishers.containsKey(pubid )) {
						AbstractPublisher mypub =MapPublishers.get(pubid);
						mypub.publish();
					}else {
						System.out.println("Publisher "+pubid + " does not exist");
					}
				}
			}
			if(testArray[0].equals("BLOCK")) {
				if(MapSubscibers.containsKey(Integer.parseInt(testArray[1]))) {
					if(!ChannelAccessControl.getInstance().checkIfBlocked(MapSubscibers.get(Integer.parseInt(testArray[1])),testArray[2])) {
						ChannelAccessControl.getInstance().blockSubcriber(MapSubscibers.get(Integer.parseInt(testArray[1])),testArray[2]);}
				}
	
					}
			
			//	AbstractSubscriber as= listOfSubscribers.get(Integer.parseInt(testArray[1]));
				
			if(testArray[0].equals("UNBLOCK")) {
					if( MapSubscibers.containsKey(Integer.parseInt(testArray[1]))) {
					if(ChannelAccessControl.getInstance().checkIfBlocked(MapSubscibers.get(Integer.parseInt(testArray[1])),testArray[2]))
						ChannelAccessControl.getInstance().unBlockSubscriber(MapSubscibers.get(Integer.parseInt(testArray[1])),testArray[2]);
					}
		
				
			}
		}
		TestBufferedReader.close();
		
	}

	
	private List<AbstractPublisher> createPublishers() throws IOException{
		System.out.println("Create publishers :");
		MapPublishers = new HashMap<Integer,AbstractPublisher>();
		listOfPublishers = new ArrayList<>();
		AbstractPublisher newPub;
		int ID=0;
		BufferedReader StrategyBufferedReader = new BufferedReader(new FileReader(new File("Strategies.str")));
		while(StrategyBufferedReader.ready()) {
			String PublisherConfigLine = StrategyBufferedReader.readLine();
			String[] PublisherConfigArray = PublisherConfigLine.split("\t");
			int[] PublisherConfigIntArray = new int[2];
			for(int i = 0; i < PublisherConfigArray.length; i++)
				PublisherConfigIntArray[i] = Integer.parseInt(PublisherConfigArray[i]);
			newPub = PublisherFactory.createPublisher(
					PublisherType.values()[PublisherConfigIntArray[0]],
					StrategyName.values()[PublisherConfigIntArray[1]]);
			listOfPublishers.add(newPub);
			MapPublishers.put(ID++, newPub);
		}
		StrategyBufferedReader.close();
		System.out.println("----------------------------------");
		return listOfPublishers;
	}
	
	private List<AbstractSubscriber> createSubscribers() throws IOException{
	System.out.println("Create subscribers :");

		 MapSubscibers = new HashMap<Integer,AbstractSubscriber>();
		//private List<ConcreteSubscriberA> createSubscribers() throws IOException{
		listOfSubscribers = new ArrayList<>();
	//	List<ConcreteSubscriberA > listOfSubscribers = new ArrayList<>();
		AbstractSubscriber newSub;
		int ID=0;
		
	//	ConcreteSubscriberA newSub;
		BufferedReader StateBufferedReader = new BufferedReader(new FileReader(new File("States.sts")));
		while(StateBufferedReader.ready()) {
			String StateConfigLine = StateBufferedReader.readLine();
			String[] StateConfigArray = StateConfigLine.split("\t");
			int[] StateConfigIntArray = new int[2];
			for(int i = 0; i < StateConfigArray.length; i++)
				StateConfigIntArray[i] = Integer.parseInt(StateConfigArray[i]);
			newSub = SubscriberFactory.createSubscriber(
					SubscriberType.values()[StateConfigIntArray[0]], 
					StateName.values()[StateConfigIntArray[1]]);
			listOfSubscribers.add(newSub);
			MapSubscibers.put(ID++,newSub);
		}
		StateBufferedReader.close();
		System.out.println("----------------------------------");
		return listOfSubscribers;
	}

	
	
	
}
