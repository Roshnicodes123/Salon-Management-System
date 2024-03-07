ActiveAdmin.register Service do
  # menu priority: 4
  actions :all

  permit_params  :name,:description, :price, :image

  index do
    selectable_column
    # id_column
    column :name
    
    # column :current_sign_in_at
    # column :sign_in_count
    column :description
    column :price
    column :image, as: :file

    actions
  end

  filter :name
  filter :description
  filter :price

  

  form do |f|
    f.inputs do
      f.input :name
      f.input :description 
      f.input :price
      f.input :image, as: :file

    
    end
    
    f.actions
  end

  controller do

    def scoped_collection
      current_salon.services
    end
  end

end
