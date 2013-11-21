Bitcoin_price_alert
===================

Bitcoin_price_alert searches for the current price of the bitcoin currency and sends an alert through email if it reaches the min_alert_value/max_alert_value. 

http://api.bitcoincharts.com/ is been used to gather data, Bitcoincharts ask not to query more often than 15 minutes, so if you schedule this script in crontab be aware of this.

Installing
----------
Use crontab or whatever you use to schedule jobs.

Usage
-----
```ruby
#bcoin = BitCoin.new(currency,min_alert_value, max_alert_value, [fav_sites])

#Initialize to search all sites
bcoin = BitCoin.new('EUR',100, 700)

#Initialize to search selected sites
bcoin = BitCoin.new('EUR',100,700,['mtgoxEUR','crytrEUR'])

#Start search
bcoin.current_value
```

Customization
------------
Currencies:
  ["ARS", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GAU", "GBP", "HKD", "HUF", "ILS", "INR", "JPY", "LTC", "MXN", "NOK", "NZD", "PLN", "RUB", "SEK", "SGD", "SLL", "THB", "UAH", "USD", "XRP", "ZAR"]    

Fav Sites (optional):

  ["localbtcARS", "bitmarketAUD", "btcmarketsAUD", "cryptoxAUD", "localbtcAUD", "mtgoxAUD", "ruxumAUD", "thAUD", "wbxAUD", "weexAUD", "bbmBRL", "localbtcBRL", "mrcdBRL", "localbtcCAD", "lybitCAD", "mtgoxCAD", "virtexCAD", "weexCAD", "localbtcCHF", "mtgoxCHF", "ruxumCHF", "thCLP", "anxhkCNY", "btcnCNY", "mtgoxCNY", "rmbtbCNY", "bitcashCZK", "localbtcCZK", "localbtcDKK", "mtgoxDKK", "aqoinEUR", "b7EUR", "bcEUR", "bitcurexEUR", "bitmarketEUR", "btc24EUR", "btcdeEUR", "btceEUR", "btcexEUR", "crytrEUR", "fbtcEUR", "globalEUR", "imcexEUR", "intrsngEUR", "justEUR", "localbtcEUR", "mtgoxEUR", "rippleEUR", "rockEUR", "ruxumEUR", "thEUR", "vcxEUR", "bcmBMGAU", "bcmPXGAU", "bcGBP", "bitmarketGBP", "britcoinGBP", "globalGBP", "intrsngGBP", "localbtcGBP", "mtgoxGBP", "ruxumGBP", "anxhkHKD", "btchkexHKD", "localbtcHKD", "mtgoxHKD", "ruxumHKD", "ruxumHUF", "bit2cILS", "localbtcILS", "localbtcINR", "thINR", "btcexJPY", "mtgoxJPY", "ruxumJPY", "bitmeLTC", "justLTC", "localbtcMXN", "justNOK", "localbtcNOK", "bitnzNZD", "localbtcNZD", "mtgoxNZD", "bidxtrmPLN", "bitchangePLN", "bitcurexPLN", "bitmarketPLN", "bitomatPLN", "freshPLN", "globalPLN", "intrsngPLN", "localbtcPLN", "mtgoxPLN", "ruxumPLN", "bitmarketRUB", "btceRUR", "btcexRUB", "btcexWMR", "btcexYAD", "localbtcRUB", "mtgoxRUB", "ruxumRUB", "fybseSEK", "kptnSEK", "localbtcSEK", "mtgoxSEK", "ruxumSEK", "fybsgSGD", "localbtcSGD", "mtgoxSGD", "ruxumSGD", "rockSLL", "virwoxSLL", "localbtcTHB", "mtgoxTHB", "ruxumTHB", "ruxumUAH", "anxhkUSD", "b2cUSD", "b7USD", "bcmBMUSD", "bcmLRUSD", "bcmMBUSD", "bcmPPUSD", "bitboxUSD", "bitfloorUSD", "bitkonanUSD", "bitmarketUSD", "bitmeUSD", "bitstampUSD", "btc24USD", "btceUSD", "btcexUSD", "btcexWMZ", "btctreeUSD", "cbxUSD", "cryptoxUSD", "crytrUSD", "exchbUSD", "fbtcUSD", "globalUSD", "icbitUSD", "imcexUSD", "intrsngUSD", "justUSD", "localbtcUSD", "lybitUSD", "mtgoxUSD", "rippleUSD", "rockUSD", "ruxumUSD", "thLRUSD", "thUSD", "vcxUSD", "weexUSD", "justXRP", "rippleXRP", "snwcnXRP", "bitxZAR", "localbtcZAR", "ruxumZAR"]


Contributing
------------
If you'd like to contribute, fork
the project at [github](https://github.com/alex-rodriguez/bitcoin_price_alert), make your changes, 
then send a pull request.

Contact
-------
Comments and feedback are welcome.

License
-------
This code is free to use under the terms of the MIT license.


