# Connect_Oracle_MySQL_HS
Package que realiza de forma simples a conexão HS (Heterogeneous Services) entre o Oracle e o MySQL

Modo de Usar:

MYSQL_QUERY.NOVA_QUERY;
MYSQL_QUERY.SET_BIND( 10 );
MYSQL_QUERY.SET_BIND( 'Wesley' );
MYSQL_QUERY.SET_BIND( 'Belo Horizonte' );
MYSQL_QUERY.EXECUTA_QUERY( 'INSERT INTO MINHA_TABELA_NO_MYSQL ( ID, NOME, CIDADE ) VALUES ( ?, ?, ? )' );
COMMIT;

