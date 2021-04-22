require 'rubocop'
require 'pry'
require 'rspec'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")) 

# Je crée un array dans lequel je vais chercher toutes les class je les mets dans un tableau et je ressors que le texte ce qui me donne la variable name 
def array_crypto_name(page)
    array_name = page.xpath('//tbody/tr/td[3]//*[@class=""]').map {|name| name.text}
  end 

# Je crée un array dans lequel je vais chercher les valeurs je les intègre dans un tableau et je ressors seulement le texte dans lequel je supprime $ et le remplace par rien  
  def array_crypto_value(page)
    array_value = page.xpath('//tbody/tr/td[5]/div//a[@class="cmc-link"]').map {|item| item.text.tr('$','')}
  end

# Je crée un nouveau tableau genéral 
# je prend la position 
def array_hash(array_name, array_value)
    new_array=[]
    array_name.size.times do |i|
    hash=Hash[array_name[i],array_value[i]]
    new_array<<hash
    end
    puts new_array.inspect
end
    

array_name = array_crypto_name(page)
array_value = array_crypto_value(page)
array_hash(array_name, array_value)

    
  



