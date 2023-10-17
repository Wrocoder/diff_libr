2 tables:
Clients:
    client_id
    client_name

Card:
    Card_id
    client_id
    limit_usd
    date_issue

--1.Найти колличество  держателей карт и колличество карт, то есть 20 держателей имеют по 5 карт,
--    10 держателей имеют по 3 карты и т д.

With CTE As
(
select  CR.client_id as id, count(CL.Card_id) as ccc from Clients as cl
	LEFT JOIN Card as CR
	on CR.client_id = CL.client_id
	group by CL.client_id
)
select count(CTE.id) , CTE.ccc from CTE
group by CTE.ccc

--2. Найти и с аккумулировать по месяцам наростающий итог лимитов по картам

With CTE as
(
select Month(date_issue) as mnth, sum(limit_usd) from Card
group by  mnth
)
select CTE.mnth, sum(CTE.limit_usd) over (order by CTE.mnth)
from CTE

PYTHON
1. Написать декоратор который будет считать сколько раз он вызывался
я описал структуру и что это и зачем, набросал код, интервтьюер сказал спроси у CHATGPT и опиши что тут происходит:)