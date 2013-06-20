/* 変数の方をチェック */
/* NOTE : vtypeは戻り値が分かりづらいため */
%macro is_char(data);
	vtype(&data.)  = "C"
%mend;

%macro is_num(data);
	vtype(&data.) = "N"
%mend;




/* */
/* missing data */
/* like to nvl_function(character ver.) */
%macro nvl_c(data1, data2);
	ifc(not missing(&data1.)
		, &data1.
		, &data2.)
%mend;

/* like to nvl_function(numeric ver.) */
%macro nvl_n(data1, data2);
	ifn(not missing(&data1.)
		, &data1.
		, &data2.)
%mend;






/* 0埋め */
%macro fill_zero(invar, format);
	put(input(&invar., best12.), &format.)
%mend;




/* 与えられた2つの値のうち大きい方を返す*/
%macro get_greater_n(val1, val2);
	ifn(&val1. > &val2.
		, &val1.
		, &val2.
	)
%mend;

/* 与えられた値のうち小さい方を返す */
%macro get_lesser_n(val1, val2);
	ifn(&val1. < &val2.
		, &val1.
		, &val2.
	)
%mend;



%macro like_dictionary(ds, key, val);
	%create_dictionary(&ds.);

	proc sql;
		INSERT INTO &ds.
			SET key_val = "&key."
				, val	= "&val."
		;
	quit;
%mend;




%macro create_dictionary(ds);
	%if not %sysfunc(exist(&ds.)) %then %do;
		proc sql;
			CREATE TABLE &ds.
			(
				key_val	VARCHAR(255)
				, val	VARCHAR(5000)
				, constraint prim_key    primary key(key_val)
			)
			;
		quit;
	%end;
%mend;




/* 期間計算 */
/* NOTE : 日付けが数値型の場合 */
%macro get_term_n(start, end);
	ifn(&start. <= &end.
		, &end. &start. + 1
		, &end. - &start.
	)
%mend;

/* NOTE : 日付けが文字型の場合 */
%macro get_term_c(start, end, format);
	%get_greater_n(input(&start., &format.), input(&end., &format.))
%mend;




/* 与えられた値が適切な日付け形式か否か*/
/* NOTE: 31日がある月や2月の対応などが必要だが、
        複雑な正規表現にすると処理速度の問題があるため最低現のチェックのみ */
%macro test();
	^\d{4}[/-](0?[1-9]|1[0-2])[/-](0?[1-9]|[12][0-9]|3[01])$
%mend;



/* 与えられた値が適切な時刻形式か否か*/
%macro test();
	^(0?[0-9]|1[0-9]|2[0-4]):(0{1,2}|[1-5][0-9]|60)$
%mend;
