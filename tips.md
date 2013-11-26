## fcmpプロシージャーにおける真偽判定
	return(conditional expression);
		result
			1 : true
			0 : false



## %if条件で文字列判定を行う
	%if "&variable" = "Strings"
		マクロ変数をクオーテーショで囲むことにより判定できる

## null判定
	missing()

## Datasetの存在判定
	exists()

## escapeシーケンス
	%str()
		example : %let example = %str(data test; set test; run);

## macroのdebug
	%put
		usage
			%put texxt
		options
				_ALL_       -> すべてのマクロ変数の内容を表示
				_AUTOMATIC_ -> 自動マクロ変数の内容を表示
				_GLOBAL_    -> GLOBALマクロ変数の内容を表示
				_LCOAL_     -> localマクロ変数の内容を表示
				_USER       -> user defなマクロ変数の内容を表示
	MPRINT
		usag
			OPTIONS MPRINT SYMBOLGEN;
	SYMBOLGEN
		usage
			OPTIONS MPRINT SYMBOLGEN;
	MLOGIC

## 正規表現での値の整合性チェック
		prxmatch("m/pat/", 比較対象);
			usage
				pxmatch("m/(^|\s)" || variable || "(\s|$)/");

## Debug
		put
			usage
				'variables ' variable1= variable2= variable3;

## データのフィルタリング
	where statement




## 外部ファイルのimport

	+ libname

	+ infile <file_path> <options>;
		inputで変数名などを指定
		informat で読み込みデータのフォーマットを指定


## retainステートメント
	変数値の初期を行わないで次のステートメントに引き継ぐ


## format/informatステートメント
	format   : データ出力時のフォーマット指定
	informat : データ取り込み時のフォーマットを指定


## returnステートメント
	currentオブザベーションの処理を中止し、次のオブザベーションの処理に移動する(currentオブザベーションは破棄されない)



# warningの抑制

1. WARNING: セルの 50% (表 : XXX) において、期待度数が 5 より小さくなっています。カイ 2 乗検定は妥当な検定でないと思われます。
	SAS 9.2 TS2M3 (SAS/STAT 9.22)以降では、TABLESステートメントにて、CHISQ(WARN=NONE)と記述


## dataステップ内sort

	data example;
		set pre_example;

		proc sort; by {key};
	run;
