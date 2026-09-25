#!/bin/bash
# 取得対象の期間
start_date="2025-01-01"
end_date="2025-02-06"

current_date="$start_date"
: "${GITHUB_ORG:?Set GITHUB_ORG}"

# GitHub認証状態のチェック
if ! gh auth status &> /dev/null; then
    echo "GitHubへの認証が必要です。以下のコマンドを実行してください："
    echo "gh auth login"
    exit 1
fi

# 1週間ごとに期間を区切ってループ
while [[ "$current_date" < "$end_date" ]]; do
  # BSD date を利用して1週間後の日付を計算（macOS向け）
  weekend_date=$(date -v+6d -j -f "%Y-%m-%d" "$current_date" +"%Y-%m-%d")
  next_date=$(date -v+7d -j -f "%Y-%m-%d" "$current_date" +"%Y-%m-%d")
  # 次の週の日付が終了日を超える場合は、end_date を設定
  if [[ "$next_date" > "$end_date" ]]; then
    next_date="$end_date"
  fi

  echo "Querying PRs merged from $current_date to $weekend_date ..."
  gh api --paginate "/search/issues?q=is:pr+is:merged+merged:${current_date}..${weekend_date}+org:${GITHUB_ORG}&per_page=100" \
    --jq '.items' \
    > "results_${current_date}_to_${weekend_date}.json"

  current_date="$next_date"

  sleep 20
done

jq -s 'map(.[]) 
       | group_by(.user.login) 
       | map({user: .[0].user.login, count: length}) 
       | sort_by(.count) | reverse' results_*.json -c

