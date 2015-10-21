require 'net/http'
require 'json'
require 'net/smtp'
require 'mail'

class BitCoin
  attr_accessor :currency, :min_alert_value, :max_alert_value, :fav_sites

  def initialize(currency, min_alert_value, max_alert_value, fav_sites=[])
    self.currency = currency
    self.min_alert_value = min_alert_value
    self.max_alert_value = max_alert_value
    self.fav_sites = fav_sites
  end

  def current_value
    uri = URI.parse("http://api.bitcoincharts.com/v1/markets.json")
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    filtered_results = {}

    result.each do |data|
      if self.fav_sites.any?
	  filtered_results[data['symbol']]=data['close'] if (fav_sites.include?(data['symbol']) && data['currency'] == self.currency && !(data['bid'].nil? || data['avg'].nil?))
      else
    	  filtered_results[data['symbol']]=data['close'] if (data['currency'] == self.currency && !(data['bid'].nil? || data['avg'].nil?))
      end
    end

    min_result = filtered_results.min_by{ |x,y| y}
    max_result = filtered_results.max_by{ |x,y| y}

    if min_result[1] <=  self.min_alert_value
      body_text =  "Your min price has been reached! -- Site: #{min_result[0].to_s} -- Price: #{min_result[1].to_s} ( #{self.currency} )"
      send_email(body_text)
    end
    if max_result[1] >=  self.max_alert_value
      body_text =  "Your max price has been reached! -- Site: #{max_result[0].to_s} -- Price: #{max_result[1].to_s} ( #{self.currency} )"
      send_email(body_text)
    end
  rescue => e
    puts "An error has occurred: #{e.message}"
  end

  private
  def send_email(body_text)
      # Email server config
  	options = {
        :address => "smtp.gmail.com",
        :port => 587,
        :user_name => 'your.email@gmail.com',
        :password => 'password',
        :authentication => 'plain',
        :enable_starttls_auto => true  }

  	Mail.defaults do
  	  delivery_method :smtp, options
  	end

      # Email target
  	Mail.deliver do
  	  to 'your.email@gmail.com'
  	  from 'bitcoin@fake-email.net'
  	  subject 'Bitcoin price alert'
  	  body body_text
  	end
  end
end

# Currencies
# ["ARS", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GAU", "GBP", "HKD", "HUF", "ILS", "INR", "JPY", "LTC", "MXN", "NOK", "NZD", "PLN", "RUB", "SEK", "SGD", "SLL", "THB", "UAH", "USD", "XRP", "ZAR"]

# Fav Sites =>  Searches only in those sites
# ["localbtcARS", "bitmarketAUD", "btcmarketsAUD", "cryptoxAUD", "localbtcAUD", "mtgoxAUD", "ruxumAUD", "thAUD", "wbxAUD", "weexAUD", "bbmBRL", "localbtcBRL", "mrcdBRL", "localbtcCAD", "lybitCAD", "mtgoxCAD", "virtexCAD", "weexCAD", "localbtcCHF", "mtgoxCHF", "ruxumCHF", "thCLP", "anxhkCNY", "btcnCNY", "mtgoxCNY", "rmbtbCNY", "bitcashCZK", "localbtcCZK", "localbtcDKK", "mtgoxDKK", "aqoinEUR", "b7EUR", "bcEUR", "bitcurexEUR", "bitmarketEUR", "btc24EUR", "btcdeEUR", "btceEUR", "btcexEUR", "crytrEUR", "fbtcEUR", "globalEUR", "imcexEUR", "intrsngEUR", "justEUR", "localbtcEUR", "mtgoxEUR", "rippleEUR", "rockEUR", "ruxumEUR", "thEUR", "vcxEUR", "bcmBMGAU", "bcmPXGAU", "bcGBP", "bitmarketGBP", "britcoinGBP", "globalGBP", "intrsngGBP", "localbtcGBP", "mtgoxGBP", "ruxumGBP", "anxhkHKD", "btchkexHKD", "localbtcHKD", "mtgoxHKD", "ruxumHKD", "ruxumHUF", "bit2cILS", "localbtcILS", "localbtcINR", "thINR", "btcexJPY", "mtgoxJPY", "ruxumJPY", "bitmeLTC", "justLTC", "localbtcMXN", "justNOK", "localbtcNOK", "bitnzNZD", "localbtcNZD", "mtgoxNZD", "bidxtrmPLN", "bitchangePLN", "bitcurexPLN", "bitmarketPLN", "bitomatPLN", "freshPLN", "globalPLN", "intrsngPLN", "localbtcPLN", "mtgoxPLN", "ruxumPLN", "bitmarketRUB", "btceRUR", "btcexRUB", "btcexWMR", "btcexYAD", "localbtcRUB", "mtgoxRUB", "ruxumRUB", "fybseSEK", "kptnSEK", "localbtcSEK", "mtgoxSEK", "ruxumSEK", "fybsgSGD", "localbtcSGD", "mtgoxSGD", "ruxumSGD", "rockSLL", "virwoxSLL", "localbtcTHB", "mtgoxTHB", "ruxumTHB", "ruxumUAH", "anxhkUSD", "b2cUSD", "b7USD", "bcmBMUSD", "bcmLRUSD", "bcmMBUSD", "bcmPPUSD", "bitboxUSD", "bitfloorUSD", "bitkonanUSD", "bitmarketUSD", "bitmeUSD", "bitstampUSD", "btc24USD", "btceUSD", "btcexUSD", "btcexWMZ", "btctreeUSD", "cbxUSD", "cryptoxUSD", "crytrUSD", "exchbUSD", "fbtcUSD", "globalUSD", "icbitUSD", "imcexUSD", "intrsngUSD", "justUSD", "localbtcUSD", "lybitUSD", "mtgoxUSD", "rippleUSD", "rockUSD", "ruxumUSD", "thLRUSD", "thUSD", "vcxUSD", "weexUSD", "justXRP", "rippleXRP", "snwcnXRP", "bitxZAR", "localbtcZAR", "ruxumZAR"]

# Usage
# bcoin = BitCoin.new('EUR',minvalue,maxvalue,['favsite1','favsite2'])
# bcoin = BitCoin.new('EUR',100,700,['mtgoxEUR','crytrEUR'])

bcoin = BitCoin.new('EUR',100, 700)
bcoin.current_value

