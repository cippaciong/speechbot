require 'google/cloud/speech'
require 'dry-monads'

module Recognizer
  def self.recognize(rawfile, lang)
    begin
    speech = Google::Cloud::Speech.new
    job = speech.recognize_job rawfile,
                               encoding: :raw,
                               sample_rate: 16_000,
                               language: lang

    # Wait for the job to be done
    until job.done?
      job.reload!
      sleep 5
    end

    # Return the rirst result
    results = job.results
    result = results.first
    result ? Dry::Monads.Right(result.transcript) : Dry::Monads.Left('wut?')
    rescue Google::Cloud::InvalidArgumentError
      return Dry::Monads.Left('Files longer than 1 minute ' \
                              'are not supported for now, sorry :(')
    rescue Google::Cloud::UnavailableError
      return Dry::Monads.Left('Service unavailable, please retry')
    end
  end
end
