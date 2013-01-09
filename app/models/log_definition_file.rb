class LogDefinitionFile < DefinitionFile
  # attr_accessible :title, :body
  belongs_to :jmeter_run, :touch => true
end
