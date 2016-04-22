%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
%
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic jogo/3.
:- dynamic nasceu/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

-filho( F,P ) :-
    nao( filho( F,P ) ),
    nao( excecao( filho( F,P ) ) ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filhoP( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), N == 1
                  ).

% Invariante Referencial: nao admitir mais do que 1 progenitor paterno
%                         para um mesmo individuo

+filhoP( F,P ) :: (solucoes( (Ps),(filhoP( F,Ps )),S ),
                  comprimento( S,N ), N =< 1
                  ).

filhoP( ana, abel).
filhoM( ana, alice).
filhoP( anibal, antonio).
filhoM( anibal, alberta).
filhoP( berta, bras).
filhoM( berta, belem).
filhoP( berto, bras).
filhoM( berto, belem).
filhoM( crispim, catia).
filhoP( danilo, daniel).
filhoP( eurico, elias).
filhoM( eurico, elsa).

%%%% IMPRECISO %%%%%
excecao( filhoP( crispim,celso ) ).
excecao( filhoP( crispim,caio ) ).

excecao( filhoP( fabia,fausto ) ).
excecao( filhoP( octavia,fausto ) ).

%%%% INCERTO %%%%
filhoM( danilo,xpto023 ).

filhoM( fabia,xpto023 ).
filhoM( octavia,xpto023 ).

% Extensao do predicado nasceu : Pessoa, Data -> {V,F,D}

nasceu( ana, 01, 01, 2010).
nasceu( anibal, 02,01,2010).
nasceu( berta, 02,02,2010).
nasceu( berto, 02,02,2010).
nasceu( catia, 03,03,2010).
nasceu( danilo, 04,04,2010).

excecao( nasceu( eurico,05,05,2010 ) ).
excecao( nasceu( eurico,06,05,2010 ) ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
% repetido

-nasceu( P,D,M,A ) :-
    nao( nasceu( P,D,M,A ) ),
    nao( excecao( pessoa( P,D,M,A ) ) ).

+nasceu( P,D,M,A ) :: ( solucoes((P,D,M,A), nasceu(P,D,M,A),S),
                  comprimento(S,N), N == 1  
                  ).

% Invariante Referencial: nao admitir mais do que 1 data
%                         para um mesmo individuo

+nasceu( P,D ) :: (solucoes( (Dt),(nasceu( P,Dt )),S ),
                  comprimento( S,N ), N =< 1
                  ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Explicitacao das situacoes de excecao

% A Belem e filha de uma pessoa de que se desconhece a identidade

filho( belem,xpto023 ).
excecao( filho( F,P ) ) :-
    filho( F,xpto023 ).

% A Maria é filha do Faria ou do Garcia

excecao( filho( maria,faria ) ).
excecao( filho( maria,garcia ) ).

% O Julio tem um filho que ninguem pode conhecer

filho( xpto732,julio ).
excecao( filho( F,P ) ) :-
    filho( xpto732,P ).
nulo( xpto732 ).
+filho( F,P ) :: (solucoes( (Fs,P),(filho(Fs,julio),nao(nulo(Fs))),S ),
                  comprimento( S,N ), N == 0 
                  ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensao do predicado jogo: Id, Arb, Custo -> {V,F,D}
%O arbitro Almeida Antunes apitou o primeiro jogo do campeonato, 
%no qual recebeu 500euros como ajudas de custo;

jogo(1,almeida_antunes,500).
-jogo(J,ARB,AJU) :- nao(jogo(J,ARB,AJU)),
                    nao(excecao(jogo(J,ARB,AJU))).

%O arbitro Baltazar Borges apitou o segundo jogo, 
%tendo recebido a titulo de ajudas de custo um 
%valor que ainda ninguem conhece;
jogo(2,baltazar_borges,xpto123).
excecao(jogo(J,ARB,AJU)) :- jogo(J,A,xpto123).

% Consta na ficha de jogo da terceira partida, que o arbitro Costa Carvalho 
% recebeu 500, mas a comunicacao social alega ter-lhe sido pago mais 2.000
% (como compensacao por danos no seu veiculo); 
% instado a pronunciar-se sobre o assunto, o arbitro nao confirma nem desmente 
% nenhum dos valores noticiados;
excecao(jogo(3,costa_carvalho,500)).
excecao(jogo(3,costa_carvalho,2500)).

% O arbitro Duarte Durao apitou o quarto jogo, tendo recebido como 
% ajudas de custo um valor que ronda os 250 a 750, desconhecendo-se 
% qual a quantia exata;
excecao(jogo(4,duarte_durao,Y)) :- Y =< 750, Y >=250.

% No quinto jogo apitado pelo arbitro Edgar Esteves, 
% ocorreram tumultos no final do encontro tendo desaparecido as ajudas 
% de custo da carteira do arbitro, pelo que se torna impossivel 
% vir-se a conhecer esse valor;
jogo(5,edgar_esteves,xpto333).
excecao( jogo(J,ARB,AJU)) :- jogo(J,ARB,xpto333).
nulo( xpto333 ).
+jogo( J, ARB, AJU ) :: (solucoes( (J,ARB,Aju),(jogo(5,edgar_esteves, Aju),nao(nulo(Aju))),S ),
                  comprimento( S,N ), N == 0 
                  ).

% O arbitro do sexto jogo, Francisco Franca recebeu, como ajudas de custo, 
% o valor de 250; no entanto, entre amigos, refere ter encaixado nesse 
% dia para cima de 5.000;
jogo(6,francisco_franca,250). 
excecao(jogo(6,francisco_franca,Y)) :- Y >= 5000.


% O arbitro Guerra Godinho que apitou o setimo jogo, declara ser falso que 
% alguma vez tenha recebido os 2.500 que a comunicacao social refere como 
% tendo entrado na sua conta bancaria; contudo, este arbitro 
% nunca confirmou o valor exato das ajudas de custo que recebeu;
-jogo(7,guerra_godinho,2500).
excecao(jogo(7,guerra_godinho,Y)) :- nao(Y = 2500).

% Na¿o se conhecendo com exatidao o valor das ajudas de custo entregues 
% ao arbitro Hlder Heitor no oitavo jogo, aceita-se ter sido um valor 
% cerca dos 1.000;
excecao(jogo(8,helder_heitor,Y)) :- Y >= 990, Y =< 1010.

% Apesar de nao se conhecer o valor exato das ajudas de custo pagas 
% ao arbitro do nono jogo, Ivo Inocencio, este tera recebido uma quantia 
% muito proxima dos 3.000;
excecao(jogo(9,ivo_inocencio,Y)) :- Y >= 2990, Y =< 3010.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).
