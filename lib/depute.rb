require 'rubocop'
require 'pry'
require 'rspec'
require 'nokogiri' 
require 'open-uri'

################# site assemblée national

page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))   


################# je récupère toute la liste
def get_depute_name(page)
  array_name = page.xpath('//*[@id="deputes-list"]/div/ul/li/a').map {|name| name.text}
end


################# je récupère le prénom
def get_depute_first_name(array_name)
  array_first_name=[]
  array_name.each {|name| array_first_name<<name.split[1]}
  return array_first_name
end


################# je récupère le nom
def get_depute_last_name(array_name)
  array_last_name=[]
  array_name.each {|name| array_last_name<<name.split[2..name.size].join(" ")}
  return array_last_name
end


################# je récupère url du lien 
def get_mail_url(page)
  array_url = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
  numb_url = array_url.map {|url| url.to_s.split('OMC_PA').last.split('>').first[0...-1]}
  return array_url_mail = numb_url.map {|numb| numb="https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA#{numb}"}
end


################# je récupère l'email
def get_email(array_url_mail)
  email_array=[]
  puts "Veuillez patienter svp je suis lente de réaction !"
  array_url_mail.map do |url|
    page = Nokogiri::HTML(URI.open(url))
    email_array<<page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  end
  return email_array
end


################# je fais un tableau général
def array_hash_depute(email_array, array_first_name, array_last_name)
  array_depute=[]
  array_first_name.size.times do |i|
    array_depute << hash = {
      "first_name" => array_first_name[i],
      "last_name"  => array_last_name[i],
      "email"      => email_array[i]}
  end
  return puts array_depute
end


################# je nomme mes variables
array_url_mail = get_mail_url(page)
email_array = get_email(array_url_mail)
array_name = get_depute_name(page)
array_first_name = get_depute_first_name(array_name)
array_last_name = get_depute_last_name(array_name)


array_hash_depute(email_array, array_first_name, array_last_name)





