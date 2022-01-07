class WaterMailer < ApplicationMailer

  def send_mail(grow_plant)
    @email = @grow_plant.user.email

    mail to:  @email,
    subject: '今日は植物の水やり日です'
  end

end
