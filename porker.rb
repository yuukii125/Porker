# 開始のメッセージ
def first_message
  puts <<-TEXT
  ###########################
  #  簡易的なポーカーゲーム #
  #       CP VS あなた      #
  ###########################\n\n
  -------------ルール--------------
  ・手札が5枚配られます
  ・手札交換はありません
  ・勝負するか降りるか選択します
  ・降りた場合あなたの負けです
  ・役の強さは以下のとおりです
    1.ロイヤルフラッシュ
    2.ストレートフラッシュ
    3.4カード
    4.フルハウス
    5.フラッシュ
    6.ストレート
    7.3カード
    8.2ペア
    9.1ペア
  ----------------------------------\n\n
  TEXT
  
  sleep(0.5)
end

#手札を配布
def input_hand(name)
  # 1.1-13と♡♢♤♧の組み合わせでトランプ52枚
  cards = ["♥", "♠", "♦", "♣"].product(["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]).map(&:join)
  # 2.手札をランダムで5枚配る
  cards = cards.sample(5)  

  if name == "CP"
    puts "#{name}の手札は.....です\n\n"
  else
    puts "#{name}の手札は#{cards}です\n\n"
  end
  sleep(0.5)
end

#勝負するかの番号入力
def number_select
  print "勝負しますか？勝負するなら1を、降りるなら3を入力してください\n入力受付中=>"
  num_select = gets.chomp.to_i
  
  if num_select == 2 || num_select >= 4  #1.3以外を入力したらもう一度
    print "無効な値です。"
    return number_select
  end
end


# 3.勝負選択
def game_selection(cp_hand_array, you_hand_array)
  
  game_select = number_select

  if game_select == 3  # 4.降りたら負け
    puts "You lose...\n\n"
    
  elsif game_select == 1  # 5.勝負を選択
    puts "CPの手札は#{cp_hand_array}です"
    puts "あなたの手札は#{you_hand_array}です"
  end

end




# 6.役判定
# 7.勝敗表示




#出力開始
first_message

cp_hand = input_hand("CP")

you_hand = input_hand("あなた")

game_selection(cp_hand, you_hand)
