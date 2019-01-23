
select regexp_replace(dia::text, '[^0-9]+', '', 'g')::bigint as id_tempo,
    date_part('year', dia) as nr_ano,
    case when date_part('month', dia) between 1 and 6  then 1
         when date_part('month', dia) between 7 and 12 then 2
         else 0
     end as nr_semestre,
    case when date_part('month', dia) between  1 and 4  then 1
         when date_part('month', dia) between  5 and 8  then 2
         when date_part('month', dia) between  9 and 12 then 3
         else 0 
     end as nr_quadrimestre,
    case when date_part('month', dia) between  1 and 3  then 1
         when date_part('month', dia) between  4 and 6  then 2
         when date_part('month', dia) between  7 and 9  then 3
         when date_part('month', dia) between 10 and 12 then 4
         else 0 
     end as nr_trimestre,
    case when date_part('month', dia) between  1 and 2  then 1
         when date_part('month', dia) between  3 and 4  then 2
         when date_part('month', dia) between  5 and 6  then 3
         when date_part('month', dia) between  7 and 8  then 4
         when date_part('month', dia) between  9 and 10 then 5
         when date_part('month', dia) between 11 and 12 then 6
         else 0 
     end as nr_bimestre,
    date_part('month', dia) as nr_mes,
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
         else '** Erro **'        
    end as nm_mes,
    case extract('dow' from dia) 
         when 0 then 'Domingo' 
         when 1 then 'Segunda'
         when 2 then 'Terça'
         when 3 then 'Quarta'
         when 4 then 'Quinta'
         when 5 then 'Sexta'
         when 6 then 'Sábado'
         else '** Erro **'
     end as nm_dia_semana,
    extract('doy' from dia) as nr_dia_ano,
    date_part('day', dia) as nr_dia_mes,
    date_part('hour', dia) as hora
  from (
    select generate_series(
            date (now()::timestamp - interval '10 year')::timestamp, 
            date (now())::timestamp, 
            interval '1 hour'
        ) as dia
  ) as d
