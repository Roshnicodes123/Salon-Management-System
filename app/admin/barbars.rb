ActiveAdmin.register Barbar do

  permit_params :email, :password,:status,:username

  index do
    column :email
    column :username
    column :status
    column :salon
    actions
    actions do |barbars|
    
      if barbars.status == 'active'
        link_to 'Inactive',barbars_staus_salon_barbar_path(barbars.id)
      else
        link_to 'Active', barbars_staus_salon_barbar_path(barbars.id)
      end
    end
  end

  filter :email
  filter :username

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :status, as: :select
    end
    f.actions
  end

  controller do

    def scoped_collection
      current_salon.barbars
    end
  end
  
  member_action :barbars_staus, method: :get do
    barbar = Barbar.find(params[:id])
    if barbar.status =='active'
      barbar.update(status:0)
    else 
      barbar.update(status:1)
    end
    redirect_to salon_barbars_path

  end
end
