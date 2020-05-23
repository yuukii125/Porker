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
    2.4カード
    3.フルハウス
    4.フラッシュ
    5.3カード
    6.2ペア
    7.1ペア

    同じ役だった場合は引き分けです

    A=>1, X=>10, J=>11, Q=> 12, K=>13
  ----------------------------------\n\n
  TEXT
  
  sleep(0.5)
end

#手札を配布
def input_hand
  # トランプ52枚
  cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "X", "J", "Q", "K"].product(["♥", "♠", "♦", "♣"]).map(&:join)

  cards = cards.sample(10)   # 手札をランダムで5枚配る 
  cp_cards = cards.first(5)
  you_cards = cards.last(5)

  cp_hand = cp_cards.sort_by{|a| a.to_i }  #手札を昇順に
  you_hand = you_cards.sort_by{|a| a.to_i }

  return cp_hand, you_hand
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

  num_select
end

# 6.役判定 役に番号つけて番号で勝敗きめる
def vs_judgement(hand_array)
  suits = []
  numbers = []

  hand_array.each do |c|  #番号とマークを分ける
    numbers.push c[0]
    suits.push c[1]
  end

    #ロイヤルフラッシュ 1
  if  suits.group_by(&:itself).transform_values(&:size).count == 1 && numbers.include?("A", "X", "J", "Q", "K") 
    judge_num = 1

  elsif numbers.group_by(&:itself).transform_values(&:size).value?(4)  #4カード  2
    judge_num = 2

  elsif numbers.group_by(&:itself).transform_values(&:size).value?(3) && numbers.group_by(&:itself).transform_values(&:size).value?(2)    #フルハウス 4
    judge_num = 3

  elsif suits.group_by(&:itself).transform_values(&:size).count == 1  #フラッシュ 4
    judge_num = 4

  elsif numbers.group_by(&:itself).transform_values(&:size).value?(3)   #3カード 5
    judge_num = 5

  elsif numbers.group_by(&:itself).transform_values(&:size).count == 3 && numbers.group_by(&:itself).transform_values(&:size).value?(2)  #2ペア 6
    judge_num = 6

  elsif numbers.group_by(&:itself).transform_values(&:size).count == 4  #1ペア 7
    judge_num = 7

  else  #何も揃っていない
    judge_num = 8
  end

  judge_num
end
  
  
# 3.勝負選択
def game_selection(name, cp_hand_array, you_hand_array, cp_judge_num, you_judge_num)
  
  puts "#{name}の手札は#{you_hand_array}です\n\n"
  
  game_select = number_select
  
  if game_select == 3  # 4.降りたら負け
    puts "CPの手札は#{cp_hand_array}でした"
    judgement = "You lose..."
    puts "結果は..."
  elsif game_select == 1  # 5.勝負を選択
    puts "CPの手札は#{cp_hand_array}です"
    puts "あなたの手札は#{you_hand_array}です"

    if cp_judge_num < you_judge_num   #CPの役番号が強い
      judgement = "You lose..."

    elsif cp_judge_num == you_judge_num    #CPの役番号と同じ
      judgement = "draw"

    else                               #CPの役番号が弱い
      judgement = "You Win!!"

    end
    puts "結果は..."
    sleep(1)
  end
  
  puts "\n#{judgement}\n\n"  # 7.勝敗表示

end
  
  def replay

  print "もう一度対戦しますか？対戦するなら1を止めるなら3を入力してください\n入力受付中=>"
  replay_num = gets.chomp.to_i
    
  unless replay_num == 1 || replay_num == 3
    puts "無効な値です"
    return replay
  end
  replay_num
end



#出力開始
first_message  #start
while true
  cp_hands, you_hands = input_hand  #手札配布
  
  cp_judge = vs_judgement(cp_hands)
  you_judge = vs_judgement(you_hands)
    
  game_selection("あなた", cp_hands, you_hands,cp_judge, you_judge)  #ゲーム開始

  if replay == 3
    puts "----------ゲーム終了-------------\n\n"
    break
  end

end
