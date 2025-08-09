## 1. 立ち上げるための設定

### 1.1. コンテナ立ち上げ

```bash
# Chartリポジトリ追加・更新
helm repo add douban https://douban.github.io/charts/
helm repo update douban

# Dify をインストール（values.yaml は事前に編集）
helm upgrade dify douban/dify -f values.yaml --install --debug
```

### 1.2. DBマイグレーション
同じバージョンの再適用では不要ですが、初回起動やバージョンアップ時は必ず実行してください。
```
# dify-api または dify-worker の Pod 名を確認
kubectl -n dify get pods

# どちらかの Pod に入って実行
kubectl -n dify exec -it <dify-api-pod-name> -- flask db upgrade
```

### 1.3. Ingress の有効化
Minikube で Ingress を使う場合、事前に有効化します。
```
minikube addons enable ingress
```

### 1.4. トンネル開通
> 別ターミナルで常時起動しておくこと。終了するとアクセスできなくなります。

```bash
minikube tunnel 
```

### 1.5. ホスト名の設定
values.yaml の global.host に合わせて /etc/hosts に追記します。
```
echo "$(minikube ip) dify.localhost" | sudo tee -a /etc/hosts
```
または nip.io を使って hosts 設定不要にすることも可能です。
例：global.host: "192.168.49.2.nip.io"

### 1.6. アクセス
- http://dify.localhost/ を叩く¥
（nip.io を使う場合はそのURL）

初回は管理者ユーザー作成画面が表示されます。
事前に固定したい場合は values.yaml に以下を設定します。
```
global:
  extraBackendEnvs:
    - name: SUPERADMIN_EMAIL
      value: "admin@example.com"
    - name: SUPERADMIN_PASSWORD
      value: "change-me"
```