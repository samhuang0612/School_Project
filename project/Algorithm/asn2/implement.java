/*Student name : Lishan Huang
Student number : 250777962*/

import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
public class implement {
	
	  public static HashMap<Character, Integer> sortByValue(HashMap<Character, Integer> hm) {
	        List<Map.Entry<Character, Integer> > list = 
	               new LinkedList<Map.Entry<Character, Integer> >(hm.entrySet()); 
	        Collections.sort(list, new Comparator<Map.Entry<Character, Integer> >() { 
	            public int compare(Map.Entry<Character, Integer> o1,  
	                               Map.Entry<Character, Integer> o2) 
	            { 
	                return (o1.getValue()).compareTo(o2.getValue()); 
	            } 
	        });  
	        HashMap<Character, Integer> newMap = new LinkedHashMap<Character, Integer>(); 
	        for (Map.Entry<Character, Integer> newEn : list) { 
	            newMap.put(newEn.getKey(), newEn.getValue()); 
	        } 
	        return newMap; 
	    } 
	  
	public static void main(String args[])throws Exception  {
		  File file = new File(args[0]); 
		  BufferedReader br = new BufferedReader(new FileReader(file)); 
		  String st; 
		  uandf stra =new uandf(5041);
		  int ind=0;
		  int rem=0;
		  BufferedReader br1 = new BufferedReader(new FileReader(file));
		  int size=0;
		  String st1; 
		  while ((st1 = br1.readLine()) != null) {
			  size=st1.length();
		  }
		  int[] stor= new int[size*size];
		  char[] output = new char[size*size];
		  while ((st = br.readLine()) != null) {
			  for(int i=0;i<st.length();i++) {				  
		       if(st.charAt(i) == '+') {
		    	   stor[ind+i]=1;
		    	   if( 0<i && stor[ind+i]==stor[ind+i-1]) {
						  stra.union_sets(ind+i,ind+i+1);
					  }
		    	   
		    	   if(0<ind) {
						  if(stor[ind+i-71]==stor[ind+i]) {
							  stra.union_sets(ind+i-70, ind+i+1);
						  }		
					  }
		       }	       
		       else {
		    	   stor[ind+i]=0;	    	   
		       }	       
		       }	  
			  ind=ind+71;
		  }	  
		  
		  for (int i=0;i<stor.length;i++) {
			  
			  if(stor[i]==0) {		  
				stra.remove(i-rem); 
				rem++;			
			  }
			  
		  }
		  System.out.println("1. the input binary image");
		  for(int i=0;i<stor.length;i++) {
			  if(stor[i]==1) {
				  System.out.print("+");
			  }else {
				  System.out.print(" ");
			  }
			  if(i%71==70) {
				  System.out.println();
			  }
		  }
		  
		  for(int i=0;i<output.length;i++) {
			  output[i]=' ';
		  }
		  stra.final_sets(); 
		  char newChar ='a';
		  int CharIndex=0;
		 HashMap<Character,Integer> map =new HashMap<Character,Integer>();
		 List<Integer> par = new ArrayList<Integer>();
		 List<Character> Charac = new ArrayList<Character>();
		 for(int i=0;i<stra.store().size();i++) {
			 if(!par.contains(stra.store().get(i).parent.self)) {
				 par.add(stra.store().get(i).parent.self);
				 Charac.add((char) (newChar+CharIndex));
				 CharIndex++;
			 }
		 }
		 
		 for(int i=0;i<par.size();i++) {
			int total=0;
			 for(int j =0;j<stra.store().size();j++) {
				 if(par.get(i)==stra.store().get(j).parent.self) {
					 total++;
					 output[stra.store().get(j).self-1]=Charac.get(i);
				 }
		 }
			 map.put(Charac.get(i), total);
		 }
		  System.out.println("2. the connected component image where each component is labelled with a unique character");
		  for(int i=0;i<output.length;i++) {
			  
			  System.out.print(output[i]);
			  
			  if(i%71==70) {
				  System.out.println();
			  }
		  }
		  
		  HashMap<Character, Integer> sortmap =sortByValue(map);
		      Iterator iterator = sortmap.entrySet().iterator();
		      System.out.println("3. a list sorted by component size, where each line of the list contains the size and the\n" + 
		      		"label of a component");
			  while (iterator.hasNext()) {
				     Map.Entry entry = (Map.Entry) iterator.next();
				     System.out.println("Represent Character: "+entry.getKey() + " & Component size: " + entry.getValue());
		      }
			  
	      Iterator iterator2 = sortmap.entrySet().iterator();	  
	      List<Character> removeList = new LinkedList<Character>();
	      while (iterator2.hasNext()) {
			     Map.Entry entry = (Map.Entry) iterator2.next();
			    if((Integer)entry.getValue()<=2) {
			    	removeList.add((Character)entry.getKey());
			    }
	      }

	      System.out.println("4. same as 2 with the connected component whose size equals to one or two removed.");
	      for(int i=0;i<output.length;i++) {
	    	  if(!removeList.contains(output[i])) {
			  System.out.print(output[i]);
	    	  }else{
	    		  System.out.print(' ');  
			  }
			  if(i%71==70) {
				  System.out.println();
			  }
	    	  }
		  }  
	
}