ActiveAdmin.register Salon do
  menu priority: 2
  actions :all, :except => [:new, :destroy]

  permit_params :email, :name,:password, :password_confirmation, :address, :start_time, :end_time, :seat_capacity, :cover_image

  index do
    selectable_column
    id_column
    column :email
    
    # column :current_sign_in_at
    # column :sign_in_count
    column :name
    column :address
    column :start_time
    column :end_time
    column :seat_capacity
    column :cover_image, as: :file
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name  
      f.input :address
      f.input :start_time
      f.input :end_time
      f.input :seat_capacity, input_html: { value: 10 }
      f.input :cover_image, as: :file
    end
    
    f.actions
  end

end
