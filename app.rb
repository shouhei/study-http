# coding: utf-8
require 'sinatra'

OK = 200
CREATED = 201
NOT_FOUND = 404


get '/' do
  Dir::entries(File.expand_path('.')).select{|file|file.match("txt$")}.to_s
end

post '/' do
  file_name = @params[:name] + ".txt"
  if !File.exist? file_name
    File.write file_name, @params[:body]
    status CREATED
    body "#{file_name}に#{@params[:body]}と保存しました\n"
  else
    status OK
    body "#{file_name}は既に存在しています\n"
  end
end

get '/:name' do
  file_name = @params[:name] + ".txt"
  if File.exist? file_name
    status OK
    File.read file_name
  else
    status NOT_FOUND
    body "#{file_name}は存在しません\n"
  end
end

put '/:name' do
  file_name = @params[:name] + ".txt"
  if File.exist? file_name
    status OK
  else
    status CREATED
  end
  File.write file_name, @params[:body]
  body "#{file_name}に#{@params[:body]}と保存しました\n"
end

patch '/:name' do
  file_name = @params[:name] + ".txt"
  if File.exist? file_name
    File.write file_name, @params[:body]
    status OK
    body "#{file_name}に#{@params[:body]}と保存しました\n"
  else
    status NOT_FOUND
    body "#{file_name}は存在しません\n"
  end
end

delete '/:name' do
  file_name = @params[:name] + ".txt"
  if File.exist? file_name
    File.delete file_name
    body "#{file_name}を削除しました\n"
  else
    status NOT_FOUND
    body "#{file_name}は存在しません\n"
  end
end
