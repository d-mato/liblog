module ExtendedStrip
  def deep_strip
    gsub(/^[　\s]*(.*?)[　\s]*$/, '\1')
  end
end

String.send(:prepend, ExtendedStrip)
