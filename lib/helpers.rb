def ask question
  Proc.new {
    print question
    gets.chomp("\n")
  }
end

def root_path
  File.join File.dirname(__FILE__), ".."
end

def package_path *args
  File.join root_path, "packages", args
end

def file_path file
  File.join root_path, 'files', env, file
end

def env
  ENV['SPRINKLE_ENV']
end

def attributes
  contents = File.read "./attributes/#{env}.yml"
  HashWithIndifferentAccess.new Psych.load(contents)
end
