class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def image?
    %w(jpg png jpg gif bmp).include?(file.extension)
  end

end
