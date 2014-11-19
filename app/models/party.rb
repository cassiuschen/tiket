class Party < ActiveRecord::Base
  basic_setting = YAML.load_file("#{Rails.root}/config/party_time.yml")[Rails.env]

  @@start_at = basic_setting["start_at"].to_datetime
  @@rate = basic_setting["basic_rate"].to_f
  @@has_started = true


  @@collection_id = basic_setting["collection_id"]

  STATUS ={
      start: "正在进行",
      waiting: "等待开始",
      finish: "已结束"
  }

  def self.start_at
    @@start_at
  end

  def self.collection_id
    @@collection_id
  end

  def self.collection_id=(argv)
    @@collection_id = argv
  end

  def self.can_attend?
    !!(Party.times_up? && @@has_started)
  end

  def self.start_at_humanize
    "#{@@start_at.month}月#{@@start_at.day}日，#{@@start_at.hour}:#{@@start_at.min}"
  end

  def self.start_at=(argv)
    @@start_at = argv
  end

  def self.rate
    @@rate
  end

  def self.times_up?
    !!(Time.now.to_datetime > @@start_at)
  end

  def self.rate=(argv)
    @@rate = argv
  end

  def self.status
    if Time.now.to_datetime > @@start_at
      if @@has_started
          STATUS[:start]
      else
        STATUS[:finish]
      end
    else
      STATUS[:waiting]
    end
  end

end