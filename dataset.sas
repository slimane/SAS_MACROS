/* obserbationの数をカウント */
%macro obs_cnt(ds, output_var);
    %global &ouput_var;
    data _null_;
        set &ds. nobs = cnt;
        call symput("&ouput_var", left(put(cnt, 8.)));
        stop;
    run;
%mend;




/* 変数の数(列数)をカウント */
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
