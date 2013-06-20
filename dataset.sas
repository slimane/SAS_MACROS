/* obserbationの数をカウント */
%macro obscnt(ds, output_var);
    %global &ouputVar;
    data _null_;
        set &ds. nobs = cnt;
        call symput("&ouputVar", left(put(cnt, 8.)));
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
