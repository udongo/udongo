class Udongo::EmailVars::FormSubmission
  attr_reader :submission

  def initialize(form_submission)
    @submission = form_submission
  end

  def to_hash(prefix: 'submission')
    submission.data.inject({}) do |hash, current|
      hash["#{prefix}.#{current.name}"] = current.value
      hash
    end
  end
end
