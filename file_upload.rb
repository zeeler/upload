# encoding: utf-8

require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'

configure {
  set :server, :puma
}

class FileUpload < Sinatra::Base
  configure do
    enable :static
    enable :sessions

    set :views, File.join(File.dirname(__FILE__), 'views')
    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :files, File.join(settings.public_folder, 'files')
    set :unallowed_paths, ['.', '..']
  end

  helpers do
    def flash(message = '')
      session[:flash] = message
    end
  end

  before do
    @flash = session.delete(:flash)
  end

  not_found do
    erb 'h1 404'
  end

  error do
    erb "Error (#{request.env['sinatra.error']})"
  end

  get '/' do
    @files = Dir.entries(settings.files).sort_by{|f| File.mtime(settings.files + "/" + f)}.reverse! - settings.unallowed_paths

    erb :index
  end
  
  post '/upload' do
    if params[:file]
      filename = params[:file][:filename]
      file = params[:file][:tempfile]

      File.open(File.join(settings.files, filename), 'wb') do |f|
        f.write file.read
      end

      flash 'Upload successful'
    else
      flash 'You have to choose a file'
    end

    redirect '/'
  end
end
