.PHONY: lint

testcoverage := $(shell go tool cover -func=coverage.out | grep total | grep -Eo '[0-9]+\.[0-9]+')
threshold = 50

test:
    @go test -coverprofile=coverage.out -covermode=count  ./...

check-coverage:
    @echo "Test coverage: $(testcoverage)"
    @echo "Test Threshold: $(threshold)"
    @echo "-----------------------"

    @if [ "$(shell echo "$(testcoverage) < $(threshold)" | bc -l)" -eq 1 ]; then \
        echo "Please add more unit tests or adjust the threshold to a lower value."; \
        echo "Failed"; \
        exit 1; \
    else \
        echo "OK"; \
    fi

lint:
	go test ./... -coverprofile coverage.out
	COVERAGE=`go tool cover -func=coverage.out | grep total: | grep -Eo '[0-9]+\.[0-9]+'`
	echo $COVERAGE