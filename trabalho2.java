/*
 * trabalho2.java: Prolog-Java
 */

import se.sics.jasper.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.*; //nao esta a ser usado

public class trabalho2
{
    private String a;
    private int x;
	
    public trabalho2(String a, int b) {
    	this.a = a + " " + b;
    }

    public static int square(int x) {
    	return x*x;
    }

    public String get() {
    	return a;
    }

    public void set(String b) {
    	a = b;
    }

    public void append(String b) {
    	a = new String(a + b);
    }

    /**
     * @param filename
     * @return
     */
    public static SPTerm fazerquery(String filename)
    {
		SICStus sp;
	    SPTerm way = null;
		HashMap varMap = new HashMap();
		SPQuery query;
		int i;
		
		try {
		    if (null == (sp = SICStus.getInitializedSICStus())) {
			sp = new SICStus();
	            }
	
		    if (filename != null) {
	                sp.load(filename);
	            }
		    
		    if (!sp.query("utentesServico(sv001,Way).", varMap))
	                {
	                    System.out.println("ERROR: connected/4 failed");
	                }
	            else
	                {
	                    way = ((SPTerm)varMap.get("Way"));
	                }
		} catch ( Exception e ) {
		    e.printStackTrace();
		}
		return way;
    }
    
    public static SPTerm fazerquery()
    {
        return fazerquery(null);
    }
  
    
    public static void main(String argv[]) throws ConversionFailedException, IllegalTermException
    {
	SPTerm result = fazerquery("trabalho2");
        if (result != null) {
        	SPTerm arrayDeTermos[] = result.toTermArray();
        	System.out.println(Arrays.toString(arrayDeTermos)); //array de termos passa a array de strings
//        	System.out.println(arrayDeTermos[0].getString()); //para imprimir um dos elementos do array
        } else {
            System.out.println("ERROR: Did not find any solutions");
        }
    }
}
