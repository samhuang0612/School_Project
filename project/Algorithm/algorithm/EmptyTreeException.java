
public class EmptyTreeException extends Exception {
	public EmptyTreeException(String string) {
		super(string+"is already in the tree");
	}
	public EmptyTreeException() {
		super();
}
}
