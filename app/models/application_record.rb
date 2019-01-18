class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #Memberモデルのprofile_picture属性にデータ形式に関するバリデーション
  ALLOWED_CONTENT_TYPES = %q{
    image/jpeg
    image/png
    image/gif
    image/bmp
  }
end
