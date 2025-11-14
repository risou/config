#!/bin/bash

# GitHub認証状態のチェック
if ! gh auth status &> /dev/null; then
    echo "GitHubへの認証が必要です。以下のコマンドを実行してください："
    echo "gh auth login"
    exit 1
fi

# 引数チェック
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 owner author start_date end_date"
    echo "Example: $0 risou @me 2024-01-01 2024-01-31"
    exit 1
fi

owner=$1
author=$2
start_date=$3
end_date=$4

echo "所有者: $owner"
echo "作成者: $author"
echo "期間: $start_date から $end_date"
echo "マージされたPR一覧:"
echo "----------------------------------------"

# マージされたPRの一覧を取得
pr_list=$(gh search prs --merged --merged-at "$start_date..$end_date" --owner "$owner" --author "$author" --limit 200 --json 'number,repository,title')

pr_count=$(echo "$pr_list" | jq '. | length')
echo "PR件数: $pr_count"
echo "----------------------------------------"

# 一時ファイルを作成
temp_file=$(mktemp)
echo 0 > "$temp_file"

if [ "$(echo "$pr_list" | jq '. | length')" -gt 0 ]; then
    echo "$pr_list" | jq -r '.[] | "\(.repository.nameWithOwner)\t\(.number)\t\(.title)"' | while read -r repo number title; do
        commits=$(gh pr view "$number" -R "$repo" --json commits | jq '.commits | length')
        echo "リポジトリ: $repo"
        echo "PR #$number: $title"
        echo "コミット数: $commits"
        echo "----------------------------------------"
        current_total=$(cat "$temp_file")
        echo $((current_total + commits)) > "$temp_file"
    done
else
    echo "期間内にマージされたPRはありません"
fi

total_all_commits=$(cat "$temp_file")
rm "$temp_file"

echo "全PRの合計コミット数: $total_all_commits" 