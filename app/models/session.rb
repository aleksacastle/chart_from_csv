class Session < ApplicationRecord
  PERCENT = 100

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Session.create! row.to_hash
    end
  end

  def self.failed_percent
    # builds groupped by day and by summary_status
    total_hash = Session.group(:summary_status).group_by_day(:created_at).count

    # initiate empty array for passed and failed builds
    passed_array =[]
    failed_array =[]

    # passed and failed builds per day
    total_hash.each do |key, value|
      if key.include?("passed")
        passed_array << value
      end
      if key.include?("failed")
        failed_array << value
      end
    end

    # initiate empty array for percent of failed builds percentage
    percent=[]
    # calculate percent of failed in total failed and passed builds
    passed_array.each_index do |i|
      if passed_array[i]+failed_array[i]==0
        percent[i]=0
      else
        percent[i]= failed_array[i] * PERCENT / (failed_array[i]+passed_array[i])
      end
    end

    # array of all dates
    total_hash_dates=Session.group_by_day(:created_at).count
    dates_array = total_hash_dates.keys

    # percent of failed builds per day with date
    percent_hash = Hash[dates_array.zip(percent)]
  end

  def self.anomaly
    # Grubbs' test for outliers
    # https://en.wikipedia.org/wiki/Grubbs'_test_for_outliers
    arr = Session.failed_percent.values
    arr.extend Basic::Stats
    arr.select_outliers
  end
end
