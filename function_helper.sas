/*  summary : スペース区切りの引数の個数を計算する
    args    :
        vars    : スペース区切りの複数の変数
    return  :
        変数の個数
    example :
        %count_vars(a    b c)           -> 3
        %count_vars(     a     )        -> 1
        %count_vars(a b     c d  e  )   -> 5
        %count_vars(                )   -> 0
    primary use case :
        別macro使用時に与えられた変数の個数を知りたい時
    note    :
        当該macorは単なる関数へのwrapperのため、使用時には関数使用時と同様に値が戻される
*/
proc fcmp outlib = work.functions.variable;
    function count_vars(txt $);
        return(lengthn(compress(prxchange('s/\S+/1/', -1, txt))));
    endsub;
run;

%macro count_vars(vars);
    count_vars("&vars.")
%mend;






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
    TODO    :
        lengthをvarsから自動敵に設定したい
            問題点  :
                1.事前に%count_varsなどで計算した値をmacro変数に格納しても文字列として扱われ、&length.のように扱えない。
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




