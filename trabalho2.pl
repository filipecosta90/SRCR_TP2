%--------------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3
%
% Programacao em logica estendida
% Representacao de conhecimento imperfeito
%
% Trabalho pratico 2
% Filipe Oliveira, Filipe Marques, Luis Mendes
%
% permitida a evolucao sobre utentes, servicos, consultas 
%     utente: IdUt, Nome, Idade, Morada -> {V,F,D}
%     serviço: IdServ, Descrição, Instituição, Cidade -> {V,F,D}
%     consulta: Data, IdUt, IdServ, Custo -> {V,F,D}
%--------------------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -

%SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

% SICStus PROLOG: Definicoes iniciais
:- op(900,xfy,'::').

:- dynamic utente/4.
:- dynamic servico/4.
:- dynamic consulta/4.

%-------------
% Invariantes -------------------------------------------------------------------------------------------
%-------------
% ------------------------------------------------
%  >>>>> Invariantes para operacao de adicao <<<<<
% ------------------------------------------------
%
%   - utente:
%        Invariante Estrutural:
%           - utentes distintos nao teem o mesmo IdUt

+utente(IdUt,Nome,Idade,Morada)::(
  solucoes( (IdUt), ( utente(IdUt,_,_,_) ), Lista),
  comprimento(Lista,N),
  N==1
  ).

%   - servico:
%        Invariante Estrutural:
%           - servicos distintos da mesma instituicao nao teem o mesmo IdServ

+servico(Servico,Descricao,Instituicao,Cidade)::(
  solucoes( (Servico) , ( servico(Servico,_,_,_) ), Lista),
  comprimento(Lista,N),
  N==1
  ).

%   - consulta:
%        Invariante Estrutural:
%           - tem que existir pelo menos uma consulta com essas caracteristicas depois da insercao
%        Invariante Referencial:
%           - o utente a ela associada existe
%           - o servico a ela associada existe
+consulta(Data,IdUtente,IdServico,Custo)::(
  solucoes( (Data,IdUtente,IdServico,Custo), ( consulta(Data,IdUtente,IdServico,Custo) ), Lista),
  comprimento(Lista,N),
  N>=1,
  solucoes( (IdUtente), ( utente(IdUtente,_,_,_) ), ListaUten),
  comprimento(ListaUten,NUten),
  NUten==1,
  solucoes( (IdServico) , ( servico(IdServico,_,_,_ ) ), ListaServ),
  comprimento(ListaServ,NServ),
  NServ==1
  ).

% -------------------------------------------------
%  >>>>> Invariantes para operacao de remocao <<<<<
% -------------------------------------------------
%   - utente:
%        Invariante Estrutural:
%           - nao pode existir o utente depois da operacao de remocao
%        Invariante Referencial:
%           - utentes apenas podem ser eliminado se nao existirem consultas a ele associado
-utente(IdUtente,Nome,Idade,Morada)::(
  solucoes( (IdUtente), ( utente(IdUtente,Nome,Idade,Morada) ), Lista),
  comprimento(Lista,N),
  N==0,
  solucoes( (_,IdUtente,_,_), ( consulta(Data,IdUtente,_,_) ), ListaCons),
  comprimento(ListaCons,NCons),
  NCons==0
  ).

%   - servico:
%        Invariante Estrutural:
%           - nao pode existir o servico depois da operacao de remocao 
%        Invariante Referencial:
%           - servicos apenas podem ser eliminados se nao exitirem consultas a ele associados
-servico(IdServico,Descricao,Instituicao,Cidade)::(
  solucoes( (IdServico) , ( servico(IdServico,_,_,_) ), Lista),
  comprimento(Lista,N),
  N==0,
  solucoes( (Dat,IdUtente,IdServico,Custo), ( consulta(Data,IdUtente,IdServico,Custo) ), ListaCons),
  comprimento(ListaCons,NCons),
  NCons==0
  ).

% -----------------------------------
% Base de Conhecimento sobre Utentes --------------------------------------------------------------------------------------------
% -----------------------------------
% Extensao do predicado utente: IdUt, Nome, Idade, Morada -> {V,F,D}

-utente(IdUt, Nome, Idade, Morada) :- nao(utente(IdUt, Nome, Idade, Morada)),
                                      nao(excecao(utente(IdUt, Nome, Idade, Morada))).

% conhecimento perfeito positivo relativo a utentes
utente(ut001,antonio_sousa,24,rua_de_santo_ovideo).
utente(ut002,filipe_oliveira,25,urb_qta_orfaos).
utente(ut003,fernando_oliveira,55,rua_gen_humberto_delgado).
utente(ut004,fernanda_oliveira,52,rua_gen_humberto_delgado).
utente(ut005,ricardo_oliveira,27,rua_gen_humberto_delgado).

% -------------------------------------
% Explicitacao das situacoes de excecao
% -------------------------------------
%   Consideramos que apenas sao permitidas situacoes de conhecimento incerto/impreciso/interdito para os campos Idade e Morada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Conhecimento imperfeito incerto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      O utente filipe marques, de codigo ut006, residente na rua de santo ovideo, tem idade desconhecida no momento
utente(ut006,filipe_marques,imperfeito_incerto1,rua_santo_ovideo).

%      O utente sergio caldas, de codigo ut007, de idade 25 anos, tem residencia desconhecida no momento
utente(ut007,sergio_caldas,25,imperfeito_incerto2).

excecao(utente(IdUt, Nome, Idade, Morada)) :- utente(IdUt, Nome, imperfeito_incerto1, Morada).
excecao(utente(IdUt, Nome, Idade, Morada)) :- utente(IdUt, Nome, Idade, imperfeito_incerto2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Conhecimento imperfeito impreciso
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Sabe-se que o utente luis mendes, de codigo ut008, tem idade entre 25 e 30 anos, e residencia na rua das margaridas
excecao(utente(ut008, luis_mendes, IDADE, rua_das_margaridas)) :- IDADE =< 30, IDADE >=25.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conhecimento imperfeito interdito
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      O utente carlos sa, de codigo ut009, mudo, sem documentos, e incapacitado foi encontrado na rua, passando a residir na fundacao abcd,
%      pelo que se torna impossivel vir a saber a idade do mesmo 
utente(ut009, carlos_sa, imperfeito_interdito1, fundacao_abcd).
excecao(utente(IdUt, Nome, Idade, Morada)) :- utente(IdUt, Nome, imperfeito_interdito1, Morada).
nulo(imperfeito_interdito1).

+utente(IdUt,Nome,Idade,Morada)::(
  solucoes( (IdUt,Nome,Idade,Morada), ( utente(ut009,carlos_sa,Idade,fundacao_abcd),nao(nulo(Idade))),S),
  comprimento(S,N),
  N==0
  ).

% ------------------------------------
% Base de Conhecimento sobre Serviços --------------------------------------------------------------------------------------------
% ------------------------------------
% Extensao do predicado serviço: IdServ, Descrição, Instituição, Cidade -> {V,F,D}

-servico(IdServ, Descricao, Instituicao, Cidade) :- nao(servico(IdServ, Descricao, Instituicao, Cidade)),
                                                    nao(excecao(servico(IdServ, Descricao, Instituicao, Cidade))).

% conhecimento perfeito positivo relativo a servicos

servico(sv001,cardiologia,hospital_viana_castelo,viana_castelo).
servico(sv002,maternidade,hospital_viana_castelo,viana_castelo).
servico(sv003,maternidade,hospital_matosinhos,matosinhos).
servico(sv004,maternidade,hospital_sao_marcos,braga).
servico(sv005,maternidade,hospital_da_prelada,porto).
servico(sv006,maternidade,hospital_de_sao_joao,porto).
servico(sv007,maternidade,maternidade_julio_dinis,porto).

% -------------------------------------
% Explicitacao das situacoes de excecao
% -------------------------------------
%   Consideramos que apenas sao permitidas situacoes de conhecimento incerto/impreciso/interdito para os campos IdServ, Descricao, Instituicao, Cidade

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Conhecimento imperfeito incerto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Foi adicionada a instituicao hospital de viana do castelo , na cidade de viana do castelo, um novo servico de codigo IdServ sv008,
%     contudo, a descricao do novo servico e ainda desconhecida de momento
servico(sv008,imperfeito_incerto_3,hospital_viana_castelo,viana_castelo).

excecao(servico(IdServ, Descricao, Instituicao, Cidade)) :- utente(IdServ, Descricao, imperfeito_incerto3, Cidade).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Conhecimento imperfeito impreciso
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Sabe-se que o novo servico, de codigo IdServ sv009, na Instituicao hospital de sao marcos, na cidade de braga, e de cardiologia ou geriatria 
excecao(servico(sv009,cardiologia,hospital_sao_marcos,braga)).
excecao(servico(sv009,geriatria,hospital_sao_marcos,braga)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conhecimento imperfeito interdito
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Os registos hospitalares em papel, devido a um incendio, foram perdidos. sabia-se apenas que o servico de codigo sv010, estava localizado 
%      no hospital de matosinhos, na cidade de matosinhos, pelo que se torna impossivel vir a saber a descricao do mesmo 

servico(sv010,imperfeito_interdito_2,hospital_matosinhos,matosinhos).
excecao(servico(IdServ, Descricao, Instituicao, Cidade)) :- servico(IdServ, imperfeito_interdito2, Instituicao, Cidade).
nulo(imperfeito_interdito2).

+servico(IdServ, Descricao, Instituicao, Cidade)::(
  solucoes( (IdServ,Descricao,Instituicao,Cidade), ( servico(sv010,Descricao,hospital_matosinhos,matosinhos),nao(nulo(Descricao))),S),
  comprimento(S,N),
  N==0
  ).

% -------------------------------------
% Base de Conhecimento sobre Consultas -------------------------------------------------------------------------------------------
% -------------------------------------
% Extensao do predicado consulta: Data, IdUt, IdServ, Custo -> {V,F,D}

-consulta(Data, IdUt, IdServ, Custo) :- nao(consulta(Data, IdUt, IdServ, Custo)),
                                                    nao(excecao(consulta(Data, IdUt, IdServ, Custo))).

% conhecimento perfeito positivo relativo a consultas

consulta(23-04-2016,ut001,sv001,10).
consulta(19-12-1990,ut002,sv003,0).
consulta(18-12-1960,ut003,sv002,0).
consulta(08-08-1963,ut004,sv002,0).
consulta(17-06-1988,ut005,sv006,0).

% Explicitacao das situacoes de excecao


%% Queries a base de conhecimento -------------------------------------------------------------------------------------

% 9) Extensao do predicado Registar utentes, profissionais, serviços ou instituições

% Extensao do predicado que pemite registar utentes
% registarUtente(Nome) -> {V,F}
registarUtente(Nome) :- evolucao(utente(Nome)).

% Extensao do predicado que pemite registar servicos numa instituicao
% registarServico(Servico,Instituicao) -> {V,F}
registarServico(Servico,Instituicao) :- evolucao(servico(Servico,Instituicao)).

% Extensao do predicado que pemite registar eventos medicos numa instituicao indicando o utente, o profissional, o servico e a instituicao
% registarEvento(Utente,Profissional,Servico,Instituicao) -> {V,F}
registarEvento(Utente,Profissional,Servico,Instituicao) :- evolucao(registo(Utente,Profissional,Servico,Instituicao)).

% 10) Remover utentes (ou profissionais ou serviços ou instituições) dos registos

% Extensao do predicado que pemite remover utentes
% removerUtente(Nome) -> {V,F}
removerUtente(Nome) :- remocao(utente(Nome)).

% Extensao do predicado que pemite remover servicos numa instituicao
% registarServico(Servico,Instituicao) -> {V,F}
removerServico(Servico,Instituicao) :- remocao(servico(Servico,Instituicao)).

% Extensao do predicado que pemite remover eventos medicos numa instituicao indicando o utente, o profissional, o servico e a instituicao
% removerEvento(Utente,Profissional,Servico,Instituicao) -> {V,F}
removerEvento(Utente,Profissional,Servico,Instituicao) :- remocao(registo(Utente,Profissional,Servico,Instituicao)).

% Predicados que permitem evolução do conhecimento ------------------------------------------------------------------------------ 

% Extensão do predicado que permite a evolucao do conhecimento
% disponibilizada pelo professor na aula prática da semana5
evolucao( Termo ):-solucoes(Invariante,+Termo::Invariante,Lista),
inserir(Termo),
testar(Lista).

% predicado disponibilizado pelo professor na semana5
% inserir: T -> {V,F}
inserir(Termo):-assert(Termo).
inserir(Termo):-retract(Termo),!,fail.

% predicado disponibilizado pelo professor na semana5
% testar: Li -> {V,F}.
testar([]).
testar([I|L]):-I,testar(L).

% Extensão do predicado que permite a remocao do conhecimento
% remocao(Termo) -> {V,F}
remocao( Termo ):-solucoes(Invariante,-Termo::Invariante,Lista),
remover(Termo),
testar(Lista).

% remover: T -> {V,F}
remover(Termo):-retract(Termo).
remover(Termo):-assert(Termo),!,fail.

% predicado disponibilizado pelo professor na semana5
% solucoes X,Y,Z -> {V,F}
solucoes(X,Y,Z):-findall(X,Y,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
Questao.
demo( Questao, falso ) :-
-Questao.
demo( Questao,desconhecido ) :-
nao( Questao ),
nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
Questao, !, fail.
nao( Questao ).

% Funcoes sobre listas ----------------------------------------------------------------------------------------------------------

% Extensao do meta-predicado nao : Questao -> {V,F}
nao(Questao) :- Questao, !, fail.
nao(_).

% Verifica se elemento existe dentro de uma lista de elementos
pertence(X,[X | _ ]).
pertence(X,[ _ | XS]) :- pertence(X,XS).

% Nr de elementos existentes numa lista 
comprimento([],0).
comprimento([_ | L],R) :- comprimento(L,N),R is N+1.

% Apaga a primeira ocurrencia de um elemento numa lista
apagar(X, [X | XS], XS).
apagar(E, [X | XS], [X | YS]) :- apagar(E, XS, YS).

% Apaga todas as ocurrencias de um elemento numa lista
apagartudo(_, [], []).
apagartudo(X,[X | XS], YS) :- apagartudo(X,XS,YS).
apagartudo(E,[X | XS], [X | YS]) :- apagartudo(E, XS, YS).

% Insere elemento a cabeca da lista, caso ainda nao exista
adicionar(X, L, L) :- pertence(X,L).
adicionar(X, L, [X | L]).

% Concatenacao da lista L1 com lista L2
concatenar([], L2, L2).
concatenar([X | L1], L2, [X | R]) :- concatenar(L1, L2, R).

% Inverte ordem dos elementos de uma lista
inverter([X],[X]).
inverter([X | XS], L2) :- inverter(XS, YS), concatenar(YS,[X],L2).

% Verifica se S e sublista de L
sublista(S,L) :- concatenar(S,_,L).
sublista(S,L) :- concatenar(_,S,L).
sublista(S, [ _ | YS]) :- 
  sublista(S, YS).

% Remove elementos duplicados de uma lista
removerduplicados([],[]).
removerduplicados([H|T],C) :- pertence(H,T), !, removerduplicados(T,C).
removerduplicados([H|T],[H|C]) :- removerduplicados(T,C).

% Subtrai elementos de L1 a L2, produzindo L3
intercepcao([], L, L).
intercepcao([H | Tail], L2, L3) :- apagar(H, L2, R), intercepcao(Tail, R, L3).

