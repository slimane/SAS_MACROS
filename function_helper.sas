/*  summary : 値の入ったtemporary配列を作成する
    args    :
        temporarry_array_name   : temporary配列名称
        length                  : 配列長
        vars                    : 変数(スペース区切りで複数定義)
    example  :
        %insert_temporary_to_vars(japanese, 2, word1 word2);
        -> temporary配列であるjapaneseにword1とword2が格納された状態になる
    primary use case :
        可変長引数を求めるユーザー定義関数使用時にtemporary配列を作成する際に使用する
*/
%macro create_and_add_temporary_array(temporary_array_name, length, vars);
    %let _local_array_name = __local_&temporary_array_name.;


    array &temporary_array_name.    [&length.] _temporary_;
    array &_local_array_name.       [&length.] &vars;

    %let counter = insert_vars_to_temporary;
    do &counter. = 1 to dim(&_local_array_name.);
        &temporary_array_name.[&counter.] = &_local_array_name.[&counter.];
    end;

    drop &counter.;
%mend;
