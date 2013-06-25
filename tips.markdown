## null判定
	-> MISSING()

## Datasetの存在判定
	-> EXISTS()

## escapeシーケンス
	-> %str()
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
		-> prxmatch("/pat/", 比較対象);
			usage
				pxmatch("/(^|\s)" || variable || "(\s|$)/");
