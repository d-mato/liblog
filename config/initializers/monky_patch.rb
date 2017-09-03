module ExtendedStrip
  def strip
    gsub(/^[　\s]*(.*?)[　\s]*$/, '\1')
  end
end

String.send(:prepend, ExtendedStrip)
