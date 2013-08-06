ActiveAdmin.register Vehicle do

  for lot in DealerLot.all
    batch_action "#{lot[:name]}: assign".to_sym do |selection|
      Vehicle.find(selection).each {|v| p v}
      redirect_to collection_path, :alert => "#{selection.length} Vehicles assigned to #{lot[:name]}"
    end
  end

end