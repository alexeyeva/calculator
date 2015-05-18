require "rubygems"
require "sinatra/base"

class Calculator < Sinatra::Base
  
  def calculate(credit_sum, number_of_periods, interest_rate)
    puts "#{credit_sum}"
    puts "#{number_of_periods}"
    puts "#{interest_rate}"
    @basic_debt = credit_sum / number_of_periods
    @credit_balance = credit_sum
    @annuity_credit_balance = credit_sum
    @credit_overpayment = 0
    @annuity_overpayment = 0
    @annuity_liquidated_debt = 0
    month_interest_rate = (interest_rate / 100) / 12
     d1 = ((1 + month_interest_rate)**number_of_periods) - 1
     s1 = month_interest_rate + (month_interest_rate / d1)
     @annuity_due = credit_sum * s1
     
     (1..number_of_periods).each do |i|
        @extra_percents = @credit_balance * month_interest_rate
        @credit_balance = credit_sum - @basic_debt*i
        @credit_overpayment += @extra_percents
        @payment = @extra_percents + @basic_debt
          puts "#{i}"
          puts "#{month_interest_rate}"
          puts "Взнос #{@payment.round(2)}"
          puts "Проценты #{@extra_percents.round(2)}"
          puts "Остаток кредита #{@credit_balance.round(2)}"
          puts ""
      end
      
      (1..number_of_periods).each do |i|
        @annuity_extra_percents = @annuity_credit_balance * month_interest_rate
        @annuity_basic_debt = @annuity_due - @annuity_extra_percents
        @annuity_liquidated_debt += @annuity_basic_debt
        @annuity_credit_balance  = credit_sum - @annuity_liquidated_debt
        @annuity_overpayment += @annuity_extra_percents
          puts "#{i}"
          puts "Погашение основного долга #{@annuity_basic_debt.round(2)}"
          puts "Проценты #{@annuity_extra_percents.round(2)}"
          puts "Остаток кредита #{@annuity_credit_balance.round(2)}"
          puts ""
       end
  end

  get "/" do
    erb :index
  end
   
  post '/credit_calculations' do
    
    credit_sum = params[:credit_sum].to_f
    number_of_periods = params[:number_of_periods].to_i
    interest_rate = params[:interest_rate].to_f
    
    calculate(credit_sum, number_of_periods, interest_rate)
    erb :credit_calculations
    
  end


end

Calculator.run!