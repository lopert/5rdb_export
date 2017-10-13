# step 1, build your deck on https://fiveringsdb.com/
# step 2, copy paste the view into deck.txt
# step 3, run "ruby to_TTS.rb"
# step 4, paste output to http://infamous-irc.com/dengeki/l5r-deck-generator/
# step 5, save generated file as per http://infamous-irc.com/dengeki/l5r-deck-generator/

deck_array = []
name = ""
stronghold = {}
role = {}
provinces = {}
dynasty = {}
conflict = {}

# read file
File.open("deck.txt").each do |line|
	# remove influence pips and trailing whitespace
	deck_array << line.tr('/','').rstrip
end

# store name for now, unused
name = deck_array.shift

# remove Edit  Delete Permalink  Publish links
deck_array.shift

# remove whitespace
deck_array.shift

# determine stronghold and role deck
stronghold[deck_array.shift] = 1
role[deck_array.shift] = 1

# parse from provinces to dynasty
while !deck_array[0].include? "Dynasty Deck"
	current_province = deck_array.shift
	if !(current_province.include? "Influence")
		# remove elemental property
		provinces[current_province[0..current_province.rindex(' ')]] = 1
	end
end

# parse from dynasty to conflict
while !deck_array[0].include? "Conflict Deck"
	current_dynasty = deck_array.shift
	if current_dynasty[0] =~ /\d/
		dynasty[current_dynasty[4..-1]] = current_dynasty[0]
	end
end

# parse from conflict to end
while !deck_array.empty?
	current_conflict = deck_array.shift
	if current_conflict[0] =~ /\d/
		conflict[current_conflict[4..-1]] = current_conflict[0]
	end
end

puts "+ Stronghold_Role"
stronghold.each do |key, value|
	puts "#{value} #{key}"
end

role.each do |key, value|
	puts "#{value} #{key}"
end

puts "- Provinces"
provinces.each do |key, value|
	puts "#{value} #{key}"
end

puts "- Dynasty"
dynasty.each do |key, value|
	puts "#{value} #{key}"
end

puts "- Conflict"
conflict.each do |key, value|
	puts "#{value} #{key}"
end
