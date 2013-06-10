package :backup do
  gem 'backup'

  # ensure all files are created
  runner 'backup generate:model -t empty_template'
  runner 'rm ~/Backup/models/empty_template.rb'

  # upload custom settings
  src  = package_path 'backup/custom_backup.rb.erb'
  dest = "~/Backup/models/custom_backup.rb"

  transfer(src, dest, render: true, sudo:true, locals: attributes[:backup].merge(
    db_password:            attributes[:database][:password]        || ask("Database Password: "),
    s3_secret_access_key:   attributes[:backup][:s3][:s3_secret_access_key]  || ask("S3 Secret Access Key: "),
    mail_password:          attributes[:backup][:mail][:password]   || ask("Mail Password: "),
  ))

  verify do
    has_gem :backup
    has_executable 'backup'
    has_file '~/Backup/models/custom_backup.rb'
  end
end
