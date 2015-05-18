require "rubygems"
require "sinatra"

get "/" do
  erb :index
end
 
post '/credit_calculations' do
  erb :credit_calculations, locals: {credit_sum: params[:credit_sum].to_f, number_of_periods: params[:number_of_periods].to_i, interest_rate: params[:interest_rate].to_f}
end

class Calculator
  def calculate(credit_sum, number_of_periods, interest_rate)
    basic_debt = credit_sum / number_of_periods
    credit_balance = credit_sum
    annuity_credit_balance = credit_sum
    credit_overpayment = 0
    annuity_overpayment = 0
    annuity_liquidated_debt = 0
    month_interest_rate = (interest_rate / 100) / 12
     d1 = ((1 + month_interest_rate)**number_of_periods) - 1
     s1 = month_interest_rate + (month_interest_rate / d1)
     annuity_due = credit_sum * s1
  end
end
