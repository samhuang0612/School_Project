/*Student name : Lishan Huang
Student number : 250777962*/
import java.util.LinkedList;
public class uandf {
	private LinkedList<NodeSet> store= new LinkedList<NodeSet>();
	public uandf(int n){
		for(int i=1;i<=n;i++) {
			NodeSet a = this.make_set(i);
			store.add(a);
		}	
	}
	public LinkedList<NodeSet> store(){
		return store;
	}
	
	public NodeSet make_set(int i) {
		NodeSet a =new NodeSet(i);
		return a;
	}
	
	public void union_sets(int i, int j) {
		 this.link(find_set(store.get(i-1)),find_set(store.get(j-1)));

	} 
	
	public void link(NodeSet x, NodeSet y) {
		if (x.rank>y.rank) {
			y.parent=x;
		}else if(x.rank<y.rank) {
			x.parent=y;
		}else {
			y.parent=x;
			x.rank++;
		}	
	}
	
	public  NodeSet find_set(NodeSet i) {
		if(i.self!=i.parent.self) {
			i.parent=find_set(i.parent);
		}
		return i.parent;
	}
	int number=0;
	public int final_sets() {
		for(int i=0; i<store.size();i++) {
			this.find_set(store.get(i));
		}
		
		for(int i=0; i<store.size();i++) {
			if(store.get(i).parent.self == store.get(i).self) {
				number++;
			}	
	}
		return number;
}
	public void remove(int i) {
		store.remove(i);
	}

}