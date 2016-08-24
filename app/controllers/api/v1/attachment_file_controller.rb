class Api::V1::AttachmentFileController < ApplicationController
  require 'mime/types'

  def upload_file
    plaintext = MIME::Types[request.headers['Content-Type']]
    text = plaintext.first
    puts text.preferred_extension
    tmp_file = Tempfile.new(['hello', ".#{text.preferred_extension}"], encoding: 'ASCII-8BIT')
    tmp_file.write request.body.read
    tmp_file.flush
    file = AttachmentFile.new
    file.file = tmp_file
    file.profile = current_user
    binding.pry
    file.save
    tmp_file.close
  end
end
