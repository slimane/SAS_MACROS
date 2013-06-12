/* missing data */
/* like to NVL_FUNCTION(Character ver.) */
%macro NVL_C(data1, data2);
	ifc(not missing(&data1.)
		, &data1.
		, &data2.)
%mend;

/* like to NVL_FUNCTION(Numeric ver.) */
%macro NVL_N(data1, data2);
	ifn(not missing(&data1.)
		, &data1.
		, &data2.)
%mend;








%macro getGreater_N(val1, val2);
	ifn(&val1. > &val2.
		, &val1.
		, &val2.
	)
%mend;

%macro getLesser_N(val1, val2);
	ifn(&val1. < &val2.
		, &val1.
		, &val2.
	)
%mend;



%macro likeDictionary(ds, key, val);
	%createDictionary(&ds.);

	proc sql;
		INSERT INTO &ds.
			SET key_val = "&key."
				, val	= "&val."
		;
	quit;
%mend;




%macro createDictionary(ds);
	%if not %sysfunc(exist(&ds.)) %then %do;
		proc sql;
			CREATE TABLE &ds.
			(
				key_val	VARCHAR(255)
				, val	VARCHAR(5000)
				, constraint prim_key    primary key(key_val)
			)
			;
		quit;
	%end;
%mend;

