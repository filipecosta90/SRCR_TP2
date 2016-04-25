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

  public static HashMap utente(String IdUt, String Nome, String Idade, String Morada)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(utente("+IdUt+","+Nome+","+Idade+","+Morada+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap servico(String IdServ, String Descricao, String Instituicao, String Cidade)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(servico("+IdServ+","+Descricao+","+Instituicao+","+Cidade+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap consulta(String Data, String IdUt, String IdServ, String Custo)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(consulta("+Data+","+IdUt+","+IdServ+","+Custo+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap registarUtente(String IdUt, String Nome, String Idade, String Morada)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(registarUtente("+IdUt+","+Nome+","+Idade+","+Morada+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap removerUtente(String IdUt, String Nome, String Idade, String Morada)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(removerUtente("+IdUt+","+Nome+","+Idade+","+Morada+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap registarConsulta(String Data, String IdUt, String IdServ, String Custo)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(registarConsulta("+Data+","+IdUt+","+IdServ+","+Custo+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static HashMap removerConsulta(String Data, String IdUt, String IdServ, String Custo)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    SPQuery query;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(removerConsulta("+Data+","+IdUt+","+IdServ+","+Custo+"),Resposta).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }


  /* 
   * E1) Extensao do predicado que permite identificar todos as consultas medicas de um utente
   * %consultasMedicasUtente(ItUt, ListaEventosMedicos)
   */
  public static HashMap querie1(String IdUt)
  {
    SICStus sp;
    HashMap varMap = new HashMap();
    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("consultasMedicasUtente("+IdUt+",ListaEventosMedicos).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  /* 
   *  % E2) Extensao do predicado que permite calcular o custo de todos as consultas medicas de um utente
   *  %custoConsultasMedicasUtente(ItUt, CustoTotal) -> {V,F,D}
   *  custoConsultasMedicasUtente(IdUt,CustoTotal) :-(
   *   solucoes( (Custo), ( consulta(Data,IdUt,IdServ,Custo) ), ListaCustosMedicos),
   *   somarElementos(ListaCustosMedicos,CustoTotal) 
   *   ).
   */

  public static HashMap querie2(String IdUt)
  {
    SICStus sp;
    HashMap varMap = new HashMap();

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("custoConsultasMedicasUtente("+IdUt+",CustoTotal).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }

    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  /* 
   *  % E3) Extensao do predicado Identificar os utentes de um determinado servico
   *  % utentesServico(IdServ,ListaUtentes) -> {V,F,D}
   *  utentesServico(IdServ,ListaUtentes) :-
   *  solucoes(X, recorreuServico(X, IdServ), ListaUtentesRep),
   *  removerduplicados(ListaUtentesRep,ListaUtentes).
   */

  public  static HashMap querie3(String IdServ)
  {
    SICStus sp;
    SPTerm Resposta = null;

    HashMap varMap = new HashMap();
    SPQuery query;
    int i;

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("demo(utentesServico("+IdServ+",ListaUtentes),Resposta).", varMap)){
        System.out.println("ERRO: falha na conexão SICSTUS");
      }
    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  /* 
   *  % E4) Extensao do predicado Identificar os servicos existentes numa instituicao
   *  % servicosInstituicao(Instituicao,ListaServicos) -> {V,F,D}
   *  servicosInstituicao(Instituicao,ListaServicos) :- solucoes((IdServ,Descricao), servico(IdServ,Descricao,Instituicao,Cidade), ListaServicos).
   */

  public static HashMap querie4(String Instituicao)
  {
    SICStus sp;
    HashMap varMap = new HashMap();

    try {
      if (null == (sp = SICStus.getInitializedSICStus())) {
        sp = new SICStus();
        sp.load("trabalho2");
      }

      if (!sp.query("servicosInstituicao("+Instituicao+",ListaServicos).", varMap))
      {
        System.out.println("ERRO: falha na conexão SICSTUS");
      }

    } catch ( Exception e ) {
      e.printStackTrace();
    }
    return varMap;
  }

  public static String preparaExcecoes(String entrada){
    String saida = entrada;
    saida = saida.replace("imperfeito_interdito_1", "INTERDITO");
    saida = saida.replace("imperfeito_interdito_2", "INTERDITO");
    saida = saida.replace("imperfeito_interdito_3", "INTERDITO");
    saida = saida.replace("imperfeito_incerto_1", "INCERTO");
    saida = saida.replace("imperfeito_incerto_2", "INCERTO");
    saida = saida.replace("imperfeito_incerto_3", "INCERTO");
    saida = saida.replace("imperfeito_incerto_4", "INCERTO");
    return saida;
  }



  public static void main(String argv[]) throws ConversionFailedException, IllegalTermException
  {
    System.out.println("###### CONHECIMENTO PERFEITO POSITIVO ######");
    HashMap utente_perfeito_positivo = utente("ut001","antonio_sousa","24","rua_de_santo_ovideo");
    SPTerm resultado_utente_perfeito_positivo =   (SPTerm) utente_perfeito_positivo.get("Resposta");
    System.out.println("Teste 1: \tutente(\"ut001\",\"antonio_sousa\",\"24\",\"rua_de_santo_ovideo\");");
    System.out.println(" \tEsperado (verdadeiro) : " + resultado_utente_perfeito_positivo.toString());


    System.out.println("\n###### CONHECIMENTO PERFEITO NEGATIVO ######");
    HashMap utente_perfeito_negativo = utente("ut001000","antonio_sousa","24","rua_de_santo_ovideo");
    SPTerm resultado_utente_perfeito_negativo =   (SPTerm) utente_perfeito_negativo.get("Resposta");
    System.out.println("Teste 2: \tutente(\"ut001000\",\"antonio_sousa\",\"24\",\"rua_de_santo_ovideo\");");
    System.out.println(" \tEsperado (falso) : " + resultado_utente_perfeito_negativo.toString());


    System.out.println("\n###### CONHECIMENTO IMPERFEITO INCERTO ######");
    HashMap utente_incerto = utente("ut007","sergio_caldas","25","rua_de_santo_ovideo");
    SPTerm resultado_utente_incerto =   (SPTerm) utente_incerto.get("Resposta");
    System.out.println("Teste 3: \tutente(\"ut007\",\"sergio_caldas\",\"25\",\"rua_de_santo_ovideo\");");
    System.out.println(" \tEsperado (desconhecido) : " + resultado_utente_incerto.toString());


    System.out.println("\n###### CONHECIMENTO IMPERFEITO IMRECISO ######");
    HashMap utente_impreciso_1 = utente("ut008","luis_mendes","25","rua_das_margaridas");
    HashMap utente_impreciso_2 = utente("ut008","luis_mendes","20","rua_das_margaridas");
    HashMap utente_impreciso_3 = utente("ut008","luis_mendes","30","rua_das_margaridas");

    SPTerm resultado_utente_impreciso_1 = (SPTerm) utente_impreciso_1.get("Resposta");
    SPTerm resultado_utente_impreciso_2 = (SPTerm) utente_impreciso_2.get("Resposta");
    SPTerm resultado_utente_impreciso_3 = (SPTerm) utente_impreciso_3.get("Resposta");

    System.out.println("Teste 4: \tutente(\"ut008\",\"luis_mendes\",\"25\",\"rua_das_margaridas\");");
    System.out.println("Teste 4: \tutente(\"ut008\",\"luis_mendes\",\"20\",\"rua_das_margaridas\");");
    System.out.println("Teste 4: \tutente(\"ut008\",\"luis_mendes\",\"30\",\"rua_das_margaridas\");");

    System.out.println(" \tEsperado (desconhecido) : " + resultado_utente_impreciso_1.toString());
    System.out.println(" \tEsperado (falso) : " + resultado_utente_impreciso_2.toString());
    System.out.println(" \tEsperado (desconhecido) : " + resultado_utente_impreciso_3.toString());

    System.out.println("\n###### CONHECIMENTO IMPERFEITO INTERDITO ######");
    HashMap utente_interdito_1 = utente("ut009" ,"carlos_sa" , "40", "fundacao_abcd" );
    SPTerm resultado_utente_interdito_1 = (SPTerm) utente_interdito_1.get("Resposta");
    System.out.println("Teste 5: \tutente(\"ut009\",\"carlos_sa\",\"40\",\"fundacao_abcd\");");
    System.out.println(" \tEsperado (desconhecido) : " + resultado_utente_interdito_1.toString());
    HashMap utente_interdito_2 = registarUtente("ut009" ,"carlos_sa" , "40", "fundacao_abcd" );
    SPTerm resultado_utente_interdito_2 = (SPTerm) utente_interdito_2.get("Resposta");
    System.out.println(">>>>> Teste 5: \tregistarUtente(\"ut009\",\"carlos_sa\",\"40\",\"fundacao_abcd\");");
    System.out.println(" \tEsperado (falso) : " + resultado_utente_interdito_2.toString());


    System.out.println("\n###### EVOLUÇÃO DO CONHECIMENTO E RESTRIÇÕES ######");
    HashMap registarUtente = registarUtente("ut100" ,"manuel_alves" , "40", "universidade_minho" );
    SPTerm resultado_registarUtente = (SPTerm) registarUtente.get("Resposta");
    System.out.println("Teste 6: \tregistarUtente(\"ut100\",\"manuel_alves\",\"40\",\"universidade_minho\");");
    System.out.println(" \tEsperado (verdadeiro) : " + resultado_registarUtente.toString());
    HashMap registarUtente_1 = registarUtente("ut100" ,"manuel_alves" , "40", "universidade_minho" );
    SPTerm resultado_registarUtente_1 = (SPTerm) registarUtente_1.get("Resposta");
    System.out.println("Teste 6.1(voltar registar): \tregistarUtente(\"ut100\",\"manuel_alves\",\"40\",\"universidade_minho\");");
    System.out.println(" \tEsperado (falso) : " + resultado_registarUtente_1.toString());
    /*
       System.out.println("\n###### REMOCAO DO CONHECIMENTO E RESTRIÇÕES ######");
       HashMap removerUtente_1 = removerUtente("ut005" ,"ricardo_oliveira" , "27", "rua_gen_humberto_delgado" );
       SPTerm resultado_removerUtente_1 = (SPTerm) removerUtente_1.get("Resposta");
       System.out.println("Teste 7: \tremoverUtente(\"17-6-1988\",\"ut005\",\"sv006\",\"0\");");
    /*System.out.println(" \tEsperado (verdadeiro) : " + resultado_removerConsulta.toString());

    HashMap removerConsulta = removerConsulta("17-6-1988" ,"ut005" , "sv006", "0" );
    SPTerm resultado_removerConsulta = (SPTerm) removerConsulta.get("Resposta");


    System.out.println("Teste 7: \tremoverConsulta(\"17-6-1988\",\"ut005\",\"sv006\",\"0\");");
    System.out.println(" \tEsperado (verdadeiro) : " + resultado_removerConsulta.toString());*/

  }

}
