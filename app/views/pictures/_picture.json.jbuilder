json.extract! picture, :id, :caption, :image, :created_at, :updated_at
json.url picture_url(picture, format: :json)
json.image url_for(picture.image)
