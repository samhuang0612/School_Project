
public class Location {
	private int xaxis, yaxis;
	//A constructor that initializes the Location object with the specified coordinates.
	public Location(int x, int y) {
		xaxis=x;
		yaxis=y;		
	}
	//Returns the x coordinate of this Location.
	public int xCoord() {
		return xaxis;
		
	}
	//Returns the y coordinate of this Location.
	public int yCoord() {
		return yaxis;
		
	}
	//Compares this Location with p using column order
	public int compareTo (Location p) {
		if(this.xCoord() < p.xCoord() ){
			return 1;
		}else if(this.xCoord()==p.xCoord() && this.yCoord()<p.yCoord()) {
			return 1;
		}else if(this.xCoord()==p.xCoord() && this.yCoord()==p.yCoord()) {
			return 0;
		}else {
			return -1;
		}	
	}

}
