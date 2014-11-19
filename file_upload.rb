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
    set :formats, ".png .jpg .gif .bmp"
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

      if !filename.index(settings.formats).nil?
        File.open(File.join(settings.files, filename), 'wb') do |f|
          f.write file.read
        end 
      else
        flash 'Only image file(png,gif,jpg) can be upload here!'
      end

      flash 'Upload successful'
    else
      flash 'You have to choose a image file'
    end

    redirect '/'
  end
  
  # parse some apk file url to a fix url : dl.leomaster.com/theme
  get '/theme' do
    redirect '/theme/appmaster_theme.apk'
  end

  # parse appmaster.apk to a fix url : dl.leomaster.com/appmaster
  get '/appmaster' do
    redirect '/release/appmaster_guanwang.apk'
  end
  
end
