--DROP FUNCTION gerarelatorio(integer);
CREATE OR REPLACE FUNCTION  northwind.geraRelatorio (IN cod integer, OUT indentificador_pedido integer,OUT consumidor varchar, OUT cidade_consumidor varchar, OUT data_pedido timestamp without time zone, OUT valortotalpedido numeric)
RETURNS RECORD AS $$
SELECT o.orderid, c.companyname, c.city,
o.orderdate, sum(od.unitprice * od.quantity *(1 - od.discount)) 
FROM northwind.orders o JOIN northwind.order_details od ON o.orderid = od.orderid 
JOIN northwind.customers c ON c.customerid = o.customerid
WHERE o.orderid = cod 
GROUP BY (o.orderid, c.companyname, c.city)
$$ LANGUAGE sql;

GRANT EXECUTE ON FUNCTION northwind.gerarelatorio(integer) TO gerente;
GRANT SELECT ON northwind.orders, northwind.customers, northwind.order_details TO gerente;

/*SELECT * FROM geraRelatorio(10248);
SELECT * FROM geraRelatorio(10291);

SELECT * FROM northwind.order_details;
SELECT * FROM pg_roles where rolname = 'gerente';
select * from information_schema.role_table_grants where grantee='gerente';*/