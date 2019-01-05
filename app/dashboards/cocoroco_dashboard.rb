require "administrate/base_dashboard"

class CocorocoDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    content: Field::Text,
    author: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    profile_image_url: Field::String,
    attached_image_url: AttachedImageField,
    last_tweeted_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :content,
    :attached_image_url,
    :author,
    :last_tweeted_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :content,
    :author,
    :created_at,
    :updated_at,
    :profile_image_url,
    :attached_image_url,
    :last_tweeted_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :content,
    :author
    #:profile_image_url,
    #:attached_image_url,
  ].freeze

  # Overwrite this method to customize how cocorocos are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(cocoroco)
  #   "Cocoroco ##{cocoroco.id}"
  # end
end
