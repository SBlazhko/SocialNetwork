class Api::V1::AttachmentFileController < ApplicationController
  require 'mime/types'

  api :POST, 'upload_file', 'Upload single file'
  formats ['multipart/form-data']
  error code: 400, desc:"cant save file"
  param :file, ActionDispatch::Http::UploadedFile, required: true
  example AttachmentFileHelper.upload_file

  def upload_file
    file = AttachmentFile.new
    file.file = params[:file]
    file.profile = current_user
    begin
      file.save!
      render json: {message: 'success', url: file.file.url, file_id: file.id, file_name: file.file_file_name},status: 201
    rescue Exception
      render json: {error: file.errors}, status: 400
    end
  end

  api :DELETE, 'destroy_file', 'Delete single file'
  formats ['application/json']
  error code: 400, desc:"cant destroy file"
  error code: 404, desc: 'not found'
  param :file_id, :number, required: true

    def destroy_file
    file = AttachmentFile.find_by('profile_id  = ?  and id = ?', current_user.id, params[:file_id])
    if(file.blank?)
      render json: {message: 'not found'}, status: 404
      return;
    end
    begin file.file.destroy
      file.delete
      render json:{message: 'destroyed'},status: 200

    rescue Exception
      render json:{error: $!}, status: 400
    end
  end

  api :GET, 'get_files_list', 'Get list of files'
  formats ['application/json']
  error code: 404, desc: 'not found'
  param :profile_id, :number, require: false, desc: 'if profile id isnt present you will get current users files'
  example AttachmentFileHelper.get_files_list

  def get_files_list
    if(params[:user_id] != nil)
      profile = Profile.find_by('id = ?', params[:profile_id])
    else
      profile = current_user
    end
    unless (profile == nil)
      res = Hash.new
      res[:files] = []
      profile.attachment_files.each do |f|
          res[:files].push ({owner_id: f.profile.id, owner_login: f.profile.login, url: f.file.url, file_id: f.id, file_name: f.file_file_name})
      end
      render json: res, status: 200
    else
      render json: {message: 'user isnt exist'}, status: 404
    end
  end

  api :GET, 'get_file', 'Get file by id'
  formats ['application/json']
  param :file_id, :number, required: true, desc: 'get file by id'
  error code: 404, desc: 'not found'
  example AttachmentFileHelper.get_file

  def get_file
    file = AttachmentFile.find_by('id = ?', params[:file_id])
    if(file == nil)
      render json: {message: 'file isnt exist'}, status: 404
    else
      render json: {owner_profile: file.profile.login, owner_profile_id: file.profile.id, file_id: file.id, url: file.file.url}, status: 200
    end
  end
end
