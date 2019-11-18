
public class BinaryNode {
//create the variable this class need;
	private Pixel val;
	private BinaryNode lef,rig,par;
	public BinaryNode (Pixel value, BinaryNode left, BinaryNode right, BinaryNode parent) {
//initialize all the variable with the argument;
		val=value;
		lef=left;
		rig=right;
		par=parent;
	}
	public BinaryNode () {
		//initialize all the variable 
		val=null;
		lef=null;
		rig=null;
		par=null;
	}
	//return the parent node;
	public BinaryNode getParent() {
		return this.par;
		
	}
	//set parent node
	public void setParent(BinaryNode parent) {
		this.par=parent;
		
	}
	//set left child ;
	public void setLeft (BinaryNode p) {
		this.lef=p;
		
	}
	//set right child
	public void setRight (BinaryNode p) {
		this.rig=p;
	}
	//set the Pixel
	public void setData (Pixel value) {
		this.val=value;
		
	}
	//boolean whether is leaf or not by check the value of pixel if is return true or return false
	public boolean isLeaf() {
		if(this.val==null) {
			return true;
		}else {
			return false;
		}
		
	}
	//return the pixel of Node
	public Pixel getData () {
		return this.val;
		
	}
	//return the left child
	public BinaryNode getLeft() {
		return this.lef;
		
	}
	//return the right child
	public BinaryNode getRight() {
		return this.rig;
		
	}
}
