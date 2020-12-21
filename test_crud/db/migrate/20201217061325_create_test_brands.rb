class CreateTestBrands < ActiveRecord::Migration
  def change
    create_table :test_brands, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :korea_name
      t.integer :linup_count, :null => false, :default => 0
      t.string :country

      t.timestamps
    end
  end
end
