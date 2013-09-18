module ReportsHelper
  
  def file_format_icon(file_format)
    case file_format
    when 'xls'
      'icon-file-excel'
    when 'pdf'
      'icon-file-pdf'
    end
  end
  
  def frequency_formatted(interval)
    case interval
      when 1
        'Daily'
      when 7
        'Weekly'
    end
  end
  
end
