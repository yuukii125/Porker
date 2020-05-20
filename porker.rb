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
def input_hand
  # トランプ52枚
  cards = ["♥", "♠", "♦", "♣"].product(["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]).map(&:join)

  cards = cards.sample(10)   # 手札をランダムで5枚配る 
  cp_cards = cards.first(5)
  you_cards = cards.last(5)

  return cp_cards, you_cards
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

  return num_select
end

# 6.役判定 役に番号つけて番号で勝敗きめる
# def vs_judgement("name")
  # if    #ロイヤルフラッシュ 1
    
  # elsif   #ストレートフラッシュ 2
  # elsif   #4カード  3
  # elsif   #フルハウス 4
  # elsif   # 5
  # elsif   #6
  # elsif   #7
  # elsif   #8
  # else   #9
    
  # end
  
  # if    #CPの役番号が強い
  #   judgement = "You lose..."
    
  # elsif     #CPの役番号が弱い
  #   judgement = "You Win!!"
    
  # else     #CPの役番号と同じ
  #   judgement = "draw"
    
  # end
    # return vs_judge
# end


# 3.勝負選択
def game_selection(name, cp_hand_array, you_hand_array)
  
  puts "#{name}の手札は#{you_hand_array}です\n\n"

  game_select = number_select
  
  if game_select == 3  # 4.降りたら負け
    puts "CPの手札は#{cp_hand_array}でした"
    judgement = "You lose..."
  elsif game_select == 1  # 5.勝負を選択
    puts "CPの手札は#{cp_hand_array}です"
    puts "あなたの手札は#{you_hand_array}です"
    judgement = vs_judge
  end
  
  puts "#{judgement}\n\n"  # 7.勝敗表示
end


#出力開始
first_message  #start
cp_hand, you_hand = input_hand  #手札配布

game_selection("あなた", cp_hand, you_hand)  #ゲーム開始
