require 'time'
$stderr.reopen("/dev/null", "w")

def duration(audio)
  IO.popen(['soxi', '-d', audio], 'r') do |f|
    Time.parse(f.gets(nil).to_s)
  end
end

def channels(audio)
  IO.popen(['soxi', '-c', audio], 'r') do |f|
    f.gets(nil).to_s
  end
end

def sample_rate(audio)
  IO.popen(['soxi', '-r', audio], 'r') do |f|
    f.gets(nil).to_s
  end
end

def precision(audio)
  IO.popen(['soxi', '-p', audio], 'r') do |f|
    f.gets(nil).to_s
  end
end

def encoding(audio)
  IO.popen(['soxi', '-e', audio], 'r') do |f|
    f.gets(nil).to_s
  end
end

def file_type(audio)
  IO.popen(['soxi', '-t', audio], 'r') do |f|
    f.gets(nil).to_s
  end
end


Struct.new("AudioInfo", :duration, :encoding, :file_type, :sample_rate, :precision)

puts

audio = 'test/samples/audio.ogg'
audio_info = Struct::AudioInfo.new(duration(audio),
                                   encoding(audio),
                                   file_type(audio),
                                   sample_rate(audio),
                                   precision(audio))

audio_info.each_pair do |key, value|
  puts "#{key}: #{value}"
end

puts

audio = 'test/samples/capra.mp3'
audio_info = Struct::AudioInfo.new(duration(audio),
                                   encoding(audio),
                                   file_type(audio),
                                   sample_rate(audio),
                                   precision(audio))

audio_info.each_pair do |key, value|
  puts "#{key}: #{value}"
end

puts

audio = 'test/samples/audio.wav'
audio_info = Struct::AudioInfo.new(duration(audio),
                                   encoding(audio),
                                   file_type(audio),
                                   sample_rate(audio),
                                   precision(audio))

audio_info.each_pair do |key, value|
  puts "#{key}: #{value}"
end

puts

audio = 'test/samples/audio_too_long.ogg'
audio_info = Struct::AudioInfo.new(duration(audio),
                                   encoding(audio),
                                   file_type(audio),
                                   sample_rate(audio),
                                   precision(audio))

audio_info.each_pair do |key, value|
  puts "#{key}: #{value}"
end

puts
