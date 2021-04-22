require 'nokogiri' 
require 'open-uri'
require 'rubocop'
require 'pry'
require 'rspec'


page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))   

####################### on récupère les url de chaque page 

def get_townhall_url(page)
  url_array =page.xpath('//*[@class="lientxt"]').map {|town| town="https://www.annuaire-des-mairies.com/95/#{town.text.downcase.tr(' ',"-")}.html"}
end


################### on fait un tableau, et on passe chaque url en revue pour obtenir l'email

def get_townhall_email(url_array)
  email_array=[]
  url_array.map do |url|
    page = Nokogiri::HTML(URI.open("#{url}"))
    email_array<< page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts "Veuillez patienter chargement en cours ........"
    puts "Veuillez patienter chargement en cours ......."
    puts "Veuillez patienter chargement en cours ......"
  end
  return email_array
end

############################## on récupère le nom de la mairie


def get_townhall_name(page)
  name_array =page.xpath('//*[@class="lientxt"]').map {|name| name.text}
end


############################# on associe la mairie avec l'email

def array_hash_town_mail(name_array, email_array)
  new_array=[]
  name_array.size.times {|i| new_array<<Hash[name_array[i],email_array[i]]}
  puts new_array
end


url_array= get_townhall_url(page)
name_array= get_townhall_name(page)
email_array= get_townhall_email(url_array)
array_hash_town_mail(name_array, email_array)

