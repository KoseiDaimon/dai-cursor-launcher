# DaiCursorLauncher - WSL Context Menu Tool

Windows エクスプローラーの右クリックメニューに「Cursorで開く（WSL）」を追加するツールです。

## 機能

- フォルダを右クリック → WSL上でそのフォルダをCursorで開く
- フォルダ内の空白部分を右クリック → 現在のフォルダをWSL上でCursorで開く

## インストール

1. [リリースページ](https://github.com/kose-daigoroh/dai-cursor-launcher/releases)からZIPファイルをダウンロード
2. ZIPファイルを解凍（例：ダウンロードフォルダに解凍）
3. `install.bat` をダブルクリック
4. 管理者権限を許可
5. 完了！

## 使い方

インストール後、エクスプローラーで：
- **フォルダを右クリック** → 「Cursorで開く（WSL）」を選択
- **フォルダ内の空白部分を右クリック** → 「Cursorで開く（WSL）」を選択

## アンインストール

1. `uninstall.bat` をダブルクリック
2. 管理者権限を許可
3. 完了！

## 必要な環境

- Windows 10/11
- WSL (Windows Subsystem for Linux) がインストール済み
- Cursor が標準の場所にインストール済み
  - `C:\Users\<ユーザー名>\AppData\Local\Programs\Cursor\Cursor.exe`

## トラブルシューティング

### Cursor.exe が見つからない場合
Cursorを標準の場所にインストールしてください。

### 右クリックメニューが表示されない場合
エクスプローラーを再起動してください（タスクマネージャーでexplorer.exeを再起動）。

## ファイル構成

- `install.bat` - インストーラー
- `uninstall.bat` - アンインストーラー
- `README.md` - このファイル