echo "Checking commit messages..."
          COMMITS=$(git log origin/master..HEAD --pretty=format:"%H")
          for COMMIT in $COMMITS; do
            TITLE=$(git log -1 --pretty=format:"%s" $COMMIT)
            BODY=$(git log -1 --pretty=format:"%b" $COMMIT)
 
            TITLE_WORDS=$(echo $TITLE | wc -w)
            BODY_WORDS=$(echo $BODY | wc -w)
 
            echo "Commit: $COMMIT"
            echo "Title: $TITLE ($TITLE_WORDS words)"
            echo "Body: $BODY ($BODY_WORDS words)"
 
            if [ "$TITLE_WORDS" -le 3 ]; then
              echo "::error title=Commit title too short::Commit '$COMMIT' title has $TITLE_WORDS words. Must be more than 3."
              exit 1
            fi
 
            if [ "$BODY_WORDS" -le 10 ]; then
              echo "::error title=Commit message too short::Commit '$COMMIT' message body has $BODY_WORDS words. Must be more than 10."
              exit 1
            fi
          done