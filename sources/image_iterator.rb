module ImageIterator
  def enum
    @enum ||= @images.to_enum
  end

  def next
    begin
      image = Kernel.open(enum.next)
    end while not image.content_type =~ /image/
    image
  end

  def rewind
    enum.rewind
  end
end
