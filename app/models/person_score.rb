class PersonScore < ActiveRecord::Base
    set_table_name 'dynasty_player_points'

    belongs_to :person
    belongs_to :draftable_player, :primary_key => "person_id"
end
