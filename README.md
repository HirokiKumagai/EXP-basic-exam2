# EXP-basic-exam2

TECH::MASTER TECH::EXPERT 基礎カリキュラム 学習到達度試験2 (模試)

「Rubyアルゴリズム問題」 コード参照
「HTML/CSS問題」　コード参照
「Railsエラー問題」　以下回答
mooovi-exam1

(1)非ログイン状態で作品の個別ページから「この作品を投稿する」をクリックするとレビュー投稿画面へ遷移できてしまう。

before:     

```
before_action :authenticate_user!, except: :new
```
after:      

```
before_action :authenticate_user!
```
作業ファイル: app/controllers/reviews_controller.rb
解説:

(2)新規ユーザー登録を行い（ユーザー登録の際は必ずアバター画像を入れてください）ログインした後、
/products/search
で「hogehoge」と検索をしても検索を行うことが出来ない。
「hogehoge」と検索を行って、検索結果が表示されるように修正して下さい。

before:     

```
@products = Product.where('detail LIKE(?)', "%#{params[:keyword]}%")
```
after:      

```
@products = Product.where('title LIKE(?)', "%#{params[:keyword]}%")
```
作業ファイル: app/controllers/products_controller.rb
解説:

(3)レビューが投稿したが、レビューが反映されないので反映されるようにして下さい。

before:     

```
<%= f.text_area :rate, placeholder: 'レビューを書いてね！', style: 'width: 100%;height: 300px;' %>
```
after:      

```
<%= f.text_area :review, placeholder: 'レビューを書いてね！', style: 'width: 100%;height: 300px;' %>
```
作業ファイル: app/views/reviews/new.html.erb

before: 

```
def create_params
  params.require(:review).permit(:rate).merge(product_id: params[:product_id], user_id: current_user.id)
end
```
after:  

```
def create_params
  params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], user_id: current_user.id)
end
```

作業ファイル: app/controllers/reviews_controller.rb
解説:

(4)投稿ランキングが表示されていないので、renderメソッドを追加して表示出来るように修正して下さい。

before: 

```
<% @ranking.each_with_index(1) do | product,i | %>
```
after:    

```
<% @ranking.each_with_index(1) do | product,i | %>
<%= render partial: "ranking/ranking", locals: { product: product, i: i } %>
```
作業ファイル: app/views/layouts/review_site.html.erb
解説:

(5)link_toへの書き換え問題
app/views/layouts/review_site.html.erbにおいて

```
<a href="/users/<%= current_user.id %>">マイページ</a>
```
この部分をlink_toを使って書き換えを行って下さい。


after:     

```
<%= link_to  "マイページ", user_path(current_user) %>
```
作業ファイル: app/views/layouts/review_site.html.erb
解説:

(6)/users/1のユーザーのマイページに遷移した時に、NoMethodErrorが出て、画面を表示することが出来なくなっているので、画面を表示出来るように修正をして下さい。


after:      

```
has_many :reviews
```
作業ファイル: app/models/user.rb
解説:

(7)reviews_controller.rbのリファクタリング問題

```
def create
  Review.create(create_params)
  redirect_to controller: :products, action: :index
end

private
  def create_params
    params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], user_id: current_user.id) #(3)
  end
```
.mergeの中を.merge(product_id: params[:product_id])
とだけにした時に、レビューを登録出来るように修正を行って下さい。


after:  

```
def create
  current_user.reviews.create(create_params)
  redirect_to controller: :products, action: :index
end

private
def create_params
  params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id])
end
```
作業ファイル: reviews_controller.rb
解説: