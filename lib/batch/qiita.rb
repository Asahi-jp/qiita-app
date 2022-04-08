class Batch::Qiita
  def self.run
    puts 'バッチ処理実行中...'

    # 1ページごとの取得する投稿数
    per_page = "100"
      # 取得するデータの開始日時（04/01 9時以降）
    begin_date = "2022-03-31"

    user_array = []
    item_array = []
    item_tag_array = []

    # 1~100までのページでAPIを叩く（仕様として100ページ分しか取得できない為）
    for num in 1..100 do
      # ページ
      page = num.to_s 
      p page

      url = "https://qiita.com/api/v2/items?page=#{page}&per_page=#{per_page}&query=created%3A%3E#{begin_date}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme === "https"
      qiita_auth = ENV["QIITA_AUTH"]
      headers = { "Authorization" => qiita_auth }
      response = http.get(uri, headers)
      results = JSON.parse(response.body)

      # もしresultsに要素が無ければ処理を終わらせる
      unless results.any?
        break
      end

      for result in results do
        user = result["user"]
        item = result

        # ユーザー保存処理
        new_user = {
          "id" => user["id"],
          "name" => user["name"],
          "description" => user["description"],
          "profile_image_url" => user["profile_image_url"],
          "created_at" => Time.current,
          "updated_at" => Time.current
        }
        user_array << new_user

        # 投稿保存処理
        new_item = {
          "id" => item["id"],
          "title" => item["title"],
          "reactions_count" => item["reactions_count"],
          "likes_count" => item["likes_count"],
          "user_id" => user["id"],
          "created_at" => item["created_at"],
          "updated_at" => Time.current
        }
        item_array << new_item

        # タグ関連
        # 既存の投稿の場合、タグを全て外す
        if Item.exists?(id: item["id"])
          item_record = Item.where(id: item["id"])[0]
          item_record.item_tags.delete_all
        end
        # タグ付け処理
        item["tags"].each do |tag|
          # 新規のタグがあれば保存
          Tag.exists?(name: tag["name"]) ? tag_record = Tag.where(name: tag["name"])[0] : tag_record = Tag.create(name: tag["name"])
          # タグつけ直し
          new_item_tag = {
            "item_id" => item["id"],
            "tag_id" => tag_record.id,
            "created_at" => Time.current,
            "updated_at" => Time.current
          }
          item_tag_array << new_item_tag
        end

      end
    end
    # バルクインサート
    User.upsert_all(user_array)
    Item.upsert_all(item_array)
    ItemTag.upsert_all(item_tag_array)
  end
end