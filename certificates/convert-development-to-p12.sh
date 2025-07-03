#!/bin/bash

# Development証明書をP12形式に変換

if [ $# -eq 0 ]; then
    echo "使用方法: $0 [Development証明書ファイル名.cer]"
    echo "例: $0 ios_development.cer"
    exit 1
fi

CERT_FILE=$1
CERT_NAME=$(basename "$CERT_FILE" .cer)

echo "Development証明書を変換中: $CERT_FILE"

# .cerファイルをPEM形式に変換
openssl x509 -in "$CERT_FILE" -inform DER -out "${CERT_NAME}.pem" -outform PEM

# 秘密鍵と証明書をP12形式に結合（Development用の秘密鍵を使用）
openssl pkcs12 -export -out "${CERT_NAME}.p12" -inkey development_private.key -in "${CERT_NAME}.pem" -passout pass:github123

echo "変換完了!"
echo "P12ファイル: ${CERT_NAME}.p12"
echo "パスワード: github123"

# Base64エンコード（GitHub Secrets用）
echo ""
echo "GitHub Secretsに設定するBase64値:"
echo "DEVELOPMENT_CERTIFICATE_BASE64="
base64 -i "${CERT_NAME}.p12" | tr -d '\n'
echo ""
echo ""
echo "DEVELOPMENT_P12_PASSWORD=github123"