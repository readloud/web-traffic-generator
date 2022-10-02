MAX_DEPTH = 10  # maximum click depth
MIN_DEPTH = 3 # minimum click depth
MAX_WAIT = 10  # maximum amount of time to wait between HTTP requests
MIN_WAIT = 5  # minimum amount of time allowed between HTTP requests
DEBUG = False  # set to True to enable useful console output

# use this single item list to test how a site responds to this crawler
# be sure to comment out the list below it.
#ROOT_URLS = ["https:///digg.com/"]

ROOT_URLS = [
	"https://www.lazada.co.id/",
    "https://biggo.id/",
    "https://iprice.co.id/",
	"http://www.shopee.co.id/",
	"https://id.aliexpress.com/",
	"https://best.aliexpress.com/",
    "https://www.aliexpress.com/",
    "https://www.yahoo.com",
    "https://www.google.com",
	]


# items can be a URL "https://t.co" or simple string to check for "amazon"
blacklist = [
	"https://t.co", 
	"t.umblr.com", 
	"messenger.com", 
	"itunes.apple.com", 
	"l.facebook.com", 
	"bit.ly", 
	"mediawiki", 
	".css", 
	".ico", 
	".xml", 
	"intent/tweet", 
	"twitter.com/share", 
	"signup", 
	"login", 
	"dialog/feed?", 
	".png", 
	".jpg", 
	".json", 
	".svg", 
	".gif", 
	"zendesk",
	"clickserve"
	]  

# must use a valid user agent or sites will hate you
USER_AGENT = 'Mozilla/5.0 (Linux; Android 10; SM-A205U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.5195.136 Mobile Safari/537.36.' \
	'Mozilla/5.0 (Linux; Android 10; SM-A102U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.5195.136 Mobile Safari/537.36.'
