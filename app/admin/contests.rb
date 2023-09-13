ActiveAdmin.register Contest do
  permit_params :name, :about

  index do
    selectable_column
    id_column
    column :name
    column :about
    actions
  end

  filter :name
  filter :about

  form do |f|
    f.inputs do
      f.input :name
      f.input :about
    end
    f.actions
  end

end
