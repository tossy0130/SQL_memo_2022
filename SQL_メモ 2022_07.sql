
------- ========== Q8  ポジション　毎の　ゴール数　を表示
select p.position as ポジション, count(g.id) as ゴール数
from players p
left outer join goals g on g.player_id = p.id
group by p.position
order by ゴール数 desc;

------ ========== Q9 2014-06-13 時点での年齢を表示
select birth, date_part('year', age('2014-06-13', birth)) as age, name, position 
from players
order by age desc;

-----  ========== Q 10 player_id の null を表示 IS null
select count(id) as オウンゴール from goals where player_id IS null
group by player_id;

------- ========== Q11 2014-6-13から2014-6-27までに行われていました。
select countries.group_name, count(goals.id)
from goals
left outer join pairings on pairings.id = goals.pairing_id 
left outer join countries on countries.id = pairings.my_country_id 
where pairings.kickoff between '2014-06-13 0:00:00' and '2014-06-27 23:59:59'
group by countries.group_name 
order by countries.group_name asc;




--------------------------- サッカー Q1 ---------------------------
--- 各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
--- グループ, ランキング最上位, ラインキング最下位
select * from countries;
select * from players;
select * from pairings;
select * from goals;

--- Q1 答え
select group_name, MAX(ranking) as ランキング最上位, MIN(ranking) as ランキング最下位 from countries
GROUP by group_name;

--------------------------- サッカー Q2 position ---------------------------
--- 全ゴールキーパーの平均身長、平均体重を表示してください
--- 平均身長, 平均体重
select AVG(height) as 平均身長, AVG(weight) as 平均体重 
from players
where position = 'GK';

select AVG(height) as 平均身長, AVG(weight) as 平均体重 
from players
where position like 'GK%';

--------------------------- サッカー Q3 position ---------------------------
---------- 各国の平均身長を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
--- 国名, 平均身長
select countries.name as 国名,AVG(players.height) as 平均身長 
from players left outer join countries on players.country_id = countries.id  
group by countries.name
order by 平均身長 DESC;

--------------------------- サッカー Q4 position 副問い合わせ サブクエリー ---------------------------
--- 各国の平均身長を高い方から順に表示してください。ただし、FROM句はplayersテーブルとして、
--- テーブル結合を使わず副問合せを用いてください。
select (select c.name from countries c where p.country_id = c.id) as 国名, 
	AVG(p.height) as 平均身長
	from players p 
	GROUP by p.country_id 
	order by AVG(p.height) desc;


--------------------------- Q5----------------------------------------------------------
---サッカー Q4 キックオフ日時と対戦国の国名をキックオフ日時の
--早いものから順に表示してください。 ---------------------------
select p.kickoff as キックオフ日時, c.name as 国名1, 
	c2.name as 国名2
	from pairings p 
	left outer join countries c on c.id = p.my_country_id
	left outer join countries c2 on c2.id = p.enemy_country_id 
	order by キックオフ日時 asc;


--------------------------- Q6----------------------------------------------------------
select * from countries;
select * from players;
select * from pairings;
select * from goals;
 


------------------ スペシャル Q1
--- 別別のテーブルにある　国ごとの　平均身長　を　降順に　並べる
--
SELECT countries.name AS 国名, AVG(players.height) AS 平均身長 FROM countries
LEFT OUTER JOIN players on countries.id = players.country_id 
GROUP BY countries.name 
ORDER BY 平均身長 DESC;

--- キーワード　サブクエリ
select * from players 
where 20 < (select weight / POW(height / 100, 2));


SELECT *
FROM players
WHERE weight / POW(height / 100, 2) >= 20 AND weight / POW(height / 100, 2) < 21;

SELECT *
FROM players
WHERE weight / POW(height / 100, 2) >= 20 and weight / POW(height / 90, 2) < 21;

----

-------------------- 予約カレンダー用　火葬枠　取得　（時間）
select 火葬枠番号 , 火葬枠名 , 予約枠数 ,予約時刻
	from 火葬枠;


--- 業者コード　と　担当者コード　を結合　
select 業者.業者コード , 業者.業者名  , 担当者.担当者名 , 担当者."ログインＩＤ" ,担当者.メールアドレス 
	from 業者
	left outer join 担当者
	on 業者.業者コード = 担当者.業者コード 
where 
	担当者.業者コード = '9998';
-----------------------------------

--- 業者コード　と　担当者コード　を結合　
select 業者.業者コード ,担当者.担当者名 
	from 業者
	left outer join 担当者
	on 業者.業者コード = 担当者.業者コード 
where 
	担当者.業者コード = '1000' and 担当者."ログインＩＤ" = 'natsume';

----

select * from 火葬受付;
select * from 火葬台帳;
---- ===================  予約状況　取得 SQL
select distinct 火葬受付.受付番号, 火葬受付.予約日, 火葬受付.待合利用区分,火葬受付.式場利用区分,火葬受付.通夜利用区分,火葬受付.霊安室利用区分, 
	火葬台帳.申請者姓, 火葬台帳.申請者名
	from 火葬受付
	left outer join 火葬台帳
	on 火葬受付.受付番号 = 火葬台帳.整理番号 
	where　火葬受付.業者コード = '1000'
	order by 火葬受付.受付番号 desc;