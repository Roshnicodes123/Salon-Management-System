ActiveAdmin.register Barbar do

  permit_params :email, :password,:status
  # action all

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :status
    # column :created_at
    actions
  end

  filter :email
  filter :username
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :status, as: :select

    end
    f.actions
  end

  member_action :activate, method: :put do
    resource.update!(status: :active)
    BarbarMailer.account_activation_mail(resource.email).deliver_now
    redirect_to admin_barbars_path, notice: "barbar was succefully activated."
  end
  

  controller do
    def update
      update! do |format|
        if resource.status == 'active'
          BarbarMailer.account_activation_mail(resource.email).deliver_now
          format.html { redirect_to admin_barbars_path, notice: "Activation email sent successfully!" }
        else
          format.html { redirect_to admin_barbars_path, notice: "Barbar was successfully updated." }
        end
      end
    end
  end
  
  
end
