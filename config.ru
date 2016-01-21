require 'sinatra/base'
require 'sinatra'
require 'sinatra/contrib'
require 'rake'
require 'sinatra/base'
require 'sinatra/content_for'
require 'sinatra/namespace'
require 'date'
require 'pathname'
require 'pg'
require 'active_record'
require 'logger'

require 'bundler/setup'


require ::File.expand_path('../app',  __FILE__)

set :app_file, __FILE__

configure do
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

run Sinatra::Application
