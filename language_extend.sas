%macro range_select(var, args);
    %sysfunc(prxchange(s!
                            when\s*([0-9\.\-\+\*/]+)\.\.([0-9\.\-\+\*/]+) then(.*?);!
                            if \1 < &var. and \2 >= &var. then;\3;!
                            i
                        , -1
                        , &args.));
    %skip;
%mend;
/*usage*/
data x;
    input days 8.;
    cards;
1
14
21
28
35
42
49
56
63
72
;
run;
data x;
    set x;
    %range_select(days, %str(
                                  when 0..1*7 then  week_1 = 1;
                                  when 1*7..2*7 then  week_2 = 1;
                                  when 2*7..3*7 then  week_3 = 1;
                                  when 3*7..4*7 then  week_4 = 1;
                                  when 4*7..5*7 then  week_5 = 1;
                                  when 5*7..6*7 then  week_6 = 1;
                                  when 6*7..7*7 then  week_7 = 1;
                                  when 7*7..8*7 then  week_8 = 1;
                                ));
run;
