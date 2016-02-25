require 'rails_helper'

describe QueuedTask do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:klass) { expect(build(klass, klass: nil)).not_to be_valid }
    end
  end

  describe 'scopes' do
    before(:each) do
      @a = create(klass, locked: true)
      @b = create(klass, locked: false)
      @c = create(klass, locked: nil)
    end

    it :locked do
      expect(model.locked).to eq [@a]
    end

    it :not_locked do
      expect(model.not_locked).to eq [@b, @c]
    end
  end

  it '#lock!' do
    task = create(klass, locked: false)
    task.lock!
    expect(task).to be_locked
  end

  it '#unlock!' do
    task = create(klass, locked: true)
    task.unlock!
    expect(task).not_to be_locked
  end

  it '.queue' do
    model.queue Object, foo: 'bar'
    expect(model.count).to eq 1
    expect(model.first.klass).to eq 'Object'
    expect(model.first.data).to eq({ foo: 'bar' })
  end

  it '.queue_unless_already_queued' do
    model.queue_unless_already_queued Object, foo: 'bar'
    expect(model.count).to eq 1

    model.queue_unless_already_queued Object, foo: 'bar'
    expect(model.count).to eq 1
    expect(model.first.klass).to eq 'Object'
    expect(model.first.data).to eq({ foo: 'bar' })
  end

  it '#dequeue!' do
    task = model.queue Object, foo: 'bar'
    task.dequeue!
    expect(model.count).to eq 0
  end

  it '#process!' do
    task = create(klass, klass: Object, locked: false)
    expect { task.process! }.to raise_exception(ArgumentError)
    expect(task).not_to be_locked
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(
      :lock!, :unlock!, :run!, :dequeue!, :process!
    )
  end

  it '.respond_to?' do
    expect(model).to respond_to(:locked, :not_locked, :queue)
  end
end

