

ActiveAdmin.register TimeSlot do
  permit_params :start_time, :end_time, :salon_id
  actions :all
  
    index do
      selectable_column
      id_column
      column :start_time
      column :end_time
      # column :available_seats
        # column :salon


      actions
    end
  
    filter :start_time
    filter :end_time
    # filter :available_seats
  
    form do |f|
      f.inputs 'Time Slot Details' do
        f.input :start_time
        f.input :end_time
        # f.input :available_seats
        f.input :salon_id, as: :hidden
      end
      f.actions
    end
    controller do

      def scoped_collection
        current_salon.time_slots
      end
    end
    
    
  end
  