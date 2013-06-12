/*
    filepath    :   sas化したいexccelファイル
    sheet       :   sasにしたい対象シート
    maxColumns  :   範囲指定、行の最大値
    keyItem     :   primary key -> これがnot nullなら出力
    outDs       :   出力データセット名
*/
/* NOTE : 実際に使用するときには%createExcelLib(&filepath., lst)の部分をマクロ外でやった方がいいかもしれない
理由としては、ファイル読み込み時に時間がかかるため。*/
%macro createExcelLib(filepath, libname);
    libname &libname. excel "&filepath."
                            access = readonly
                            header = yes
                            mixed  = yes
                            ;
%mend;



/* 使用例 */
/*  %excelToSas(&PCVMGR., PDP_LOC114877_CONDRG01,10000, D__PROT, PDP_LOC114877_CONDRG01); */
%macro excelToSas(filepath, libname, sheet, maxColumns, keyItem,  outDs,);
    %createExcelLib(&filepath., lst)
    data &outDs.;
        set &libname.."&sheet.$"n(
                        obs       = &maxColumns.
                        );
        where &keyItem. <> "";
    run;
    libname lst clear;
%mend;
