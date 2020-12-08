curl --unix-socket /tmp/firecracker.socket -i \
    -X PUT "http://localhost/actions" \
    -H  "accept: application/json" \
    -H  "Content-Type: application/json" \
    -d "{
             \"action_type\": \"SendCtrlAltDel\"
    }"