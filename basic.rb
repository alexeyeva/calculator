require "rubygems"
require "sinatra"

get "/" do
  erb :index
end
 
post '/credit_calculations' do
  erb :credit_calculations, locals: {credit_sum: params[:credit_sum].to_f, number_of_periods: params[:number_of_periods].to_i, interest_rate: params[:interest_rate].to_f}
end

