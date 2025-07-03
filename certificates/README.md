# 証明書アップロード手順

## 手順
1. Apple Developer Portalで作成した`.cer`ファイルをこのフォルダにアップロード
2. 以下のコマンドでP12形式に変換:

```bash
cd /workspaces/np2-ios/certificates
./convert-to-p12.sh [証明書ファイル名.cer]
```

## 一時的な証明書アップロード方法

VS Codeのターミナルでbase64テキストとして貼り付ける方法：

```bash
# .cerファイルの内容をbase64形式で貼り付け
cat > distribution.cer.base64 << 'EOF'
[ここにbase64エンコードされた証明書内容を貼り付け]
EOF

# base64デコードして.cerファイルを作成
base64 -d distribution.cer.base64 > distribution.cer
```

## ファイルが正しくアップロードされたか確認
```bash
ls -la *.cer
file *.cer
```