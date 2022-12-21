default: depends

clean:
	rm -rf vendor/*
	(cd ifunny && go mod edit -dropreplace github.com/zclconf/go-cty)
	(cd psyduck && go mod edit -dropreplace github.com/zclconf/go-cty)
	(cd scyther && go mod edit -dropreplace github.com/zclconf/go-cty)

depends:
	mkdir -p replace/
	git clone git@github.com:gastrodon/go-cty replace/go-cty || :
	(cd ifunny && go mod edit -replace github.com/zclconf/go-cty=../replace/go-cty)
	(cd psyduck && go mod edit -replace github.com/zclconf/go-cty=../replace/go-cty)
	(cd scyther && go mod edit -replace github.com/zclconf/go-cty=../replace/go-cty)