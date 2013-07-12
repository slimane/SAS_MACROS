/*  summary : 値の入ったtemporary配列を作成する
    args    :
        array_name  : temporary配列名称
        length      : 配列長
        vars        : 変数(スペース区切りで複数定義)
    usage   :
        %insert_temporary_to_vars(japanese, 2, word1 word2);
        -> temporary配列であるjapaneseにword1とword2が格納された状態になる
*/
%macro create_and_add_temporary_array(array_name, length, vars);
    %let _temporary_array_name = __temporary_&array_name.;


    array &array_name.              [&length.] _temporary_;
    array &_temporary_array_name.   [&length.] &vars;

    %let counter = insert_vars_to_temporary;
    do &counter. = 1 to dim(&_temporary_array_name.);
        &array_name.[&counter.] = &_temporary_array_name.[&counter.];
    end;
    drop &counter.;
%mend;
