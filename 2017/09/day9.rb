# test inputs
input1 = "{}"
input2 = "{{{}}}"
input3 = "{{},{}}"
input4 = "{{{},{},{{}}}}"
input5 = "{<a>,<a>,<a>,<a>}"
input6 = "{{<ab>},{<ab>},{<ab>},{<ab>}}"
input7 = "{{<!!>},{<!!>},{<!!>},{<!!>}}"
input8 = "{{<a!>},{<a!>},{<a!>},{<ab>}}"
input9 = "{{!}!!}!!}"

f = File.read("input.txt")

def parse(str)
  chars = str.chars()
  depth = 0
  score = 0
  garbage_amount = 0
  skip = false
  in_garbage = false
  chars.each_with_index { |char, idx|
    if skip == true
      skip = false
      next
    end
    case
    when char == "!"
      skip = true
    when (char == "<" && in_garbage == false)
      in_garbage = true
    when (char == "<" && in_garbage == true)
      garbage_amount += 1
    when char == ">"
      in_garbage = false
    when (char == "{" && in_garbage == false)
      depth += 1
    when (char == "}" && in_garbage == false)
      score += depth
      depth -= 1
    when (in_garbage == true)
      garbage_amount += 1
    end
  }
  return score, garbage_amount
end

puts parse(f)