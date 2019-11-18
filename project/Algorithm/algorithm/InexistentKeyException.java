
public class InexistentKeyException extends Exception {
	public InexistentKeyException(String string) {
		super(string+"is not in the tree");
	}
	public InexistentKeyException() {
		super();
	}
}
