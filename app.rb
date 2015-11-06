# coding: utf-8

# coding: utf-8
require 'sinatra'

OK = 200
CREATED = 201
NOT_FOUND = 404

# curl http://localhost:4567/
get '/' do
  Dir::entries(File.expand_path('.')).select{|file|file.match("txt$")}.to_s
end

# curl -d "name=memo" -d "body=hello world" http://localhost:4567
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

# curl http://localhost:4567/memo
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

# curl -X PUT -d "body=hello world !!!" http://localhost:4567/memo
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

# curl -X PATCH -d "body=hello world !!!" http://localhost:4567/memo
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

# curl -X DELETE http://localhost:4567/memo
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
