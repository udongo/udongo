require 'rails_helper'

describe Udongo::EmailVarsParser do
  include described_class

  describe 'replace vars' do
    it 'basic var missing' do
      expect(replace_vars('I am [name]', {})).to eq 'I am [name]'
    end

    it 'basic var present' do
      vars = {}
      vars['name'] = 'Davy'

      expect(replace_vars('I am [name]', vars)).to eq 'I am Davy'
    end

    it 'must handle symbols' do
      vars = {}
      vars[:name] = 'Davy'

      expect(replace_vars('I am [name]', vars)).to eq 'I am Davy'
    end

    it 'handles nested collections' do
      vars = {}
      vars[:workshop_subscription] = { workshop: { foo: 'bar' } }
      expect(replace_vars('Welcome to [workshop_subscription.workshop.foo]', vars)).to eq 'Welcome to bar'
    end
  end

  describe 'single line ifs' do
    it 'must handle symbols' do
      vars = {}
      vars[:stupid] = true

      expect(replace_ifs('I am [if:stupid]silly[/if]', vars)).to eq 'I am silly'
    end

    it 'basic if missing' do
      expect(replace_ifs('I am [if:stupid]silly[/if]', {})).to eq 'I am '
    end

    it 'basic if present and true' do
      vars = {}
      vars['stupid'] = true

      expect(replace_ifs('I am [if:stupid]silly[/if]', vars)).to eq 'I am silly'
    end

    it 'basic if present and false' do
      vars = {}
      vars['stupid'] = false

      expect(replace_ifs('I am [if:stupid]silly[/if]', vars)).to eq 'I am '
    end

    it 'multiple ifs' do
      vars = {}
      vars['street'] = 'Durmakker'
      vars['number'] = '7'
      vars['city'] = 'Evergem'

      content = 'Adres wijzigingen:
[if:street]Straat: [street][/if]
[if:number]Nummer: [number][/if]
[if:city]Stad: [city][/if]'

      expect(replace_vars(content, vars)).to eq 'Adres wijzigingen:
Straat: Durmakker
Nummer: 7
Stad: Evergem'
    end

    it 'multiple ifs but only 2 of 3 are true' do
      vars = {}
      vars['street'] = false
      vars['number'] = '7'
      vars['city'] = 'Evergem'

      content = 'Adres wijzigingen:
[if:street]Straat: [street][/if]
[if:number]Nummer: [number][/if]
[if:city]Stad: [city][/if]'

      expect(replace_vars(content, vars)).to eq 'Adres wijzigingen:

Nummer: 7
Stad: Evergem'
    end
  end

  describe 'multi line ifs' do
    it 'basic if missing' do
      content = "[if:co_seller]\nHi there![/if]"
      expect(replace_ifs(content, {})).to eq ''
    end

    it 'basic if present and true' do
      vars = {}
      vars['co_seller'] = true

      content = "[if:co_seller]\nHi there![/if]"

      expect(replace_ifs(content, vars)).to eq "\nHi there!"
    end

    it 'basic if present and false' do
      vars = {}
      vars['co_seller'] = false

      content = "[if:co_seller]\nHi there![/if]"

      expect(replace_ifs(content, vars)).to eq ''
    end
  end
end
