class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.count "^ "

    @word_count = @text.split.count

    @occurrences = @text.scan(@special_word).count
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_interest = (@apr/(12*100))
    @num_months = (@years*12)
    @neg_num_months = (0-@num_months)

    @monthly_payment = @principal*(@monthly_interest/(1-(1+@monthly_interest)**@neg_num_months))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    if @sorted_numbers.length.odd?
        @median = @sorted_numbers[(@sorted_numbers.length-1)/2]
    else @sorted_numbers.length.even?
        @median = (@sorted_numbers[@sorted_numbers.length/2] + @sorted_numbers[@sorted_numbers.length/2-1]).to_f
    end

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.count

    var_ary =[]
    variance = @numbers
    variance.each do |sq_mean|
        var_ary.push((sq_mean-@mean)**2)
        sum_variance = var_ary.sum
        @variance = sum_variance/@count
    end

    @standard_deviation = @variance**(0.5)

    counter = Hash.new(0)
    @numbers.each do |count|
        counter[count] +=1
    end

    @mode = counter.select {|k,v| v==counter.values.max}
    #This is as far as I can get. I can't figure out how to just post the value, and not the key/value pair.

  end
end
