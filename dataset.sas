/*  summary : observationの数(行数)をカウントする
    args    :
        ds          : observationの数を数えたデータセット
        output_var  : 結果を格納するマクロ変数の名称
*/
%macro obs_count(ds, output_var);
    %global &output_var;
    data _null_;
        set &ds. nobs = cnt;
        call symput("&output_var", left(put(cnt, 8.)));
        stop;
    run;
%mend;




/*  summary : データセットの変数の数(列数)をカウントする
    args    :
        ds          : 変数の個数カウントしたいデータセット
        output_var  : 結果を格納するマクロ変数の名称
*/
%macro var_count(ds, output_var);
    %global &output_var;
    proc contents
        data = &ds.
        out = _tmpxx_ noprint;
    run;
    data _null_ ;
        set _tmpxx_ nobs = cnt;
        call symput("&output_var", left(put(cnt, 8.)));
        stop;
    run;
%mend;




/*  summary : 連番を生成する
    args    :
        in_ds        : 元データセット
        out_ds       : 出力データセット
        num_column   : 連番出力カラム名
        min          : 連番の初期値
        grouping_key : group化するための変数(スペース区切りで複数指定可能)
*/
%macro generate_seq(in_ds, out_ds, num_column, min, grouping_key);
    data &out_ds.;
        set
            &in_ds.;
        by
            &grouping_key.;

        retain
            temp_number_variable;

        if first.&grouping_key. then
            temp_number_variable = &min.;
        else
            temp_number_variable + 1;

        &num_column. = temp_number_variable;

        drop temp_number_variable;
    run;
%mend;




/*  summary : sortプロシージャーのショットカット
    args    :
        in_ds       : 元データセット
        out_ds      : 出力データセット
        key_item    : 並び変えキー
        options     : option(スペース区切りで複数指定可能)
*/
%macro o_sort(in_ds, out_ds, key_item, options);
    proc sort
        data = &in_ds.
        out  = &out_ds.
        &options.
        ;

        by
            &key_item.
            ;
    run;
%mend;
