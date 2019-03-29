class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
 

      print "\n------------------------------------------------\n"
      # print "t.string: #{t.string}\n"
      # print "t.string.class: #{t.string.class}\n"
      # print "t.string(:title): #{t.string(:title)}\n"
      # print "t.string(:title).class: #{t.string(:title).class}\n"
      # print "print.class: #{print.class}"

      # print "t.class: #{t.class}\n"
      # print "t.methods - Object.methods: #{t.methods - Object.methods}\n"

      # For more info, check out hte TableDefinition object in the Rails API.
      print "------------------------------------------------\n"
    end
  end
end

