# Connect_Oracle_MySQL_HS
Package que realiza de forma simples a conexão HS (Heterogeneous Services) entre o Oracle e o MySQL

Observação: Você já deve ter realizado toda a configuração do drive ODBC, tnsname e Listener

Modo de Usar:

```
MYSQL_QUERY.NOVA_QUERY;
MYSQL_QUERY.SET_BIND( 10 );
MYSQL_QUERY.SET_BIND( 'Wesley' );
MYSQL_QUERY.SET_BIND( 'Belo Horizonte' );
MYSQL_QUERY.EXECUTA_QUERY( 'INSERT INTO MINHA_TABELA_NO_MYSQL ( ID, NOME, CIDADE ) VALUES ( ?, ?, ? )' );
COMMIT;
```



Assista ao vídeo no YouTube mostrando o funcionamento:

[![Oracle e o MySQL forma simples de conexão HS (Heterogeneous Services)](https://img.youtube.com/vi/VKaAvXXV1Hs/0.jpg)](https://youtu.be/VKaAvXXV1Hs)
