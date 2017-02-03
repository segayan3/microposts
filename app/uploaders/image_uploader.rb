class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  
  # 画像の条件を700pxにする
  process :resize_to_limit => [700, 700]
  
  # 保存形式をjpgにする
  process :convert => 'jpg'
  
  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file
  end
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # jpg, jpeg, gif, pngしか受け付けない
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # ファイル名に日本語を入れないようにファイル名を変更
  def filename
    time = Time.now
    name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
    name.downcase
  end
  
  def public_id
    model.id
  end

end
