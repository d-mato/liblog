require 'rails_helper'

describe LoanDecorator do
  let(:loan) { Loan.new.extend LoanDecorator }
  subject { loan }
  it { should be_a Loan }
end
