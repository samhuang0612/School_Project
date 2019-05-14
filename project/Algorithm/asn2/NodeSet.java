/*Student name : Lishan Huang
Student number : 250777962*/
public class NodeSet{
	public NodeSet parent;
	public int self;
	public int rank;	
	public NodeSet(int i) {	
		self=i;
		rank=0;
		parent=this;
	}
}