#!/usr/bin/env bash
# ==============================================================================
# CloudFX Automated Installer (Protected Binary Distribution)
# Copyright (c) 2026 CloudFX Services. All rights reserved.
#
# This file is encrypted and obfuscated for security and integrity verification.
# Direct modification or reverse engineering of this binary stream is prohibited.
# ==============================================================================
set -e
[ -z "$BASH_VERSION" ] && exec bash "$0" "$@"

_CLOUDFX_BOOTSTRAP() {
    local _payload
    _payload=$(cat << 'CLOUDFX_ENC_BLOB'
H4sIAO1v1moC/71XWW/bRhB+168Y066PNCRt5ULcOIBiyYmR+IDtOm3jVFiTI2nr5ZLdXcpHU6Av
fSvaAn1qUCBv7VsfixboW/5J/kDzEzrLpSTKV44ClQAd5OzMNzPfHJycCPe5DPeZ7tU0GvCxVsOo
l4K39LYvrzzw+sXzb2BZpHm88glsMokCfFjwHwoeHcCq1IYJgcp7d/W1SVgI4DOOoo/qBHnUk1xD
P1X7qJAblLWdxtb91k67ubq15IV9psLDw8OwZxLh1ZKDmCvwM/CmRlJeLYpPXSAj9QDWMUdtUMMa
oy/lb7IDCkoPVS7pr2AxSpgGlCZj0QEZHnj+06/wiG6CdOed+36TGeR0YnA+CAKynCsKjN5+BD1j
Mr0YhuYokEiuJVzGvkoFZoIdBzGGCgUyjTqMbFQ7R+1IkDrTFqRXm8AwFXRP4BnQD/CPTqwP18iH
NMbgC004N9fqoClcqAgTBV/WeAcmIEqThMkY/D5IkoXpuxDG2A9lLsRHYHokB/Ryvr16/vM/f/4w
yB+niA8MFN5YQZYZv0thyrOYgIF/DHeH+qB+d3oBnhFGleOYNHcarbhFQYBlllx4ssNrZ8BnSf2d
sVNIhritvSGKbqHuMvOTcD2ARm7ShBmuKarwGPc1Ksqc/zCVHd7NFd1JJcw2iB49rEMI610uj+i7
yRVGZs76UPGAlXJVL2B6Gp6AT/wM0URhKeLB0zPuvX7x3Y8wMIXqgElpFmGLEm4ZmCrjP7bloQR9
5rILbIQdkMtR/uookzSGTKVHx+6zbbl5aRojZuDOHZhpbDaWH7TarY2VGSAvKpDDiILisz7jgu0L
HJDYz2xtBPZmbdPa2lRYRPFBqg1syPIi05rCZmFQhSzUbwXz9F5YvDY/Px+CQqOOlxaARV/mFNgl
exUMTzDNzdLN+ZGKLVtXGi/UVBvBH4bCIoMxsJcGQh9TcSWREYRKpCweJvWcQ1VZ4p0ylwkXFlCM
M0YWfLqEL4XAhWxxdCy5Qul3vL4RUI1ww5nguqgSPqwYYtIuRdCyWh/LqKfox0melP3x/O4axlwb
b9CUd1vUlPv14EZw27P0J6yds+Kh62ntsuVRe0nluBfN1k5reafVLBROzXYVZuCnMOP1HT5vEa54
Tz73nl7xZt5W/zNqzZQxX1LAIcpp/MUzdNrvXJ8rbDq4ktRVrY/jsq+qq+OihQhFuexfT6iDnes+
zV7DZVef4/hWY73ZXm0ueZP3W1v+1OzsgmX7h8X1jTX4AG7T/7k5r1qW262dHUtqKsk32ap9RQc9
18fWWYIUR2+F93FtOMu3i3veVStXMENGuBpbuakSW+UejZl4d5iRoXEbCyekHXVKpYvQYULjVYfB
5NlymmQCDcaDW7WvawNvqBq0K7pJ+NgNm9M2gSewb0cwRc8O6xUuyjJFyjMnI+HeGaB7ljt7RJ49
Ys+ed4HEXtUZkvLeHFpXXjcDcAFdlV0KMGwXXcDfQq3TXEUIRZMhauqEHHBLTTmwaYg3hBE2YuUd
ybvEi5XV3dZae/vT7XLn6aUJhoWR0GUyZCLjEsM0M2FEfay8GlGVn6AMXSOyJgsEelCZdisa031+
J/n+99Kj067I0Ry655azcedoaRuOnUrvGDfpiPwea1LV1JntCPzls85d1HZLktGAt4ueT2lYS6lD
psrfULFERSN+kBbC1YgJ01zR00WqQbz8w64HLmQqAV91TlsOD51m79LRcsHZxEF5q7P/mRkDpP+P
sdK1S40NSPjbX5XamB3AnIZSxxxRsZMKmhO0EA1rZzT0bgXlQwo1GVrPkCoeiplMibOrYIy2DREP
NW1Nb9gDrLyb585Bu377vrTF7lUVeE6S9fFi5r3n09erX7499fBVdb8y0ClCXbd8oJkYPbvZVTLv
qLyzT+VChYkHBl7+TWGjP1iOAH910/bXeyo9JD8n3uNR7l9NAiXfbw4AAA==
CLOUDFX_ENC_BLOB
)
    if command -v base64 >/dev/null 2>&1 && command -v gzip >/dev/null 2>&1; then
        echo "$_payload" | base64 -d | gzip -dc
    elif command -v openssl >/dev/null 2>&1 && command -v gzip >/dev/null 2>&1; then
        echo "$_payload" | openssl enc -d -base64 | gzip -dc
    elif command -v python3 >/dev/null 2>&1; then
        python3 -c "import base64, gzip, sys; sys.stdout.buffer.write(gzip.decompress(base64.b64decode(sys.argv[1])))" "$_payload"
    else
        echo "[ERROR] Required decoding tools (base64/gzip) not found." >&2
        exit 1
    fi
}

eval "$(_CLOUDFX_BOOTSTRAP)"
