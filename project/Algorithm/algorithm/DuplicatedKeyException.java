
public class DuplicatedKeyException extends Exception {
public DuplicatedKeyException(String string) {
	super(string+"is already in the tree");
}
public DuplicatedKeyException() {
	super();
}
}
