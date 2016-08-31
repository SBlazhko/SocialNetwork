module AttachmentFileHelper
	class << self
		def upload_file
			"{\'message': 'success',\'url': '/system/attachment_files/files/000/000/009/original/hello20160825-12659-1hnx7d6.jpeg?1472131725',
			\'file_id': 9,\'file_name': 'hello20160825-12659-1hnx7d6.jpeg'\
			}"
		end

		def get_files_list
			"{\n
			  'files': [\n
			    {\n
			      'owner_id': 1,\n
			      'owner_login': 'yuri',\n
			      'url': '/system/attachment_files/files/000/000/008/original/hello20160825-5853-rvjbcv?1472114572',\n
			      'file_id': 8,\n
			      'file_name': 'hello20160825-5853-rvjbcv.'\n
			    },\n
			    {\n
			      'owner_id': 1,\n
			      'owner_login': 'yuri',\n
			      'url': '/system/attachment_files/files/000/000/009/original/hello20160825-12659-1hnx7d6.jpeg?1472131725',\n
			      'file_id': 9,\n
			      'file_name': 'hello20160825-12659-1hnx7d6.jpeg'\n
			    }\n
			  ]\n
			}"
		end

		def get_file
			"{\n
			  'owner_profile': 'yuri',\n
			  'owner_profile_id': 1,\n
			  'file_id': 8,\n
			  'url': '/system/attachment_files/files/000/000/008/original/hello20160825-5853-rvjbcv?1472114572'\n
			}"
		end
	end
end