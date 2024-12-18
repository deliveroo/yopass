#!/bin/sh

sleep 5

TEST_SECRET="This is a test Yopass secret"
YOPASS_URL="http://yopass"

# Generate the secret
SECRET_URL=$(printf "$TEST_SECRET" | ./yopass --url $YOPASS_URL)

# Retrieve the secret from Yopass
SECRET_RETRIEVED=$(./yopass --decrypt ${SECRET_URL} --url $YOPASS_URL)

if [ "$SECRET_RETRIEVED" == "$TEST_SECRET" ]; then
        echo "PASS"                       
else               
        echo "FAIL"
fi  
