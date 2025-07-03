#!/bin/bash

# 使用方法: ./convert-to-p12.sh [証明書ファイル名.cer]

if [ $# -eq 0 ]; then
    echo "使用方法: $0 [証明書ファイル名.cer]"
    echo "例: $0 distribution.cer"
    exit 1
fi

CERT_FILE=$1
CERT_NAME=$(basename "$CERT_FILE" .cer)

echo "証明書を変換中: $CERT_FILE"

# .cerファイルをPEM形式に変換
openssl x509 -in "$CERT_FILE" -inform DER -out "${CERT_NAME}.pem" -outform PEM

# 秘密鍵と証明書をP12形式に結合
openssl pkcs12 -export -out "${CERT_NAME}.p12" -inkey private.key -in "${CERT_NAME}.pem" -passout pass:github123

echo "変換完了!"
echo "P12ファイル: ${CERT_NAME}.p12"
echo "パスワード: github123"

# Base64エンコード（GitHub Secrets用）
echo ""
echo "GitHub Secretsに設定するBase64値:"
echo "BUILD_CERTIFICATE_BASE64="
base64 -i "${CERT_NAME}.p12" | tr -d '\n'
echo ""
echo ""
echo "P12_PASSWORD=github123"