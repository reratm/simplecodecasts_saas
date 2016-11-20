class Users::RegistrationsController < Devise::RegistrationsController
    
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan] #2 = pro because we added it second
        if resource.plan_id == 2
          resource.save_with_payment
        else
          resource.save
        end
      end
    end
  end
  
end