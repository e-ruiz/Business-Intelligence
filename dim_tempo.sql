--
-- PostgreSQL 9.6
--
-- Gerador de dimensão de tempo
-- @link https://www.postgresql.org/docs/9.6/functions-datetime.html
--
-- (!) No rodapé do código, você define o intervalo de tempo desejado,
--     assim como o salto, ex. hora em hora, dia a dia, etc.
--

-- gera a tabela dim_tempo
create table public.dim_tempo (
  id_tempo bigint not null,
  nr_ano smallint not null,
  nr_semestre smallint not null,
  nr_quadrimestre smallint not null,
  nr_trimestre smallint not null,
  nr_bimestre smallint not null,
  nr_mes smallint not null,
  nm_mes varchar(10) not null,
  nm_dia_semana varchar(10) not null,
  nr_dia_ano smallint not null,
  nr_dia_mes smallint not null,
  nr_hora smallint not null
);

-- insere os dados na tabela
-- deixei as colunas mapeadas facilitando a compreensão e customização
insert into public.dim_tempo (
  id_tempo,
  nr_ano,
  nr_semestre,
  nr_quadrimestre,
  nr_trimestre,
  nr_bimestre,
  nr_mes,
  nm_mes,
  nm_dia_semana,
  nr_dia_ano,
  nr_dia_mes,
  nr_hora
)
-- gera as datas
select 
    -- gera ID com capturando somente os numeros contidos na data-hora    
    regexp_replace(dia::text, '[^0-9]+', '', 'g')::bigint as id_tempo,
    
    -- captura o ano
    date_part('year', dia) as nr_ano,
    
    -- captura o semestre
    case when date_part('month', dia) between 1 and 6  then 1
         when date_part('month', dia) between 7 and 12 then 2
         else 0 -- excesso de zelo
     end as nr_semestre,
    
    -- captura o quadrimestre
    case when date_part('month', dia) between  1 and 4  then 1
         when date_part('month', dia) between  5 and 8  then 2
         when date_part('month', dia) between  9 and 12 then 3
         else 0 -- excesso de zelo
     end as nr_quadrimestre,
    
    -- captura o trimestre
    case when date_part('month', dia) between  1 and 3  then 1
         when date_part('month', dia) between  4 and 6  then 2
         when date_part('month', dia) between  7 and 9  then 3
         when date_part('month', dia) between 10 and 12 then 4
         else 0 -- excesso de zelo
     end as nr_trimestre,
    
    -- captura o bimestre
    case when date_part('month', dia) between  1 and 2  then 1
         when date_part('month', dia) between  3 and 4  then 2
         when date_part('month', dia) between  5 and 6  then 3
         when date_part('month', dia) between  7 and 8  then 4
         when date_part('month', dia) between  9 and 10 then 5
         when date_part('month', dia) between 11 and 12 then 6
         else 0 -- excesso de zelo
     end as nr_bimestre,
    
    -- captura o mes (1 ~ 12)
    date_part('month', dia) as nr_mes,
    
    -- captura o nome do mes em pt-br
    -- obs.: embora seja possível pegar essa informação sem CASE, 
    --       achei mais simples assim, 
    --       pois não depende de configs de LOCALE, etc.
    case date_part('month', dia) 
         when  1 then 'Janeiro'
         when  2 then 'Fevereiro'
         when  3 then 'Março'
         when  4 then 'Abril'
         when  5 then 'Maio'
         when  6 then 'Junho'
         when  7 then 'Julho'
         when  8 then 'Agosto'
         when  9 then 'Setembro'
         when 10 then 'Outubro'
         when 11 then 'Novembro'
         when 12 then 'Dezembro' 
         else '** Erro **' -- excesso de zelo
    end as nm_mes,
    
    -- captura o dia da semana em pt-br (vide obs sobre o mes)
    case extract('dow' from dia) 
         when 0 then 'Domingo' 
         when 1 then 'Segunda'
         when 2 then 'Terça'
         when 3 then 'Quarta'
         when 4 then 'Quinta'
         when 5 then 'Sexta'
         when 6 then 'Sábado'
         else '** Erro **' -- excesso de zelo
     end as nm_dia_semana,
    
    -- captura o dia do ano (1 ~ 365/366)
    extract('doy' from dia) as nr_dia_ano,
    
    -- captura o dia do mes (1 ~ 28/29/30/31)
    date_part('day', dia) as nr_dia_mes,
    
    -- captura a hora (0 ~ 23)
    date_part('hour', dia) as nr_hora
  from (
    -- 
    -- Gera um intervalo de tempo para alimentar a tabela
    -- 
    select generate_series(
            -- define o inicio do intervalo (hoje menos 10 anos)
            date (now()::timestamp - interval '1 year')::timestamp,
            
            -- define o fim do intervalo (hoje, agora) 
            date (now())::timestamp, 
            
            -- define o salto entre cada data (hora em hora)
            interval '1 hour'
        ) as dia
  ) as d;
