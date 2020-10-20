# Business Intelligence

Como sabemos, uma dimensão tempo é indispensável em nossas análises do dia-a-dia. Por isso um script para criar essa dimensão é sempre útil.

O script `dim_tempo.sql`, desenvolvido e testado em [Postgresql 11.8](https://www.postgresql.org/docs/11/index.html) cria uma dimensão de tempo com a estrutura a seguir:

```sql
select column_name
     , is_nullable
     , data_type
     , character_maximum_length
     , udt_name 
 from information_schema.columns
where table_name = 'dim_tempo'
;
```

| column\_name     | is\_nullable | data\_type        | character\_maximum\_length | udt\_name |
| ---------------- | ------------ | ----------------- | -------------------------- | --------- |
| id\_tempo        | NO           | bigint            |                            | int8      |
| nr\_ano          | NO           | smallint          |                            | int2      |
| nr\_semestre     | NO           | smallint          |                            | int2      |
| nr\_quadrimestre | NO           | smallint          |                            | int2      |
| nr\_trimestre    | NO           | smallint          |                            | int2      |
| nr\_bimestre     | NO           | smallint          |                            | int2      |
| nr\_mes          | NO           | smallint          |                            | int2      |
| nm\_mes          | NO           | character varying | 10                         | varchar   |
| nm\_dia\_semana  | NO           | character varying | 10                         | varchar   |
| nr\_dia\_ano     | NO           | smallint          |                            | int2      |
| nr\_dia\_mes     | NO           | smallint          |                            | int2      |
| nr\_hora         | NO           | smallint          |                            | int2      |





## Amostra de exemplo:
```sql 
select * from public.dim_tempo order by random() limit 10;
```
id_tempo      |nr_ano|nr_semestre|nr_quadrimestre|nr_trimestre|nr_bimestre|nr_mes|nm_mes   |nm_dia_semana|nr_dia_ano|nr_dia_mes|nr_hora|
--------------|------|-----------|---------------|------------|-----------|------|---------|-------------|----------|----------|-------|
20120104150000|  2012|          1|              1|           1|          1|     1|Janeiro  |Quarta       |         4|         4|     15|
20160201060000|  2016|          1|              1|           1|          1|     2|Fevereiro|Segunda      |        32|         1|      6|
20120807110000|  2012|          2|              2|           3|          4|     8|Agosto   |Terça        |       220|         7|     11|
20120121060000|  2012|          1|              1|           1|          1|     1|Janeiro  |Sábado       |        21|        21|      6|
20150819090000|  2015|          2|              2|           3|          4|     8|Agosto   |Quarta       |       231|        19|      9|
20181218080000|  2018|          2|              3|           4|          6|    12|Dezembro |Terça        |       352|        18|      8|
20121012210000|  2012|          2|              3|           4|          5|    10|Outubro  |Sexta        |       286|        12|     21|
20110812170000|  2011|          2|              2|           3|          4|     8|Agosto   |Sexta        |       224|        12|     17|
20170901210000|  2017|          2|              3|           3|          5|     9|Setembro |Sexta        |       244|         1|     21|
20150625130000|  2015|          1|              2|           2|          3|     6|Junho    |Quinta       |       176|        25|     13|
