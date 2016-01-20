class klass < Udongo::ActiveModelSimulator

  def form_instance
    Form.find_by(name: 'form_name')
  end

  def save(parameters)
    if valid?
      submission = form_instance.submissions.create!
      form_instance.fields.each do |field|
        submission.data.new(name: field.name, value: parameters[field.name.to_sym])
      end
      submission.save!
    else
      false
    end
  end
end
