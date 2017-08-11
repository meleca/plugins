#!/bin/bash

echo "mode: set" > $COVERAGE_DIR/coverage.out
for Dir in $(find ./* -maxdepth 10 -type d );
do
    if ls $Dir/*.go &> /dev/null;
    then
        returnval=`go test -cover -race -coverprofile=$COVERAGE_DIR/coverage.part $Dir`
        echo ${returnval}
        if [[ ${returnval} != *FAIL* ]]
        then
            if [ -f $COVERAGE_DIR/coverage.part ]
            then
                cat $COVERAGE_DIR/coverage.part | grep -v "mode: atomic" >> $COVERAGE_DIR/coverage.out
            fi
        else
            exit 1
        fi
    fi
done
