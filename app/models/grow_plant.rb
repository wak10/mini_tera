class GrowPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant, optional: true
  has_many :logs, dependent: :destroy
  attachment :image

  enum place:{ 日向:0, 半日陰:1 }


  def self.send_mail
    @grow_plants = GrowPlant.all
    @grow_plants.find_each do |grow_plant|
      @frequency = grow_plant.plant.frequency
      grow_plant.logs.last(1).each do |last_log|
        @next_log = last_log.created_at.to_date + @frequency.days
        @today = Date.today
        if @next_log <= @today
          @grow_plant = grow_plant
          WaterMailer.send_mail(@grow_plant).deliver
          p "send_mail"
        else
          p "false"
        end
      end
    end
  end

  validates :frequency, presence: { message: "水やり頻度を入力してください" }
  validates :image, presence: { message: "画像を登録してください" }
end
