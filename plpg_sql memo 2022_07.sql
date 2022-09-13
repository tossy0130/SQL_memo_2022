--- ============== pl/pgsql  function test 作成 基礎 01
create or replace function test(in name text)
returns text as $$
	declare res text := name;
begin
	return res;
end;
$$ language plpgsql;

--- ストアド function 実行　
select test('tossy');


--- ============== pl/pgsql  function test_02 作成 基礎 02
create or replace function test_02(in name text)
returns text as $$ 
	declare tmp text := name;
begin 
	select '文字列結合' || tmp || '.' into tmp;
	return tmp;
end;
$$ language plpgsql;
