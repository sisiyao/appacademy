
def first_anagram?(str1, str2)
  first_string_perms = str1.chars.permutation(str1.length)
  all_strings = first_string_perms.map(&:join)

  all_strings.include?(str2)
end
# O(n!)

def second_anagram?(str1, str2)
  str1_copy, str2_copy = str1.chars, str2.chars

  str1.each_char do |char|
    if str2_copy.include?(char)
      str1_copy.delete(char)
      str2_copy.delete(char)
    end
  end

  str1_copy == str2_copy
end
# O(n^2)


def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end
# O(n)

def fourth_anagram?(str1, str2)
  count_hash = Hash.new(0)

  str1.each_char do |char|
    count_hash[char] += 1
  end

  str2.each_char do |char|
    count_hash[char] -= 1
  end

  count_hash.values.all?(&:zero?)
end
# O(n)
