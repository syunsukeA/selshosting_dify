NS=dify

# マイグレーション実行（flaskはフルパスで）
kubectl -n $NS exec deploy/dify-api -- /app/api/.venv/bin/flask db --help
kubectl -n $NS exec deploy/dify-api -- /app/api/.venv/bin/flask db check
kubectl -n $NS exec deploy/dify-api -- /app/api/.venv/bin/flask db upgrade