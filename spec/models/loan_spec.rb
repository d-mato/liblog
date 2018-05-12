require 'rails_helper'

describe Loan do
  describe :arrears? do
    subject { loan.arrears? }

    context '返却済み' do
      let(:loan) { build(:loan, returned: true) }
      it { is_expected.to be false }
    end

    context '返却期限が昨日' do
      let(:loan) { build(:loan, returned: false, ended_at: Date.yesterday) }
      it { is_expected.to be true }
    end
  end
end
