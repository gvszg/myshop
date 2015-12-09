module ProductsHelper
  def product_photo(photo, size = "thumb")    
    if photo.present?
      image_url = photo.image.send(size).url # Todo: fix size in show page
    else
      case size
      when :medium
        volume = "300x300"
      else
        volume = "200x200"
      end

      image_url = "http://placehold.it/#{volume}&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end
end
