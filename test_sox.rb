$stderr.reopen("/dev/null", "w")

def duration(audio)
  IO.popen(['soxi', '-d', audio], 'r') do |f|
    f.gets(nil).to_s
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

audio = 'test/samples/audio.ogg'

audio_info = { duration: duration(audio),
               encoding: encoding(audio),
               file_type: file_type(audio),
               sample_rate: sample_rate(audio),
               precision: precision(audio) }

audio_info.each do |key, value|
  puts "#{key}: #{value}"
end
