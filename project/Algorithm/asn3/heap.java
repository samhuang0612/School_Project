public class heap{
	
	public int A[];
	public int H[];
	public int n;
	
	public heap(int keys[], int length){
		
		A=keys;
		n=length-1;
		H=new int[2*n];
		for (int i=n;i<=2*n-1;i++) {
			H[i]=i-n+1;
		}
		
		for(int i=n-1;i>0;i--) {
			if(A[H[2*i]]<A[H[2*i+1]]) {
				H[i]=H[2*i];
			}else {
				H[i]=H[2*i+1];
			}
		}
	}
	
	public boolean in_heap(int id) {
		
		if(id<A.length) {
			return true;
		}else {
			return false;
		}
		
	}
	
	public int min_key() {
		return A[H[1]];
	}
	
	public int min_id() {
		return H[1];
	}
	
	public int key(int id) {
		
		if(this.in_heap(id)) {
			return A[id];
		}else {
			return -1;
		}
		
	}
	
	public int dete_min() {
		
		A[0]=Integer.MAX_VALUE;
		H[H[1]+n-1]=0;
		int v=A[H[1]];
		int i =(H[1]+n-1)/2;
			while (i>=1) {
				
				if(A[H[2*i]]<A[H[2*i+1]]) {
					H[i]=H[2*i];
				}else {
					H[i]=H[2*i+1];
				}
				i=i/2;
			}
			return v;
		
	}
	
	public void decrease_key(int id, int new_key) {
		
		if(this.in_heap(id)) {
			A[id]=new_key;						
			id=(id+n-1)/2;	
		
			while (id>=1) {				
				if(A[H[2*id]]<A[H[2*id+1]]) {					
					H[id]=H[2*id];					
				}else {
					H[id]=H[2*id+1];
				}
			
				id=id/2;
			}
			
		}else {
			System.out.println("Invalid id");
		}
}
}