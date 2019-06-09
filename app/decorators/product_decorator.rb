class ProductDecorator < Draper::Decorator
  delegate_all

  %i[model brand os nfc cpu gpu colors chipset].each do |column|
    define_method column do
      if object[column].blank?
        'Not present'
      else
        object[column].humanize.titleize
      end
    end
  end
end
