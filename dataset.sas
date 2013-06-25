/* obserbationの数をカウント */
%macro obscnt(ds, output_var);
    %global &ouput_var;
    data _null_;
        set &ds. nobs = cnt;
        call symput("&ouput_var", left(put(cnt, 8.)));
        stop;
    run;
%mend;




/* 変数の数(列数)をカウント */
%macro varcnt(ds, output_var);
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




%macro generate_seq(in_ds, out_ds, num_column, key, min);
    data &out_ds.;
        set
            &in_ds.;
        by
            &key.;

        retain
            no;

        if first.&key. then
            no = &min.;
        else
            no + 1;

        &num_column. = no;

        drop no;
    run;
%mend;
