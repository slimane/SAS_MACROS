/*
    filepath    :   sas化したいexccelファイル
    sheet       :   sasにしたい対象シート
    max_columns  :   範囲指定、行の最大値
    key_item     :   primary key -> これがnot nullなら出力
    out_ds       :   出力データセット名
*/
/* NOTE : 実際に使用するときには%create_excel_lib(&filepath., lst)の部分をマクロ外でやった方がいいかもしれない
理由としては、ファイル読み込み時に時間がかかるため。*/
%macro excel_to_lib(filepath, libname);
    libname &libname. excel "&filepath."
        access = readonly
        header = yes
        mixed  = yes
        ;
%mend;



/* 使用例 */
/*  %excel_to_sas(&ABC., EXCEL_FILE,10000, COLUMN_A, DS_NAME); */
%macro excel_to_sas(filepath, libname, sheet, max_columns, key_item,  out_ds,);
    %create_excel_lib(&filepath., &libname.)
    data &out_ds.;
        set &libname.."&sheet.$"n(
                        obs       = &max_columns.
                        );
        where &key_item. <> "";
    run;
    libname &libname. clear;
%mend;




%macro excel_to_lib(file_path, libname);
    %if "&libname_&libname._is_exist" ne "existed" %then %do;
        libname &libname. excel "&file_path."
            access = readonly
            header = yes
            mixed  = yes
            ;
    %end;
    %else %do;
        %let libname_&libname._is_exist = existed;
    %end;
%mend;
