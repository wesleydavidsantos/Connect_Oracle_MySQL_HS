
--
-- Package Conexão DB_LINK


CREATE OR REPLACE PACKAGE MYSQL_QUERY AS
--
--
-- Realiza de forma simples a conexão HS (Heterogeneous Services) entre o Oracle e o MySQL
--
-- Modo de Usar:
--
-- MYSQL_QUERY.NOVA_QUERY;
-- MYSQL_QUERY.SET_BIND( 10 );
-- MYSQL_QUERY.SET_BIND( 'Wesley' );
-- MYSQL_QUERY.SET_BIND( 'Belo Horizonte' );
-- MYSQL_QUERY.EXECUTA_QUERY( 'INSERT INTO MINHA_TABELA_NO_MYSQL ( ID, NOME, CIDADE ) VALUES ( ?, ?, ? )' );
-- COMMIT;
--
-- Autor: Wesley David Santos
-- Skype: wesleydavidsantos		
-- https://www.linkedin.com/in/wesleydavidsantos
--
	

	PROCEDURE NOVA_QUERY;
	
	PROCEDURE SET_BIND( p_BIND IN VARCHAR2 );
		
	PROCEDURE EXECUTA_QUERY( p_QUERY IN VARCHAR2 );  
  
END MYSQL_QUERY;
/




CREATE OR REPLACE PACKAGE BODY MYSQL_QUERY AS

--
--
-- Realiza de forma simples a conexão HS (Heterogeneous Services) entre o Oracle e o MySQL
--
-- Modo de Usar:
--
-- MYSQL_QUERY.NOVA_QUERY;
-- MYSQL_QUERY.SET_BIND( 10 );
-- MYSQL_QUERY.SET_BIND( 'Wesley' );
-- MYSQL_QUERY.SET_BIND( 'Belo Horizonte' );
-- MYSQL_QUERY.EXECUTA_QUERY( 'INSERT INTO MINHA_TABELA_NO_MYSQL ( ID, NOME, CIDADE ) VALUES ( ?, ?, ? )' );
-- COMMIT;
--
-- Autor: Wesley David Santos
-- Skype: wesleydavidsantos		
-- https://www.linkedin.com/in/wesleydavidsantos
--
  
  
	-- Armazena os Binds que serão usados na execução da Query
	TYPE BIND_QUERY IS RECORD (
		BIND VARCHAR2(4000)
	);


	TYPE TBL_BIND_QUERY IS TABLE OF BIND_QUERY INDEX BY BINARY_INTEGER;


	LISTA_BIND TBL_BIND_QUERY;
	
	
	
	-- Realiza um reset dos Binds
	PROCEDURE NOVA_QUERY AS
	BEGIN
		
		FOR v_INDEX IN 1..LISTA_BIND.COUNT LOOP

		  LISTA_BIND.DELETE( v_INDEX );

		END LOOP;

	END;
	
	
	PROCEDURE SET_BIND( p_BIND IN VARCHAR2 ) AS
		
		v_INDEX BINARY_INTEGER;
	
	BEGIN
		
		v_INDEX := LISTA_BIND.COUNT + 1;

		LISTA_BIND( v_INDEX ).BIND := p_BIND;

	END;
		

	PROCEDURE EXECUTA_QUERY( p_QUERY IN VARCHAR2 ) AS

		c INTEGER;
		
		nr INTEGER;
		
		RAISE_ERRO_OTHERS EXCEPTION;

	BEGIN


		-- Abre o cursor
		c := DBMS_HS_PASSTHROUGH.OPEN_CURSOR@NOME_DO_SEU_DBLINK;


		-- Define a query usando 3 bind variables
		DBMS_HS_PASSTHROUGH.PARSE@NOME_DO_SEU_DBLINK( c,  p_QUERY );
		
		
		
		-- Atribui os valores das bind variables
		FOR v_INDEX IN 1..LISTA_BIND.COUNT LOOP
			
			DBMS_HS_PASSTHROUGH.BIND_VARIABLE@NOME_DO_SEU_DBLINK( c, v_INDEX, LISTA_BIND( v_INDEX ).BIND );

		END LOOP;


		-- Executa a query
		nr := DBMS_HS_PASSTHROUGH.EXECUTE_NON_QUERY@NOME_DO_SEU_DBLINK(c);


		-- Fecha o cursor
		DBMS_HS_PASSTHROUGH.CLOSE_CURSOR@NOME_DO_SEU_DBLINK(c);
		

	-- Tratamento de exceções
	EXCEPTION
	WHEN OTHERS THEN

		DBMS_OUTPUT.PUT_LINE('Erro ao executar a query: ' || SQLERRM);
		
		RAISE RAISE_ERRO_OTHERS;
		
	END;
    
  
END MYSQL_QUERY;
/



