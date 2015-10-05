class CreateJusyos < ActiveRecord::Migration
  def change
    create_table "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos" do |t|
      t.string  :address_code,         limit: 9
      t.string  :prefecture_code,      limit: 2
      t.string  :city_code,            limit: 5
      t.string  :town_code,            limit: 9
      t.string  :zip_code,             limit: 8
      t.string  :is_place,             limit: 1
      t.string  :is_deleted,           limit: 1
      t.string  :prefecture_name
      t.string  :prefecture_name_kana
      t.string  :city_name
      t.string  :city_name_kana
      t.string  :town_name
      t.string  :town_name_kana
      t.string  :town_name_plus
      t.string  :kyoto_name
      t.string  :town_detail
      t.string  :town_detail_kana
      t.string  :memo
      t.string  :place_name
      t.string  :place_name_kana
      t.string  :place_address
      t.string  :new_address_code
    end

    add_index "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos", :address_code,    name: 'i_address_code'
    add_index "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos", :prefecture_code, name: 'i_prefecture_code'
    add_index "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos", :city_code,       name: 'i_city_code'
    add_index "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos", :town_code,       name: 'i_town_code'
    add_index "#{DlJusyoJp::ADDRESS_MODELS_PREFIX}jusyos", :zip_code,        name: 'i_zip_code'
  end
end
