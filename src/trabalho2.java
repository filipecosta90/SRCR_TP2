/*
 * trabalho2.java: Prolog-Java
 */

import se.sics.jasper.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.*; //nao esta a ser usado

public class trabalho2
{
  // private String IdUt;
  //private String IdServ;
  //private String Data;
  //private String Descricao;


  /* 
   * E1) Extensao do predicado que permite identificar todos as consultas medicas de um utente
   * %consultasMedicasUtente(ItUt, ListaEventosMedicos)
   */
  public static SPTerm querie1(String IdUt)
  {
    SICStus sp;
    SPTerm ListaEventosMedicos = null;
    HashMap varMap = new HashMap();
    SPQuery query;
    int i;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("utentesServico("+IdUt+",ListaEventosMedicos).", varMap))
      {
        System.out.println("ERROR: connected/4 failed");
      }
      else
      {
        ListaEventosMedicos = ((SPTerm)varMap.get("ListaEventosMedicos"));
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return ListaEventosMedicos;
  }

  /* 
   * E1) Extensao do predicado que permite identificar todos as consultas medicas de um utente
   * %consultasMedicasUtente(ItUt, ListaEventosMedicos)
   */
  public static SPTerm querie1(String IdUt)
  {
    SICStus sp;
    SPTerm ListaEventosMedicos = null;
    HashMap varMap = new HashMap();
    SPQuery query;
    int i;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("utentesServico("+IdUt+",ListaEventosMedicos).", varMap))
      {
        System.out.println("ERROR: connected/4 failed");
      }
      else
      {
        ListaEventosMedicos = ((SPTerm)varMap.get("ListaEventosMedicos"));
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return ListaEventosMedicos;
  }
  
  

  public static void main(String argv[]) throws ConversionFailedException, IllegalTermException
  {
    SPTerm result = querie1("sv001");
    if (result != null) {
      SPTerm arrayDeTermos[] = result.toTermArray();
      System.out.println(Arrays.toString(arrayDeTermos)); //array de termos passa a array de strings
      //        	System.out.println(arrayDeTermos[0].getString()); //para imprimir um dos elementos do array
    } else {
      System.out.println("ERROR: Did not find any solutions");
    }
  }

}
