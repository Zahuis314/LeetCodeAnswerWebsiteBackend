namespace :db do
    desc "Recreate database"
    task :recreate do
        Rake::Task["db:drop:_unsafe"].invoke
        Rake::Task["db:create"].invoke
        Rake::Task["db:migrate"].invoke
        Rake::Task["db:seed"].invoke
    end
end