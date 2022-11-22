# BY HycodeTech
from urllib.request import urlopen
from bs4 import BeautifulSoup
from urllib.request import HTTPError
import time
import re
import socket
import socks
from stem import Signal
from stem.control import Controller
import random
from selenium import webdriver
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

 
traffic="your website"
traffic_no=50

full_url_arr=set()
title_arr=set()
title_app=set()
page_app=set()

def blog_data(urlfile,page):


	# prepare a cursor object using cursor() method
	link="your website"
	httplink=urlfile+page
	print(httplink+" 00")
	try:
		ntraffic=0
		scrap=0
		rdnum=random.randint(40,300)
		time.sleep(rdnum)
		htmlfile=urlopen(httplink)
		print(httplink+" 01")
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")
		# print(httplink+" 02")
		#url and text collection
		rdtraffic=random.randint(1,3)
		for sibling in htmltext.find_all("p","article_title"):		

			inner_url=sibling.a['href']
			
			# print(inner_url+" 1")
			if inner_url:
				title=""
				
				# print(inner_url+" 2")
				if inner_url:
					# print(inner_url)
					httplink=link+"/"+inner_url
					
					if inner_url:
						print(httplink+" 1")		
						# title=htmltext.p.previous_element
						try:
							
							rdnum=random.randint(50,300)
							time.sleep(rdnum)
							html_inner=urlopen(httplink)
							print(httplink)
							html_inner_text=BeautifulSoup(html_inner.read(),"lxml")

							title=html_inner_text.find("div",class_="single_page_area").h1.text
							rdnum=random.randint(50,300)
							time.sleep(rdnum)
							
							
							#selenium(httplink)							
							# time.sleep(10)
							# sumary_arr.find('div').name='p'
							# print(title)
							ntraffic=ntraffic+1
							print(ntraffic)
							print(rdtraffic)
							if ntraffic==rdtraffic:
								break
							
						except:
							continue
						# title=""
						sumary=""
						# for tit in title_arr:
						# 	title=title+str(tit)
						
						title=title.strip()
						
						if len(title_app)==0:
							title_app.add(title)
						elif title in title_app:
							title_app.add(title)
							continue
			
		nextPage=htmltext.find("li","nextPage").a['href']
		nextPage="your website/index.php"+nextPage
		if len(page_app)==0:
			page_app.add(nextPage)
			print(nextPage)
			#blog_data(nextPage,"")
		elif nextPage not in page_app:
			page_app.add(nextPage)
			print(nextPage)
			#blog_data(nextPage,"")
		else:
			print("End of Page")
			print("Start Another")
		
		
		#db.close()
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()



def anDch():
	controller.signal(Signal.NEWNYM)
	socks.set_default_proxy(socks.SOCKS5,"localhost",9150)
	socket.socket=socks.socksocket
	print(urlopen('http://icanhazip.com').read())
	# htmlfile1=urlopen('https://whatismyipaddress.com/')
	# htmltext1=BeautifulSoup(htmlfile1.read(),"lxml")
	# print("0")
	# for e in htmltext1.find_all('a'):
	# 	lik=e.a['href']
	# 	if "//whatismyipaddress.com/ip/" in lik:
	# 		ipAdd=lik.split('/')
	# 		ipAdd=ipAdd[len(ipAdd)-1]
	# 		break
	# print(ipAdd)
	blog_data(traffic,"")

# for i in range(1,50):

try:
	with Controller.from_port(port = 9151) as controller:
		controller.authenticate()
		for x in range(traffic_no):
		        anDch()
except:
	print("error")
#		continue


# blog_data(traffic,"")






def selenium(site):
	service_args = [ '--proxy=localhost:9150', '--proxy-type=socks5', ]

	driver = webdriver.PhantomJS(executable_path='C:/Python/work/phantomjs/bin/phantomjs',service_args=service_args)
	driver.get(site)
	try:
		element = WebDriverWait(driver, 10).until(
			EC.presence_of_element_located((By.ID, "SC_TBlock_424845_Table")))
	finally:
		pageSource = driver.page_source
		bsObj = BeautifulSoup(pageSource,"lxml")
		#print(bsObj)
		# bsObj.find("td","SC_TBlock_424845_Table")
		for sibling in bsObj.find_all("td",class_="SC_TBlock_424845_td"):
			#sibling.click()
			print(sibling.table.tbody.tr.td.a['href'])
		# exo=bsObj.find("noscript").a['href']
		# print(exo)
		a=[]
		a=driver.find_elements_by_class_name("SC_TBlock_424845_td")
		rdCLick=random.randint(0,3)
		# for lt in a:
		# 	lt.click()
		rdclcSet=set()
		for lt in range(rdCLick):	
			rdclc=random.randint(0,rdCLick)
			if rdclc in rdclcSet:
				continue
			else:
				rdclcSet.add(rdclc) 
			time.sleep(random.randint(40,100))
			a[rdclc].click()
		rdclcSet.clear()
		count=0
		while True:
			count+=1
			if count>20:
				break
			time.sleep(.5)
		print("done")
		# for lt in range(rdCLick):
		# 	a[lt].click()
		# driver.find_element_by_xpath("//table[@id='SC_TBlock_424845_Table']/tbody/tr/td/table/tbody/tr/td/a").text
		#driver.find_element_by_xpath("//td[@class='SC_TBlock_424845_td']/table/tbody/tr/td/a").text
		driver.close()

