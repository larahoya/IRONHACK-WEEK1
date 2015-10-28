def is_palindrome? palindrome_candidate
	
	clean_palindrome = palindrome_candidate.downcase.gsub(" ","").gsub(",","")

	if clean_palindrome == clean_palindrome.reverse
		return true
	else
		return false
	end
end


str = "dad"
str2 = "Anna"
str3 = "step on no pets"
str4 = "On a clover, if alive, erupts a vast pure evil, a fire volcano"

puts is_palindrome?(str)
puts is_palindrome?(str2)
puts is_palindrome?(str3)
puts is_palindrome?(str4)