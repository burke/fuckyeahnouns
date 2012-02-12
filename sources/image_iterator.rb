module ImageIterator
  def enum
    @enum ||= @images.to_enum
  end

  def next
    Kernel.open(enum.next)
  end

  def rewind
    enum.rewind
  end
end
