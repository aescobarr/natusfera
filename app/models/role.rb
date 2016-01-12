class Role < ActiveRecord::Base
  ADMIN = 'admin'
  CURATOR = 'curator'
  ADMIN_ROLE = Role.find_or_create_by_name(ADMIN)
  CURATOR_ROLE = Role.find_or_create_by_name(CURATOR)
end
