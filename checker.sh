#!/bin/bash
# 检查叮咚买菜是否有可配送时段,有则通过Bark推送

# (*)请填充BarkId
barkId="4hAHqhZkt7bymkY8Pis7EK"

while :; do

echo "正在检查是否有可用配送时段..."

# (*)请填充cURL命令,别忘记输出到tmp.json
# curl https://maicai.api.ddxq.mobi/order/getMultiReserveTime > tmp.json

responseCodeCheck=`cat tmp.json | jq -r '.code'`

if [[ $responseCodeCheck -ne 0 ]]; then
    cat tmp.json
    echo "😭 抱歉 请检查cURL命令是否能获取到正确的数据"
    exit 1
fi

availableCount=`cat tmp.json | jq -r '.data[0].time[0].times[].disableType' | grep -c 0`

if [[ $availableCount -gt 0 ]]; then
    echo "🎉 恭喜 发现可用的配送时段 请尽快下单!"
    curl "http://129.146.185.129:8080/$barkId/叮咚买菜有可用配送时段请尽快下单/"
    exit 0
fi

echo "无可用配送时段 休眠15秒再试..."
sleep 15

done
