select replace(output,CHR(10),'') from
(
select tt_id || '|' ||
       jb_id || '|' ||
       jb_start_date || '|' ||
       jb_finish_date || '|' ||
      -- jb_create_date,
       jb_priority || '|' ||
       jb_status || '|' ||
       jb_date_action || '|' ||
       replace(title,'|','_') || '|' ||
       jb_site_access || '|' ||
       --  jb_site_affect,
        rtrim(xmlagg(xmlelement(e, jb_site_affect || ',')).extract('//text()').extract('//text()') ,',')  || '|
' ||
       assign_by || '|' ||
       assign_by_tel || '|' ||
       assign_to || '|' ||
       assign_to_tel as output
from (
select             jr.tt_id as tt_id,
                   j.jb_id as jb_id,
                   j.initiate_date as jb_start_date,
                   j.finish_date as jb_finish_date,
                   j.create_date as jb_create_date,
                  (select p.name from priority p where p.id = j.priority_id) as jb_priority,
                  (select js.status from jb_status js where js.jb_status_id = j.status_id) as jb_status,
                   his.create_date as jb_date_action, 
                   his.rank as rank_his,
                   his.rank_status as rank_status,
                       his.jb_history_id,
                   j.title,
                   site.site_code||'('||site.bsc||','||site.msc||')' as jb_site_access,
                  mn.site_code||'('||mn.bsc||','||mn.msc||')' as jb_site_affect,
                 (select U1.FIRSTNAME || ' ' || U1.LASTNAME from tts_user u1 where u1.id = j.assign_by) AS ASSIGN_BY,
                 (select case when u1.mobile_no is null then U1.TEL_NO else  U1.TEL_NO || ', '|| U1.MOBILE_NO end from tts_user u1 where u1.id = j.assign_by) as ASSIGN_BY_TEL,
                 (select U2.FIRSTNAME || ' ' || U2.LASTNAME from tts_user u2 where u2.id = j.assign_to) AS ASSIGN_TO,
                 (select case when u2.mobile_no is null then U2.TEL_NO else  U2.TEL_NO || ', '|| U2.MOBILE_NO end from tts_user u2 where u2.id = j.assign_to) as ASSIGN_TO_TEL
                   from     
                     (select site_id,site_code,bsc,msc 
                     from mnims_site 
                     --#### Input variable find Site_code
                     --where cfms_site like 'MRET%') site 
                     where cfms_site like 'QQQQ%') site 
                   left join jb_site_access a on site.site_id=a.site_id
                   left join (select h.jb_id as jb_id,h.create_date,h.jb_history_id,h.action,
                                     case h.status_id when '04' then 1 else 2 end as rank_status,
                                     rank() over(partition by h.jb_id order by h.jb_history_id desc) as rank 
                              from jb_history h
                              )his on a.jb_id=his.jb_id 
                                      and rank = 1
                   left join jb_relation jr on a.jb_id = jr.jb_id
                   left join jb j on j.jb_id = a.jb_id
                   left join tt_affected_node ta on jr.tt_id = ta.tt_id
                   left join mnims_site mn on mn.site_id = ta.site_id
                   where j.status_id not in ('08','05','07')
                   and j.create_date >= sysdate-(30) 
                   and j.create_date <= sysdate-(1/24/60/60) 
 )    
 group by    tt_id,
       jb_id,
       jb_start_date,
       jb_finish_date,
      -- jb_create_date,
       jb_priority,
       jb_status,
       jb_date_action,
       title,
       jb_site_access,
       assign_by,
       assign_by_tel,
      assign_to,
       assign_to_tel,
       rank_status   
order by rank_status asc,jb_date_action desc           
)