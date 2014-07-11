%macro is_date_char(date_chr);
  (prxmatch('m/^\s*\d{4}(\/|-)\d{1,2}\1\d{1,2}\s*$/i', &date_chr.)
    or prxmatch('m/^\s*\d{8}\s*$/i', &date_chr.))
%mend;

