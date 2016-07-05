path = File.join(Rails.root, "config/config.yml")
APP_CONFIG = YAML.load(File.read(path))[Rails.env] || {'sid' => '', 'from' => '', 'token' => ''}
