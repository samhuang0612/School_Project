
public class BinarySearchTree implements BinarySearchTreeADT{
	//create the variable
    private BinaryNode root;
    
    public BinarySearchTree() {
    	//initialize variable 
    	Pixel abc=null;
    this.root = new BinaryNode (abc, null, null, null);
    }
    //return the root of this tree
	public BinaryNode getRoot() {
		// TODO Auto-generated method stub
		return root;
	}

//if the target Location is in the tree, then return the pixel of this location otherwise return null
	public Pixel get(BinaryNode r, Location key) {		
		if(r.isLeaf()) {
			return null;
		}else if(r.getData().getLocation().compareTo(key)==0){		
			return r.getData();
			//if searching note is not leaf and not equal the target location
			//then search it's subtree
	    }else if(r.getData().getLocation().compareTo(key)==1) {
			return get(r.getRight(), key);
	    }else {	
			return get(r.getLeft(), key);	
		}
	   
	}
	//if the target Location is in the tree, then return the Node of this location otherwise return null
	private BinaryNode getNode(BinaryNode r, Location key) {
		// TODO Auto-generated method stub		
		if(r.isLeaf()) {
			return null ;
		}else if(r.getData().getLocation().compareTo(key)==0){
			return r;
			//if searching note is not leaf and not equal the target location
			//then search it's subtree
		}else if(r.getData().getLocation().compareTo(key)==1) {
			return getNode(r.getRight(), key);
		}else{	
			return getNode(r.getLeft(), key);
		}
		
	}
	//if the target Pixel is already in the tree than throw an exception otherwise add it into the tree
	public void put(BinaryNode r, Pixel data) throws DuplicatedKeyException {
		// TODO Auto-generated method stub
		//check if root if is just change the pixel of the root and add to leaf children;
		if(r==root && root.getData()==null) {
			root.setData(data);
			BinaryNode leftNode = new BinaryNode(null,null,null,root);
			BinaryNode rightNode = new BinaryNode(null,null,null,root);
			root.setLeft(leftNode);
			root.setRight(rightNode);
		}
		//is not in the tree
		else if(this.get(r, data.getLocation())==null) {
			//use loop to find the leaf that follow the rule of BST
			while(!r.isLeaf()) {
				if(r.getData().getLocation().compareTo(data.getLocation())==-1) {
					r=r.getLeft();	
				}else if(r.getData().getLocation().compareTo(data.getLocation())==1) {
					   r=r.getRight();
			}
		}
			//change the pixel of this leaf and add two children of this leaf
				r.setData(data);
				BinaryNode leftNode =  new BinaryNode (null, null, null, r);
				r.setLeft(leftNode);
				BinaryNode rightNode =  new BinaryNode (null, null, null, r);
				r.setRight(rightNode);
				leftNode.setParent(r);
				rightNode.setParent(r);
		}else {
			//otherwise throw an exception
			throw new DuplicatedKeyException(data.toString());
			
		}
		}

//if the target node is already in the tree then delete this Node otherwise throw an exception
	public void remove(BinaryNode r, Location key) throws InexistentKeyException {
		// TODO Auto-generated method stub
		//try to find the Node first if can't find then throw an exception
		if(this.get(r, key)==null) {
			throw new InexistentKeyException(key.toString());
		}else {
			//if find the Node, then delete the node
			BinaryNode targetNode = this.getNode(r, key);
			//if the children of the Node are leave
			if(targetNode.getLeft().isLeaf() && targetNode.getRight().isLeaf()) {
				//if Node is root just remove the pixel
				if(targetNode==root) {
					root.setData(null);
				}else {
					//else remove the pixel of this node and set it's children to null
					targetNode.setData(null);
					targetNode.setLeft(null);
					targetNode.setRight(null);
					}
				}
			//if just one of it's child is  leaf
		  else if(targetNode.getLeft().isLeaf() || targetNode.getRight().isLeaf()) {
			  //determine which one is leaf and keep the other one as linkedNode
				BinaryNode linkedNode = new BinaryNode();
		       if(targetNode.getLeft().isLeaf()){
				linkedNode=targetNode.getRight();
			   }else if (targetNode.getRight().isLeaf()) {
				linkedNode=targetNode.getLeft();
			}
		       //determine the target Node is leaf child or right child
		       //set the linkedNode as the new child of the parent of targetNode 
		       //set  the parent of targetNode  as the new parent of linkedNode
		       if(targetNode.getParent().getLeft()==targetNode) {
		    	      targetNode.getParent().setLeft(linkedNode);
		       }else {
		    	      targetNode.getParent().setRight(linkedNode);
		       }
		       linkedNode.setParent(targetNode.getParent());
			}else {
				//if the children of target Node are not leaf
				//find the biggest Node that smaller than the target Node as check node
				BinaryNode check = this.predecessorNode(r, key);
				//relink the left child of check node to it's parent
					check.getParent().setRight(check.getLeft());
					check.getLeft().setParent(check.getParent());
					//if targetNode is root than set parent of check as null
				if(targetNode.getParent()==null) {
					check.setParent(null);
				}else {
					//else relink the parent of targetNode to check note
				if(targetNode.getParent().getLeft()==targetNode) {
					targetNode.getParent().setLeft(check);
				}else {
					targetNode.getParent().setRight(check);
				}
				check.setParent(targetNode.getParent());
			}
				//set the check as the parent of  the children of targeNode 
				//set the children of targetNode as the  children of check
				check.setLeft(targetNode.getLeft());
				check.setRight(targetNode.getRight());
				targetNode.getLeft().setParent(check);
				targetNode.getRight().setParent(check);
			}
		}	
		
	}
	
	//Returns the Pixel with the smallest key larger than the given one
	//Returns null if the given key has no successor.
	public Pixel successor(BinaryNode r, Location key) {
		// TODO Auto-generated method stub
	     //if r is leaf and the parent of r is larger than the target key then return the pixel of the  parent of r
		if(r.isLeaf() && r.getParent().getData().getLocation().compareTo(key)==-1){
			return r.getParent().getData();
			//if r is leaf but the parent of r is smaller than or equal to the target key then return the pixel of the  parent of r
		}else if(r.isLeaf()) {
			return null;
			//if r is smaller or equal to the target location then recurse the right child of r
		}else if(r.getData().getLocation().compareTo(key)==1 || r.getData().getLocation().compareTo(key)==0) {
			return successor(r.getRight(),key);
		}
		//else r has left node but r is the largest one that smaller than target node than return the pixel of r
        //else return recurse the left node of r
		else {
			if(successor(r.getLeft(),key)!=null) {
				return successor(r.getLeft(),key);
			}else {
				return r.getData();
			}
	}
	}

	@Override
	//Returns the pixel with the largest key smaller than the given one
	//Returns null if the given key has no predecessor.
	public Pixel predecessor(BinaryNode r, Location key) {
		//if r is leaf and the parent of r is smaller than target location then return the pixel of parent of r
		if(r.isLeaf() && r.getParent().getData().getLocation().compareTo(key)==1){
			return r.getParent().getData();
			//else if just leaf return null
		}else if(r.isLeaf()) {
			return null;
		}
		//else if r is larger or equal to target location then recurse the left node of r
		else if(r.getData().getLocation().compareTo(key)==-1 || r.getData().getLocation().compareTo(key)==0) {
		
				return predecessor(r.getLeft(),key);
		}else {
			//if r is smaller than the target location but the the smallest note of right subtree  is larger then target node
			//then return null
			//else recurse the right node of r
			if(predecessor(r.getRight(),key)!=null) {
				return predecessor(r.getRight(),key);
			}else {
				return r.getData();
			}
		}
			
		
	}
	//Returns the BinaryNode with the largest key smaller than the given one
	//Returns null if the given key has no predecessor.
	private BinaryNode predecessorNode(BinaryNode r, Location key) {
		if(r.isLeaf() && r.getParent().getData().getLocation().compareTo(key)==1){
			return r.getParent();
		}else if(r.isLeaf()) {
			return null;
		}
		else if(r.getData().getLocation().compareTo(key)==-1 || r.getData().getLocation().compareTo(key)==0) {
		
				return predecessorNode(r.getLeft(),key);
		}else {
			if(predecessor(r.getRight(),key)!=null) {
				return predecessorNode(r.getRight(),key);
			}else {
				return r;
			}
		
		}}

	//Returns the Pixel with the smallest key. Throws an EmptyTreeException if the tree does not contain any data.	
	public Pixel smallest(BinaryNode r) throws EmptyTreeException {
		//if r is leaf then there is no pixel in the tree and throw exception
		if(r.isLeaf()) {
			throw new EmptyTreeException(r.toString());
		}else {
			//if the left node of r is note leaf then move r to the left node
			while(!r.getLeft().isLeaf()) {
				r=r.getLeft();
			}
			//once r is leaf then return the parent of r
			return r.getParent().getData();
		}
}
	//Returns the Pixel with the largest key. Throws an EmptyTreeException if the tree does not contain any data.
  public Pixel largest(BinaryNode r) throws EmptyTreeException {
		//if r is leaf then there is no pixel in the tree and throw exception
		if(r.isLeaf()) {
			throw new EmptyTreeException(r.toString());
		}else {
			//if the right node of r is note leaf then move r to the left node
			while(!r.getRight().isLeaf()) {
				r=r.getRight();
			}
			//once r is leaf then return the parent of r
			return r.getParent().getData();
		}
	}

}
