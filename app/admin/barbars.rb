ActiveAdmin.register Barbar do

  permit_params :email, :password,:status,:username

  index do
    column :email
    column :username
    column :status
    column :salon
    actions
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
  
end
