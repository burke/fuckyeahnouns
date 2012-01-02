class Actions::Shirt
  def create(noun)
    url = "http://open-api.cafepress.com/authentication.getUserToken.cp?v=3&appKey=#{ENV['CAFEPRESS_KEY']}&email=#{ENV['CAFEPRESS_EMAIL']}&password=#{ENV['CAFEPRESS_PASSWORD']}"
    key = open(url).read.scan(/<value>(.*)<\/value>/).flatten.first

    data = FuckYeahNouns.fuck_noun(noun, true)

    tmppath="tmp/#{rand 10000000}"
    File.open(tmppath, 'wb') { |f| f.write data }

    puts key
    hash = {
      :cpFile1 => File.new(tmppath),
      # :cpFile2 => nil,
      :appKey => ENV['CAFEPRESS_KEY'],
      :userToken => key,
      :folder => "Images"
    }
    action = "http://upload.cafepress.com/image.upload.cp"
    x = RestClient.post action, hash.merge(:multipart => true)
    File.unlink(tmppath)

    imgref = x.scan(/<value>(.*)<\/value>/).flatten.first

    # "http://open-api.cafepress.com/merchandise.list.cp?v=3&appKey=#{ENV['CAFEPRESS_KEY']}"
    # merch_id=2
    # url = "http://open-api.cafepress.com/product.create.cp?v=3&appKey=#{ENV['CAFEPRESS_KEY']}&merchandiseId=#{merch_id}&fieldTypes=optional"

    xml = <<-XML
    <?xml version="1.0"?>
    <product id="0" storeId="fuckyeahnouns" name="FUCK YEAH #{noun}" merchandiseId="2" sellPrice="19.99" description="FUCK YEAH #{params[:noun]}!" sectionId="7732546">
      <mediaConfiguration height="10" name="FrontCenter" designId="#{imgref}" />
    </product>
    XML
    xml.sub!(/^\s*/,'')

    url = "http://open-api.cafepress.com/product.save.cp?v=3&appKey=#{ENV['CAFEPRESS_KEY']}&userToken=#{key}&value=#{CGI.escape xml}"

    z = RestClient.get(url)

    pid = z.scan(/<product id=\"(\d+)\"/).flatten.first

    Struct.new(:pid).new(pid)
  end
en
