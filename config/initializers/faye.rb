require 'yaml'

SERVICES_CONFIG = YAML.load_file("../services.yml")
FAYE_URL = SERVICES_CONFIG["faye"]["url"]
FAYE_TOKEN= SERVICES_CONFIG["faye"]["token"]
