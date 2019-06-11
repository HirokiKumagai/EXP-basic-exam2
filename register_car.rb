def register_data(cars)
  # 車を登録するための関数を完成させなさい
  # 時間当たりの走行距離については、少数を扱うことが出来るようにto_fを扱い、乗車人数に関しては、to_iを使用すること
  puts "車種の入力をして下さい"
  type = gets.chomp
  puts "時間当たりの走行距離(km/h)を入力して下さい"
  fuel_economy = gets.to_f
  puts "乗車可能人数を入力して下さい"
  capacity = gets.to_i

  car = { type: type, fuel_economy: fuel_economy, capacity: capacity }
  cars << car
end

def show_cars(cars)
  # 保存した車種の一覧を表示するための関数を完成させなさい
  cars.each_with_index do |car, index|
    puts "[#{index}]: #{car[:type]}"
  end
  # 確認したい番号を入力した後に、show_dataの関数を呼び出すようにしなさい
  puts "確認したい番号を入力して下さい。"
  input = gets.to_i
  car = cars[input]
  if car
    show_data(car)
  else
    puts "該当する番号はありません。"
  end
end

def show_data(car)
  # 一覧から選択された車の全ての情報を表示する関数を完成させなさい
  puts car[:type]
  puts "1時間あたりの走行可能距離:#{car[:fuel_economy]}km/h"
  puts "乗車人数:#{car[:capacity]}人"

  puts "これから走る距離(km)を入力して下さい。"
  input_distance = gets.to_f

  puts "これから乗る人数を入力して下さい。"
  input_capacity = gets.to_i

  # 目的地までの時間を計算する関数と乗車人数を計算する関数を呼び出して下さい
  car_distance(car, input_distance)
  car_capacity(car, input_capacity)
end


def car_distance(car, distance)
  # 目的地までの時間を計算する関数を完成させなさい
  elapsed_time = distance / car[:fuel_economy]
  puts "その目的地までは、#{elapsed_time.round(1)}時間かかります。"
end

def car_capacity(car, capacity)
  # 車に乗ることが出来る人数について、後何人乗ることが出来るのか、丁度乗ることが出来る人数なのか、もしくは何人定員オーバーなのかを出力する関数を完成させなさい
  capacity = car[:capacity] - capacity
  if capacity == 0
    puts "車の定員丁度です。"
  elsif capacity > 0
    puts "後、車には#{capacity}人乗ることができます。"
  else
    puts "#{capacity.abs}人定員オーバーです。"
  end
end

cars = []

while true do
  puts "番号を入力して下さい"
  puts "[0]:登録をする"
  puts "[1]:データを確認する"
  puts "[2]:終了する"

  input = gets.chomp
  case input
  when "0"
    # 車種を登録するための関数を呼び出しなさい。
    register_data(cars)
  when "1"
    # 保存したデータを一覧で表示するための関数を呼び出しなさい。
    show_cars(cars)
  when "2"
    # アプリケーションを終了させなさい。
    exit
  else
    puts "無効な値です"
  end
end