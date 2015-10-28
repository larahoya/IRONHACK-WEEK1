def is_palindrome? palindrome_candidate

	words = palindrome_candidate.downcase.split(" ")

	if words == words.reverse
		return true
	else
		return false
	end

end

str = "Fall leaves as soon as leaves fall"

puts is_palindrome? str