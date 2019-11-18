
public class Pixel {
	private Location loc;
	private int col;
	//A constructor which initializes the new Pixel with the specified coordinates and color. Location p is the key for the Pixel
	public Pixel(Location p, int color) {
		loc=p;
		col=color;		
	}
	//Returns the Location of the Pixel
	public Location getLocation() {
		return loc;
		
	}
	//Returns the color of the Pixel.
	public int getColor() {
		return col;	
		
	}

}
