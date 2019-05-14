import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;

public class Dijkstra {
	static HashMap<LinkedList<Integer>, Integer> Edge;
	static ArrayList<LinkedList<Integer>> Vertex;
	public  int[] d;
	public  int[] pi;
	public static  int n;
	public heap MyHeap;
	
	public Dijkstra(HashMap<LinkedList<Integer>, Integer> E,ArrayList<LinkedList<Integer>> V,int n1,int s) {
		this.Initialize_Single_Source(s);
		int current=s;
		while(current!=0) {
			LinkedList<Integer> check = V.get(current);
			int smallest =Integer.MAX_VALUE;
			for(int i=0;i<V.get(current).size();i++) {
				LinkedList<Integer> check1= new LinkedList<Integer>();
				check1.add(current);
				check1.add(V.get(current).get(i));
				int weight1=E.get(check1);
				this.Relxation(current, V.get(current).get(i), weight1);
				MyHeap.decrease_key(V.get(current).get(i), d[V.get(current).get(i)]);	
			}
			current=MyHeap.min_id();
			MyHeap.dete_min();
		}
		for(int i=0; i<n+1;i++) {
			System.out.print(MyHeap.A[i]+" ");
		}
		System.out.println("");
		for(int i=0; i<2*n;i++) {
			System.out.print(MyHeap.H[i]+" ");
		}
	}
	
	public void Initialize_Single_Source(int s) {
		d= new int[n+1];
		pi=new int[n+1];
		for(int i=0;i<n+1;i++) {
			d[i]=Integer.MAX_VALUE;
			pi[i]=-1;
		}
		d[s]=0;
		MyHeap= new heap(d,n+1);
	}
	
	public void Relxation(int u, int v, int w) {
		if (d[v]>d[u]+w) {
			d[v]=d[u]+w;
			pi[v]=u;
		}
	}
		
	
	public static void main(String[] args) throws IOException {
		Edge = new HashMap<LinkedList<Integer>, Integer>();
		Vertex= new ArrayList<LinkedList<Integer>>();
		File file = new File(args[0]);
		BufferedReader br1 = new BufferedReader(new FileReader(file));
		String str1;
		str1=br1.readLine();
		n = Integer.parseInt(str1);
		while((str1=br1.readLine())!=null) {
			String[] str= str1.split(" ");
			LinkedList<Integer> key = new LinkedList<Integer>();
			int left =Integer.parseInt(str[0]);
			int right=Integer.parseInt(str[1]);
			key.add(left);
			key.add(right);
			int weight = Integer.parseInt(str[3]);
			Edge.put(key, weight);
			for(int i=0;i<n;i++) {
				LinkedList<Integer> newList = new LinkedList<Integer>();
				Vertex.add(newList);
			}
			Vertex.get(left).add(right);
		}
		Dijkstra result = new Dijkstra(Edge,Vertex,n,1);
		
	}
}