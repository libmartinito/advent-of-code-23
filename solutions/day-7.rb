part = ARGV[0]
filepath = "input/day-7.txt"
# filepath = "test/day-7-part-1.txt"
# filepath = "test/day-7-part-2.txt"
file = File.open(filepath, "r")
@lines = file.read.split("\n")

def get_card_char_map(card)
  char_map = {}

  card.chars.each do |card_char|
    if char_map[card_char].nil?
      char_map[card_char] = 1
    else
      char_map[card_char] += 1
    end
  end

  char_map.sort_by { |_, value| -value }.to_h
end

def get_card_with_joker_char_map(card)
  char_map = get_card_char_map(card)
  return char_map if char_map["J"].nil?
  return char_map if char_map.size == 1

  if char_map.keys[0] == "J"
    char_map[char_map.keys[1]] += char_map["J"]
  else
    char_map[char_map.keys[0]] += char_map["J"]
  end

  char_map.delete("J")
  char_map.sort_by { |_, value| -value }.to_h
end

def get_card_type(char_map, card)
  if char_map.size == 1
    "five-of-a-kind"
  elsif char_map.values[0] == 4
    "four-of-a-kind"
  elsif char_map.size == 2
    "full-house"
  elsif char_map.size == 3 && char_map.values[0] == 3
    "three-of-a-kind"
  elsif char_map.size == 3 && char_map.values[0] == 2 && char_map.values[1] == 2
    "two-pair"
  elsif char_map.size == 4 && char_map.values[0] == 2
    "one-pair"
  else
    "high-card"
  end
end

def get_card_types_with_cards(part)
  card_types_with_cards = {}

  @lines.each do |line|
    card, bid = line.split(" ")
    char_map = if part == "one"
      get_card_char_map(card)
    else
      get_card_with_joker_char_map(card)
    end

    card_type = get_card_type(char_map, card)

    if card_types_with_cards[card_type].nil?
      card_types_with_cards[card_type] = [{card:, card_type:, bid:}]
    else
      card_types_with_cards[card_type].push({card:, card_type:, bid:})
    end
  end

  card_types_with_cards
end

def is_first_card_stronger?(first_card, second_card, part)
  card_labels = if part == "one"
    ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
  else
    ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
  end

  stronger_card = ""

  5.times do |i|
    if first_card[i] != second_card[i]
      stronger_card = if card_labels.index(first_card[i]) < card_labels.index(second_card[i])
        first_card
      else
        second_card
      end

      break
    end
  end

  stronger_card == first_card
end

def sort_cards_with_rank(card_types_with_cards, part)
  card_types = ["five-of-a-kind", "four-of-a-kind", "full-house", "three-of-a-kind", "two-pair", "one-pair", "high-card"]
  rank = @lines.size
  sorted_cards = []

  card_types.each do |card_type|
    next if card_types_with_cards[card_type].nil?

    if card_types_with_cards[card_type].size == 1
      card_info = card_types_with_cards[card_type].first
      card_info[:rank] = rank
      sorted_cards << card_info
      rank -= 1
    else
      tied_cards = card_types_with_cards[card_type]

      sorted_tied_cards = tied_cards.sort do |first, second|
        if is_first_card_stronger?(first[:card], second[:card], part)
          -1
        elsif is_first_card_stronger?(second[:card], first[:card], part)
          1
        else
          0
        end
      end

      sorted_tied_cards.each do |card_info|
        card_info[:rank] = rank
        sorted_cards << card_info
        rank -= 1
      end
    end
  end

  sorted_cards
end

def solve_part_one
  card_types_with_cards = get_card_types_with_cards("one")
  sorted_cards = sort_cards_with_rank(card_types_with_cards, "one")
  winnings = sorted_cards.map { |card| card[:bid].to_i * card[:rank] }
  puts "Winnings: #{winnings.sum}"
end

def solve_part_two
  card_types_with_cards = get_card_types_with_cards("two")
  sorted_cards = sort_cards_with_rank(card_types_with_cards, "two")
  winnings = sorted_cards.map { |card| card[:bid].to_i * card[:rank] }
  puts "Winnings: #{winnings.sum}"
end

case part
when "1"
  solve_part_one
when "2"
  solve_part_two
else
  raise "Invalid part!"
end
