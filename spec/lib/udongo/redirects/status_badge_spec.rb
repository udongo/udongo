describe Udongo::Redirects::StatusBadge do
  let(:view) { double(:view_context, content_tag: nil) }

  describe '#css_class' do
    it 'returns "success" when the redirect is working' do
      subject = described_class.new(view, double(:redirect, working: 1, working?: true))
      expect(subject.css_class).to eq 'success'
    end

    it 'returns "info" when the redirect#working column is nil' do
      subject = described_class.new(view, double(:redirect, working: nil, working?: false))
      expect(subject.css_class).to eq 'info'
    end

    it 'returns "danger" when the redirect is not working and not nil' do
      subject = described_class.new(view, double(:redirect, working: 0, working?: false))
      expect(subject.css_class).to eq 'danger'
    end
  end

  it '#html' do
    subject = described_class.new(view, double(:redirect, working: nil, working?: false, status_code: 400))
    expect(subject.view).to receive(:content_tag).with(:span, 400, class: 'badge badge-info')
    subject.html
  end

  describe '#icon' do
    it 'returns an OK icon when the redirect is working' do
      subject = described_class.new(view, double(:redirect, working: 1, working?: true, broken?: false))
      expect(subject.view).to receive(:icon).with(:check_circle)
      subject.icon
    end

    it 'returns an OK icon when the redirect is working' do
      subject = described_class.new(view, double(:redirect, working: 0, working?: false, broken?: true))
      expect(subject.view).to receive(:icon).with(:times_circle)
      subject.icon
    end

    it 'returns nothing when the redirect is untested' do
      subject = described_class.new(view, double(:redirect, working: nil, working?: false, broken?: true))
      expect(subject.view).to receive(:icon).with(:question_circle)
      subject.icon
    end
  end
end
