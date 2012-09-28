# -*- encoding : utf-8 -*-
module MembersHelper
  def generate_password
    ('a'..'z').to_a.shuffle[0,8].join
  end
end
