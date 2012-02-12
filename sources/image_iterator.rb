class ImageIterator
  def initialize(urls=[])
    @urls = urls
    @enum = @urls.to_enum
  end

  def next
    Kernel.open(@enum.next)
  end

  def rewind
    @enum.rewind
  end
end
