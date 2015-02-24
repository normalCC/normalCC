desc "remove seaches"
task :remove_old_searches => :environment do 
  Search.delete_all
end
