class Inbox < ActiveRecord::Base
  set_table_name "inbox"
  cattr_reader :per_page
  @@per_page = 10
end
