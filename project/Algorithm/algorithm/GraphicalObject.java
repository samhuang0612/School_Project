import java.util.ArrayList;

public class GraphicalObject implements GraphicalObjectADT{
	//create variable in the class
	private int ID, wid,hei;
	private String typ;
	private Location position;
	private BinarySearchTree Tree;
	private ArrayList<Pixel> abc;

	public GraphicalObject (int id, int width, int height, String type, Location pos) {
		//initialize variable
		ID=id;
		wid=width;
		hei=height;
		typ=type;
		position=pos;
	    Tree=new BinarySearchTree();
	    abc=new ArrayList<Pixel>();
	}
	//Returns the width of the enclosing rectangle for this graphical object.
	public int getWidth() {
		return wid;
	}

	//Returns the height of the enclosing rectangle for this graphical object.
	public int getHeight() {
		// TODO Auto-generated method stub
		return hei;
	}

	@Override
	public String getType() {
		// TODO Auto-generated method stub
		return typ;
	}

	//Returns the type of this graphical object.
	public int getId() {
		// TODO Auto-generated method stub
		return ID;
	}

	//Returns the offset of this graphical object
	public Location getOffset() {
		// TODO Auto-generated method stub
		return position;
	}

	//Changes the offset of this graphical object to th specified value
	public void setOffset(Location value) {
		position =value;
		
	}

  //Returns the type of this graphical object
	public void setType(String t) {
		typ=t;
		
	}
	//return the ArrayList inside the tree
	private ArrayList<Pixel> getList() {
		return abc;
	}
	//return the tree inside the tree
	private BinarySearchTree getTree() {
		return Tree;
	}

	//Inserts pix into the binary search tree associated with this graphical object.
	//Throws a DuplicatedKeyException if an error occurs when inserting the Pixel into the tree.
	public void addPixel(Pixel pix) throws DuplicatedKeyException {
		if(Tree.get(Tree.getRoot(),pix.getLocation())==null) {
			Tree.put(Tree.getRoot(), pix);
			abc.add(pix);	
		}else {
			throw new DuplicatedKeyException(pix.toString());
		}	
	}

//Returns true if this graphical object intersects the one specified in the parameter. It returns false otherwise.
	public boolean intersects(GraphicalObject fig) {
		// TODO Auto-generated method stub
		ArrayList<Pixel> newList =fig.getList();
		//loop all the pixel in fig
		for(Pixel a : newList ) {
			//set xAxis = x axis of a  + x axis  of offset in a −  x axis  of offset in this graphics 
			int xAxis=a.getLocation().xCoord()+fig.getOffset().xCoord()-this.getOffset().xCoord();
			//set yAxis = y axis of a  + y axis  of offset in a −  y axis  of offset in this graphics 
			int yAxis=a.getLocation().yCoord()+fig.getOffset().yCoord()-this.getOffset().yCoord();
            // make a new location combine xAxis and yAxis
			Location test = new Location(xAxis,yAxis);
			//determine whether the new location is inside the tree if is the return true
			if(this.findPixel(test)==true) {
				return true;
			}
		}
		//else return false
		return false;
	}
	//determine whether location p is in the tree
	private boolean findPixel(Location p) {
		if(this.getTree().get(this.getTree().getRoot(), p)!=null) {
			return true;
		}else {
			return false;
		}
	}

		
}
