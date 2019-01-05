require "administrate/field/base"

class AttachedImageField < Administrate::Field::Base
  def to_s
    data
  end
end
