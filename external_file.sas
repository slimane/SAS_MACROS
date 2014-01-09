/*
  filepath    :   sas化したいexccelファイル
  sheet       :   sasにしたい対象シート
  max_columns :   範囲指定、行の最大値
  key_item    :   primary key -> これがnot nullなら出力
  out_ds      :   出力データセット名
*/
/* NOTE : 実際に使用するときには%create_excel_lib(&filepath., lst)の部分をマクロ外でやった方がいいかもしれない
理由としては、ファイル読み込み時に時間がかかるため。*/
%macro excel_to_lib(filepath, libname, header = yes, mixed = yes);
  libname &libname. excel "&filepath."
    access = readonly
    header = &header.
    mixed  = &mixed.
    ;
%mend;




/* 使用例 */
/*  %excel_to_sas(&ABC., EXCEL_FILE,10000, COLUMN_A, DS_NAME); */
%macro excel_to_sas(filepath, libname, sheet, max_columns, key_item, out_ds, firstobs = 0, header = yes, mixed = yes);
  %excel_to_lib(&filepath., &libname., header = &header., mixed = &mixed.);
  data &out_ds.;
    set &libname.."&sheet.$"n(
            firstobs  = &firstobs.
            obs       = &max_columns.
            );
    %if "&key_item" = "" %then %do;
      where &key_item. <> "";
    %end;
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



*import version;
%macro excel_import(file_path
                    , sheet_name
                    , out_ds
                    , range      =
                    , mixed      = no
                    , getnames   = no
                    , replace    = replace
                    , scantext   = yes
                    , usedate    = no
                    , scantime   = yes
                    , dbsaslabel = none
                    , textsize   =
          );
  proc import
    out = &out_ds.
      datafile  = "&file_path."
      dbms = excel &replace.
    ;
    %if "&range." = "" %then %do;
      sheet = "&sheet_name.";
    %end;
    %else %do;
      range = "&range.";
    %end;

    mixed      = &mixed.;
    dbsaslabel = &dbsaslabel.;
    getnames   = &getnames.;
    usedate    = &usedate.;
    scantime   = &scantime.;
    dbsaslabel = &dbsaslabel.;

    %if "&textsize" = "" %then %do;
      scantext  = &scantext.;
    %end;
    %else %do;
      textsize  = &textsize.;
    %end;
  run;
%mend;
