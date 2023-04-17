#!/bin/bash

TARGET=./data/incoming/
PROCESSED=./data/processing/

inotifywait -m -e create -e moved_to --format "%f" $TARGET \
        | while read FILENAME
                do
                        echo Detected $FILENAME, moving and updating database
						./trademaker "$TARGET" "$FILENAME" | psql -h 0.0.0.0 -p 5432 -U postgres -d traders
						echo Processed files $TARGET/$FILENAME into database
                        rm -rf "$TARGET/$FILENAME"
                done
