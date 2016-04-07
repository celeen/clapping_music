use_bpm 75
use_debug false
load_sample :drum_tom_hi_hard
load_sample :drum_tom_mid_hard

@voice1 = :drum_tom_hi_hard
@voice2 = :drum_tom_mid_hard

@baseline = [1,1,1,0,1,1,0,1,0,1,1,0]

def play_note(voice_name)
  sample voice_name
  sleep 0.25
end

def play_rest
  sleep 0.25
end

def log(part2)
  puts part2 == @baseline
  puts "1: #{@baseline}"
  puts "2: #{part2}"
end

def play_measure(pattern, voice)
  pattern.each do |value|
    value == 1 ? play_note(voice) : play_rest
  end
end

def play_section(pattern, voice)
  4.times do
    play_measure(pattern, voice)
  end
end

def both_parts_play_section(part2)
  log(part2)

  in_thread do
    play_section(@baseline, @voice1)
  end

  play_section(part2, @voice2)
end

def play_recursive_bit(rotating_part)
  both_parts_play_section(rotating_part)

  return if rotating_part == @baseline

  play_recursive_bit(rotating_part.rotate)
end

def play_piece(part)
  both_parts_play_section(@baseline)
  play_recursive_bit(@baseline.clone.rotate)
end

play_piece(@baseline)
