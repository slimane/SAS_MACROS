%macro getGreater(var1, var2)
	CASE WHEN &var1. > &var2.
		THEN &var1.
		ELSE &var2.
	END
%mend;

%macro getLesser(val1, val2)
	CASE WHEN &val.½< &var2.
		THEN &var1.
		ELSE &var2.
	END
%mend;
