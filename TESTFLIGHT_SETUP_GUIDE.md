# np2-ios TestFlight配信 引き継ぎドキュメント

## プロジェクト概要
- **プロジェクト**: np2-ios (PC-98エミュレーター)
- **リポジトリ**: https://github.com/msonrm/np2-ios
- **目標**: ipaファイルを作成してTestFlightで配信

## 現在の状況

### 完了済み
✅ GitHub Actionsワークフローでアーカイブ作成  
✅ 証明書問題を回避するため署名なしビルドに変更  
✅ Bundle ID設定: `com.msonrm.np2sdl2`  
✅ Team ID設定: `56M5TL55LH`  
✅ Apple Developer Portalでの基本設定完了  

### 現在のワークフロー
- **ファイル**: `.github/workflows/simple-testflight.yml`
- **機能**: 署名なしでアーカイブファイル(`.xcarchive`)を作成
- **成果物**: GitHub ActionsのArtifactsからダウンロード可能

## 設定済みのGitHub Secrets

| Secret名 | 説明 | 値 |
|---------|------|-----|
| `APPLE_TEAM_ID` | Apple Developer Team ID | `56M5TL55LH` |
| `APP_STORE_CONNECT_API_KEY_ID` | App Store Connect APIキーID | 設定済み |
| `APP_STORE_CONNECT_ISSUER_ID` | App Store Connect Issuer ID | 設定済み |
| `APP_STORE_CONNECT_PRIVATE_KEY` | App Store Connect秘密キー(.p8) | 設定済み |

## TestFlight配信方法

### 方法1: 手動アップロード（現在の方法）
1. **GitHub Actions**で「Build IPA for TestFlight」を実行
2. **Artifacts**からアーカイブファイルをダウンロード
3. **Xcode Organizer**でアーカイブをインポート
4. **Distribute App** → **App Store Connect**でアップロード

### 方法2: XcodeCloud（推奨）
1. Xcodeで**Product** → **Xcode Cloud** → **Create Workflow**
2. **TestFlight Internal Testing**を有効化
3. プッシュ時に自動ビルド・アップロード

## 証明書関連ファイル
- **場所**: `/certificates/`フォルダ
- **Distribution証明書**: `ios_distribution.p12` (パスワード: `github123`)
- **Development証明書**: `ios_development.p12` (パスワード: `github123`)
- **秘密鍵**: `private.key`

## 残タスク

### 高優先度
1. **XcodeCloud設定** - 最も確実な方法
2. **TestFlight自動配信の実現**
3. **証明書問題の完全解決**

### 中優先度
1. **GitHub Actionsでの自動署名実現**
2. **Distribution証明書の正しい設定**
3. **CI/CDパイプラインの最適化**

## トラブルシューティング

### 証明書エラーの場合
- **症状**: `MAC verification failed during PKCS12 import`
- **原因**: 証明書とプライベートキーの不一致
- **解決**: XcodeCloudの使用を推奨

### ビルドエラーの場合
- **Bundle ID**: `com.msonrm.np2sdl2`が正しく設定されているか確認
- **Team ID**: `56M5TL55LH`が正しく設定されているか確認
- **Xcode設定**: Code Signing設定を確認

## 連絡先・参考資料
- **Apple Developer Portal**: https://developer.apple.com/account/
- **App Store Connect**: https://appstoreconnect.apple.com/
- **GitHub Actions履歴**: リポジトリのActionsタブで確認可能

## 次回作業時の推奨手順
1. **XcodeCloud**を最優先で設定
2. 証明書問題が解決しない場合は手動アップロードを継続
3. 長期的にはGitHub Actionsでの完全自動化を目指す

---
**作成日**: 2025年7月4日  
**最終更新**: GitHub Actions設定完了、XcodeCloud設定待ち