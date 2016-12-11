require "google/cloud/speech"

module Recognizer
  def Recognizer.recognize(audio)
    speech = Google::Cloud::Speech.new
    job = speech.recognize_job audio.raw,
                               encoding: audio.encoding,
                               sample_rate: audio.rate,
                               language: audio.language

    # Wait for the job to be done
    until job.done?
      job.reload!
      sleep 5
    end

    # Return the rirst result
    results = job.results
    unless results.empty?
      result = results.first
      result.transcript
    else
      'wut?'
    end
  end
end