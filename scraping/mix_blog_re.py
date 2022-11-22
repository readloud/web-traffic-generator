from urllib.request import urlopen
from bs4 import BeautifulSoup
from urllib.request import HTTPError
import MySQLdb
import re
from datetime import date
import math
import socket
import socks
from stem import Signal
from stem.control import Controller
 
zdnet_smart="http://www.zdnet.com/topic/smart-cities/5"
zdnet_win="http://www.zdnet.com/topic/windows-10/5"
zdnet_inn="http://www.zdnet.com/topic/innovation/5"
zdnet_secure="http://www.zdnet.com/topic/security/5"
tinybud="https://tinybuddha.com/"
firstpage=""
#urlfile="http://www.zdnet.com"
zdnet="http://www.zdnet.com"

applied="http://appliedneuroscienceblog.com/"

bbc_science="http://www.bbc.com/news/science_and_environment"
bbc_tech="http://www.bbc.com/news/technology"
bbc_business="http://www.bbc.com/news/business"
bbc_world="http://www.bbc.com/news/world"
firstpage="index.html"
#urlfile="http://www.zdnet.com"
bbc="http://www.bbc.com/news/"

bplan="http://articles.bplans.com/"

hbr_org="https://www.hbr.org"

peace="http://blog.peacerevolution.net/"

possible="https://possibilitychange.com/"


skysports="http://www.skysports.com/la-liga-news"
trend="http://www.skysports.com/"

smile="http://www.kipsmiling.com/"

thinksimplenow="http://thinksimplenow.com/"


trd=0
bginc=0
# Open database connection
# storing your scraped info into a database, using mysql
db = MySQLdb.connect("your website","username","password","database")

full_url_arr=set()
title_arr=set()
title_app=set()


def htmlspecialchars(text):
    return (
        text.replace("<div","<p").
        replace("</div","</p").
        replace("&", "&amp;").
        replace('"', "&quot;").
        replace("<", "&lt;").
        replace(">", "&gt;")
    )


def anDch():
	controller.signal(Signal.NEWNYM)
	socks.set_default_proxy(socks.SOCKS5,"localhost",9150)
	socket.socket=socks.socksocket


def blog_data_zdnet(urlfile,page,url_site):


	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		scrap=0
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		
		for e in ret_href:
			anDch()
			sttr=e.text.strip()
			
			if e.get('href'):
				inner_url=e.get('href')
				title=""
				
				if "article/" in inner_url:
					if "Read more" not in sttr:
						
						try:
							img_sumary=thumb=e.span.img['src'].strip()
							if not thumb:
								img_sumary=thumb=e.figure.span.img['data-origina'].strip()
						except:
							continue			
						# title=htmltext.p.previous_element
						try:
							
							html_inner=urlopen(zdnet+inner_url)
							html_inner_text=BeautifulSoup(html_inner.read(),"lxml")

							sumary_arr=html_inner_text.find("div",class_="storyBody").contents

							title=html_inner_text.find("header",class_="storyHeader").h1.text
							# sumary_arr.find('div').name='p'

							if scrap>=5:
								break
							scrap=scrap+1
						except:
							continue
						# title=""
						sumary=""
						# for tit in title_arr:
						# 	title=title+str(tit)
						for sumr in sumary_arr:
							
							# if re.match('<p',str(sumr)) or re.match('<a',str(sumr)) or re.match('<figure',str(sumr)) or re.match('<img',str(sumr)):
								
						#	if re.match('<img',str(sumr)):
						#		sumr['max-width']=200
						#		sumr['height']=200
							sumary=sumary+str(sumr)
						#	else:
						#		continue
							# print(sumr)
							# print(sumary)

						# sumary=BeautifulSoup(sumary,"lxml")						
						
						# Prepare SQL query to INSERT a record into the database.
						title=title.strip()
						exist=exist_blog_data(inner_url)
						if exist>0:
							print("Exist")
							continue
						else:
							try:

								file_name=inner_url.split("/")
								file_name=file_name[len(file_name)-2]
								
								insert_blog_data(1,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
								
								# print(htmlspecialchars(sumary))
							except:								
								continue
						
							# try:
							
							# 	file.write(sumary.strip())
							# 	file.close()
							# except:
							# 	file.close()						

						if len(title_app)==0:
							title_app.add(title)
						elif title in title_app:
							title_app.add(title)
							continue
					else:
						rm_url=inner_url
						rm_text=sttr
						print("Read Url: ",rm_url)
				
		#db.close()
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_tinybuddha(urlfile,page,btype,url_site):

	tinybud="https://tinybuddha.com/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		scrap=0
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		for sibling in htmltext.find_all("ul","posts"):
			anDch()
			inner_url=sibling.li.a['href']
			title=sibling.li.a.span.text
			thumb=""
			try:
				if "http://" not in inner_url or "https://" not in inner_url:
					inner_url=urlfile+inner_url
				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("div","single-content").contents
				img_sumary=html_inner_text.find("div","single-content").p.img['src']
				#print(inner_url)
				if scrap>=5:
					break
				scrap=scrap+1
			except:
				continue

			# for tit in title_arr:
			# 	title=title+str(tit)
			sumary=""
			for sumr in sumary_arr:
				
			#	if sumr.text:
			#		if re.match('<img',str(sumr)):
			#			sumr['max-width']=200
			#			sumr['height']=200
				sumary=sumary+str(sumr)
			#	else:
			#		continue
				# print(sumr)
				# print(sumary)

			# sumary=BeautifulSoup(sumary,"lxml")						
						
			# Prepare SQL query to INSERT a record into the database.
			title=title.strip()
			exist=exist_blog_data(inner_url)
			if exist>0:
				print("exist")
				continue
			else:
				try:
					file_name=inner_url.split("/")
					file_name=file_name[len(file_name)-2]
					
					insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
				except:								
					continue

				# if btype==1:
				# 	folder_name="http://blog.peeraid.com.ng/Tech"
				# elif btype==2:
				# 	folder_name="http://blog.peeraid.com.ng/Sport/"
				# elif btype==3:
				# 	folder_name="http://blog.peeraid.com.ng/Business/"
				# elif btype==4:
				# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
				# elif btype==5:
				# 	folder_name="http://blog.peeraid.com.ng/Problems/"
				# elif btype==6:
				# 	folder_name="http://blog.peeraid.com.ng/Trending"
				# elif btype==7:
				# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
				# elif btype==8:
				# 	folder_name="http://blog.peeraid.com.ng/Research/"
				# elif btype==9:
				# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
				# elif btype==10:
				# 	folder_name="http://blog.peeraid.com.ng/Comics/"
				# elif btype==11:
				# 	folder_name="http://blog.peeraid.com.ng/Games/"
				# elif btype==12:
				# 	folder_name="http://blog.peeraid.com.ng/General/"

											
				# try:
				# 	file=open(folder_name+file_name,'w')
				# 	file.write(sumary.strip())
				# 	file.close()
				# except:
				# 	file.close()						

			if len(title_app)==0:
				title_app.add(title)
			elif title in title_app:
				title_app.add(title)
				continue
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_applied(urlfile,page,btype,url_site):
	all_subclasses = []
	applied="http://appliedneuroscienceblog.com/"
	
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	bginc=0
	scrap=0
	try:
		bginc=bginc+1
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")
		for sibling in htmltext.find_all("div","entry-content"):
			anDch()
			title=sibling.header.h2.a.text
			inner_url=sibling.header.h2.a['href']
			try:
				if "http://" not in inner_url:
					inner_url=urlfile+inner_url
				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("div","entry-content-wrapper").contents
				thumb=img_sumary=html_inner_text.find("div","entry-content-wrapper").p.a.img['src']
				if scrap>=5:
					break
				scrap=scrap+1
				#print(inner_url)
			except:
				continue
			# if(bginc>=5):
			# 	break
			sumary=""
			

						
			# for tit in title_arr:
			# 	title=title+str(tit)
			for sumr in sumary_arr:
			
			# if re.match('<p',str(sumr)) or re.match('<a',str(sumr))  or re.match('<img',str(sumr)):
			#	if re.match('<img',str(sumr)):
			#		sumr['max-width']=200
			#		sumr['height']=200
				sumary=sumary+str(sumr)
			#	else:
					
			#		continue
					# print(sumr)
					# print(sumary)

				# sumary=BeautifulSoup(sumary,"lxml")						
						
				# Prepare SQL query to INSERT a record into the database.
				title=title.strip()
				exist=exist_blog_data(inner_url)
				if exist>0:
					print("Exist")					
					continue
				else:
					try:
						file_name=inner_url.split("/")
						file_name=file_name[len(file_name)-1]
						
						insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
					except:								
						continue

					# if btype==1:
					# 	folder_name="http://blog.peeraid.com.ng/Tech"
					# elif btype==2:
					# 	folder_name="http://blog.peeraid.com.ng/Sport/"
					# elif btype==3:
					# 	folder_name="http://blog.peeraid.com.ng/Business/"
					# elif btype==4:
					# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
					# elif btype==5:
					# 	folder_name="http://blog.peeraid.com.ng/Problems/"
					# elif btype==6:
					# 	folder_name="http://blog.peeraid.com.ng/Trending"
					# elif btype==7:
					# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
					# elif btype==8:
					# 	folder_name="http://blog.peeraid.com.ng/Research/"
					# elif btype==9:
					# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
					# elif btype==10:
					# 	folder_name="http://blog.peeraid.com.ng/Comics/"
					# elif btype==11:
					# 	folder_name="http://blog.peeraid.com.ng/Games/"
					# elif btype==12:
					# 	folder_name="http://blog.peeraid.com.ng/General/"
											
					# try:
					# 	file=open(folder_name+file_name,'w')
					# 	file.write(sumary.strip())
					# 	file.close()
					# except:
					# 	file.close()						

				if len(title_app)==0:
					title_app.add(title)
				elif title in title_app:
					title_app.add(title)
					continue
					
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_bbc(urlfile,page,btype,strtype,url_site):

	bbc="http://www.bbc.com"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		scrap=0
		for e in ret_href:
			anDch()
			sttr=e.text.strip()
			
			if e.get('href'):
				inner_url=e.get('href')
				title=""
				
				if strtype in inner_url:
					if "Read more" not in sttr:
						
						try:
							img_sumary=thumb=e.span.img['src'].strip()
							if not thumb:
								img_sumary=thumb=e.figure.span.img['data-origina'].strip()
						except:
							continue			
						# title=htmltext.p.previous_element
						try:

							html_inner=urlopen(bbc+inner_url)
							html_inner_text=BeautifulSoup(html_inner.read(),"lxml")

							sumary_arr=html_inner_text.find("div",class_="storyBody").contents

							title=html_inner_text.find("header",class_="storyHeader").h1.text
							#print(inner_url)
							if scrap>=5:
								break
							scrap=scrap+1
						except:
							continue
						# title=""
						sumary=""

						
						# for tit in title_arr:
						# 	title=title+str(tit)
						for sumr in sumary_arr:						
						# if re.match('<p',str(sumr)) or re.match('<a',str(sumr) or re.match('<figure',sumr)) or re.match('<em',str(sumr))or re.match('<b',str(sumr)) or re.match('<img',str(sumr)):
						#	if re.match('<img',str(sumr)):
						#		sumr['max-width']=200
						#		sumr['height']=200
							sumary=sumary+str(sumr)
						#	else:
						#		continue
							# print(sumr)
							# print(sumary)

						# sumary=BeautifulSoup(sumary,"lxml")						
						
						# Prepare SQL query to INSERT a record into the database.
						title=title.strip()
						exist=exist_blog_data(inner_url)
						if exist>0:
							print("Exist")
							continue
						else:
							try:
								file_name=inner_url.split("/")
								file_name=file_name[len(file_name)-2]
								
								insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
							except:								
								continue

							# if btype==1:
							# 	folder_name="http://blog.peeraid.com.ng/Tech"
							# elif btype==2:
							# 	folder_name="http://blog.peeraid.com.ng/Sport/"
							# elif btype==3:
							# 	folder_name="http://blog.peeraid.com.ng/Business/"
							# elif btype==4:
							# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
							# elif btype==5:
							# 	folder_name="http://blog.peeraid.com.ng/Problems/"
							# elif btype==6:
							# 	folder_name="http://blog.peeraid.com.ng/Trending"
							# elif btype==7:
							# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
							# elif btype==8:
							# 	folder_name="http://blog.peeraid.com.ng/Research/"
							# elif btype==9:
							# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
							# elif btype==10:
							# 	folder_name="http://blog.peeraid.com.ng/Comics/"
							# elif btype==11:
							# 	folder_name="http://blog.peeraid.com.ng/Games/"
							# elif btype==12:
							# 	folder_name="http://blog.peeraid.com.ng/General/"

													
							# try:
							# 	file=open(folder_name+file_name,'w')
							# 	file.write(sumary.strip())
							# 	file.close()
							# except:
							# 	file.close()						

						if len(title_app)==0:
							title_app.add(title)
						elif title in title_app:
							title_app.add(title)
							continue
					else:
						rm_url=inner_url
						rm_text=sttr
						print("Read Url: ",rm_url)
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_bplan(urlfile,page,btype,url_site):
	all_subclasses = []
	bplan="http://articles.bplans.com/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	scrap=0
	try:
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")
		for sibling in htmltext.find_all("div","article"):
			anDch()
			try:
				thumb=sibling.a.img['src']
				title=sibling.h2.text
				inner_url=sibling.a['href']
			except:
				continue
			if inner_url:
				try:
					#inner_url=inner_url.replace(bplan,"")
					html_inner=urlopen(inner_url)
					html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
					sumary_arr=html_inner_text.find("div",class_="articleBody").contents
					img_sumary=html_inner_text.find("div",class_="articleBody").p.img['src']
					#print(inner_url)
					if scrap>=5:
						break
					scrap=scrap+1
				except:
					continue
				sumary=""					
						
				# for tit in title_arr:
				# 	title=title+str(tit)
				for sumr in sumary_arr:
					
					#if re.match('<p',str(sumr)) or re.match('<a',str(sumr))  or re.match('<img',str(sumr)):
					#	if re.match('<img',str(sumr)):
					#		sumr['max-width']=200
					#		sumr['height']=200
					sumary=sumary+str(sumr)
					#else:
					#	continue
					# print(sumr)
					# print(sumary)
					# sumary=BeautifulSoup(sumary,"lxml")						
				
				# Prepare SQL query to INSERT a record into the database.
				title=title.strip()
				exist=exist_blog_data(inner_url)
				if exist>0:
					print("Exist")
					continue
				else:
					try:
						file_name=inner_url.split("/")
						file_name=file_name[len(file_name)-2]
						
						insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
					except:								
						continue

					# if btype==1:
					# 	folder_name="http://blog.peeraid.com.ng/Tech"
					# elif btype==2:
					# 	folder_name="http://blog.peeraid.com.ng/Sport/"
					# elif btype==3:
					# 	folder_name="http://blog.peeraid.com.ng/Business/"
					# elif btype==4:
					# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
					# elif btype==5:
					# 	folder_name="http://blog.peeraid.com.ng/Problems/"
					# elif btype==6:
					# 	folder_name="http://blog.peeraid.com.ng/Trending"
					# elif btype==7:
					# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
					# elif btype==8:
					# 	folder_name="http://blog.peeraid.com.ng/Research/"
					# elif btype==9:
					# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
					# elif btype==10:
					# 	folder_name="http://blog.peeraid.com.ng/Comics/"
					# elif btype==11:
					# 	folder_name="http://blog.peeraid.com.ng/Games/"
					# elif btype==12:
					# 	folder_name="http://blog.peeraid.com.ng/General/"
													
					# try:
					# 	file=open(folder_name+file_name,'w')
					# 	file.write(sumary.strip())
					# 	file.close()
					# except:
					# 	file.close()						

				if len(title_app)==0:
					title_app.add(title)
				elif title in title_app:
					title_app.add(title)
					continue
			else:
				rm_url=inner_url
				rm_text=sttr
				print("Read Url: ",rm_url)
		
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_hbr_org(urlfile,page,btype,strtype,url_site):

	hbr="http://www.hbr.org"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		aincr=0
		scrap=0
		for e in ret_href:
			anDch()
			sttr=e.text.strip()
			
			if e.get('href'):
				try:
					thumb=e.img['src'].strip()
				except:
					continue
				inner_url=e.get('href')
				title=""
				
				if strtype in inner_url:
					if "Read more" not in sttr:
						
						try:
							#thumb=htmltext.find("div",class_="stream-image").figure.a.img['src']
							#thumb=e.span.img['src'].strip()
							#if not thumb:
							thumb=e.img['src'].strip()
						except:
							continue			
						# title=htmltext.p.previous_element
						try:

							html_inner=urlopen(hbr+inner_url)
							html_inner_text=BeautifulSoup(html_inner.read(),"lxml")

							sumary_arr=html_inner_text.find("div",class_="article-first-row").contents
							img_sumary=html_inner_text.find("div",class_="article-first-row").div.img['src']

							title=html_inner_text.find("h1",class_="article-hed").text
							#print(inner_url)
							if scrap>=5:
								break
							scrap=scrap+1
						except:
							continue
						# title=""
						sumary=""
						aincr=+1

						
						# for tit in title_arr:
						# 	title=title+str(tit)
						for sumr in sumary_arr:
							
							#if re.match('<p',str(sumr)) or re.match('<a',str(sumr))  or re.match('<img',str(sumr)):
								#if re.match('<img',str(sumr)):
									#sumr['max-width']=200
									#sumr['height']=200
							sumary=sumary+str(sumr)
						#	else:
						#		continue
							# print(sumr)
							# print(sumary)

						# sumary=BeautifulSoup(sumary,"lxml")						
						
						# Prepare SQL query to INSERT a record into the database.
						title=title.strip()
						exist=exist_blog_data(inner_url)
						if exist>0:
							print("Exist")
							continue
						else:
							try:
								file_name=inner_url.split("/")
								file_name=file_name[len(file_name)-2]
								
								insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
							except:								
								continue

							# if btype==1:
							# 	folder_name="http://blog.peeraid.com.ng/Tech"
							# elif btype==2:
							# 	folder_name="http://blog.peeraid.com.ng/Sport/"
							# elif btype==3:
							# 	folder_name="http://blog.peeraid.com.ng/Business/"
							# elif btype==4:
							# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
							# elif btype==5:
							# 	folder_name="http://blog.peeraid.com.ng/Problems/"
							# elif btype==6:
							# 	folder_name="http://blog.peeraid.com.ng/Trending"
							# elif btype==7:
							# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
							# elif btype==8:
							# 	folder_name="http://blog.peeraid.com.ng/Research/"
							# elif btype==9:
							# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
							# elif btype==10:
							# 	folder_name="http://blog.peeraid.com.ng/Comics/"
							# elif btype==11:
							# 	folder_name="http://blog.peeraid.com.ng/Games/"
							# elif btype==12:
							# 	folder_name="http://blog.peeraid.com.ng/General/"

														
							# try:
							# 	file=open(folder_name+file_name,'w')
							# 	file.write(sumary.strip())
							# 	file.close()
							# except:
							# 	file.close()						

						if len(title_app)==0:
							title_app.add(title)
						elif title in title_app:
							title_app.add(title)
							continue
					else:
						rm_url=inner_url
						rm_text=sttr
						print("Read Url: ",rm_url)
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_peace(urlfile,page,btype,url_site):

	peace="http://blog.peacerevolution.net/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		scrap=0
		for sibling in htmltext.find_all("header","entry-header"):
			anDch()
			inner_url=sibling.h3.a['href']
			title=sibling.h3.a.text
			thumb=sibling.h4.img['src']
			try:
				if "http://" not in inner_url:
					inner_url=urlfile+inner_url
				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("div",class_="entry-content").contents
				img_sumary=html_inner_text.find("div",class_="single-featured-image-header").img['src']
				#print(inner_url)
				if scrap>=5:
					break
				scrap=scrap+1
			except:
				continue

			# for tit in title_arr:
			# 	title=title+str(tit)
			sumary=""
			for sumr in sumary_arr:
				
				#if re.match('<p',str(sumr)) or re.match('<a',str(sumr)) or re.match('<figure',str(sumr)) or re.match('<em',str(sumr))or re.match('<b',str(sumr)) or re.match('<img',str(sumr)):
				#	if re.match('<img',str(sumr)):
				#		sumr['max-width']=200
				#		sumr['height']=200
				sumary=sumary+str(sumr)
				#else:
				#	continue
				# print(sumr)
				# print(sumary)

			# sumary=BeautifulSoup(sumary,"lxml")						
						
			# Prepare SQL query to INSERT a record into the database.
			title=title.strip()
			exist=exist_blog_data(inner_url)
			if exist>0:
				print("Exist")
				continue
			else:
				try:
					file_name=inner_url.split("/")
					file_name=file_name[len(file_name)-2]
				
					insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
				except:								
					continue

				# if btype==1:
				# 	folder_name="http://blog.peeraid.com.ng/Tech"
				# elif btype==2:
				# 	folder_name="http://blog.peeraid.com.ng/Sport/"
				# elif btype==3:
				# 	folder_name="http://blog.peeraid.com.ng/Business/"
				# elif btype==4:
				# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
				# elif btype==5:
				# 	folder_name="http://blog.peeraid.com.ng/Problems/"
				# elif btype==6:
				# 	folder_name="http://blog.peeraid.com.ng/Trending"
				# elif btype==7:
				# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
				# elif btype==8:
				# 	folder_name="http://blog.peeraid.com.ng/Research/"
				# elif btype==9:
				# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
				# elif btype==10:
				# 	folder_name="http://blog.peeraid.com.ng/Comics/"
				# elif btype==11:
				# 	folder_name="http://blog.peeraid.com.ng/Games/"
				# elif btype==12:
				# 	folder_name="http://blog.peeraid.com.ng/General/"

											
				# try:
				# 	file=open(folder_name+file_name,'w')
				# 	file.write(sumary.strip())
				# 	file.close()
				# except:
				# 	file.close()						

			if len(title_app)==0:
				title_app.add(title)
			elif title in title_app:
				title_app.add(title)
				continue
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_possible(urlfile,page,btype,url_site):

	possible="https://possibilitychange.com/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		scrap=0
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		#ret_href=htmltext.find_all('a')	
	#url and text collec
		for sibling in htmltext.find_all("a","entry-featured-image-url"):
			anDch()
			inner_url=sibling['href']
			title=sibling.img['alt']
			thumb=""
			try:
				if "http://" not in inner_url:
					inner_url=urlfile+inner_url
				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("div","et_pb_text_inner").contents
				img_sumary=html_inner_text.find("div","et_pb_title_featured_container").img['src']
				thumb=sibling.img['src']
				#print(inner_url)
				if scrap>=5:
					break
				scrap=scrap+1
			except:
				continue

			# for tit in title_arr:
			# 	title=title+str(tit)
			sumary=""
			for sumr in sumary_arr:
				
				if sumr.text:
					#if re.match('<p',str(sumr)) or re.match('<h2',str(sumr))  or re.match('<ul',str(sumr)) or re.match('<li',str(sumr)) or re.match('<em',str(sumr))or re.match('<b',str(sumr)) or re.match('<img',str(sumr)):
					#	if re.match('<img',str(sumr)):
					#		sumr['max-width']=200
					#		sumr['height']=200
					sumary=sumary+str(sumr)
				else:
					continue
				# print(sumr)
				# print(sumary)

			# sumary=BeautifulSoup(sumary,"lxml")						
						
			# Prepare SQL query to INSERT a record into the database.
			title=title.strip()
			exist=exist_blog_data(inner_url)
			if exist>0:
				print("Exist")
				continue
			else:
				try:
					file_name=inner_url.split("/")
					file_name=file_name[len(file_name)-2]
					
					insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
				except:								
					continue

				# if btype==1:
				# 	folder_name="http://blog.peeraid.com.ng/Tech"
				# elif btype==2:
				# 	folder_name="http://blog.peeraid.com.ng/Sport/"
				# elif btype==3:
				# 	folder_name="http://blog.peeraid.com.ng/Business/"
				# elif btype==4:
				# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
				# elif btype==5:
				# 	folder_name="http://blog.peeraid.com.ng/Problems/"
				# elif btype==6:
				# 	folder_name="http://blog.peeraid.com.ng/Trending"
				# elif btype==7:
				# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
				# elif btype==8:
				# 	folder_name="http://blog.peeraid.com.ng/Research/"
				# elif btype==9:
				# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
				# elif btype==10:
				# 	folder_name="http://blog.peeraid.com.ng/Comics/"
				# elif btype==11:
				# 	folder_name="http://blog.peeraid.com.ng/Games/"
				# elif btype==12:
				# 	folder_name="http://blog.peeraid.com.ng/General/"

											
				# try:
				# 	file=open(folder_name+file_name,'w')
				# 	file.write(sumary.strip())
				# 	file.close()
				# except:
				# 	file.close()						

			if len(title_app)==0:
				title_app.add(title)
			elif title in title_app:
				title_app.add(title)
				continue
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_skysports(urlfile,page,btype,url_site):
	all_subclasses = []
	skysports="http://www.skysports.com/la-liga-news"
	trend="http://www.skysports.com"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")
		scrap=0
		trd=0
		for sibling in htmltext.find_all("div","news-list__item--show-thumb-bp30"):
			anDch()
			#title=sibling.h2.text
			inner_url=sibling.a['href']
			if inner_url:
				try:
					if trend in urlfile:
						inner_url=trend+inner_url
						thumb=""
					else:
						thumb=sibling.a.img['src']

					html_inner=urlopen(inner_url)
					html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
					sumary_arr=html_inner_text.find("div",class_="article__body").contents
					title=html_inner_text.find("h1",class_="article__title").span.text
					img_sumary=html_inner_text.find("div",class_="article__body").div.figure.div.div.img['data-src']
					#print(inner_url)
					if(trd==5):
						blog_data(trend,"",2)
						break
					trd=trd+1
					if scrap>=6:
						break
					scrap=scrap+1
				except:
					continue
				sumary=""
					

						
				# for tit in title_arr:
				# 	title=title+str(tit)
				for sumr in sumary_arr:
					
					#if re.match('<p',str(sumr)) or re.match('<a',str(sumr)) or re.match('<img',str(sumr)):
					#	if re.match('<img',str(sumr)):
					#		sumr['max-width']=200
					#		sumr['height']=200
					sumary=sumary+str(sumr)
					#else:
					#	continue
					# print(sumr)
					# print(sumary)
						# sumary=BeautifulSoup(sumary,"lxml")						
					
				# Prepare SQL query to INSERT a record into the database.
				title=title.strip()
				exist=exist_blog_data(inner_url)
				if exist>0:
				print("Exist")
					continue
				else:
					try:
						file_name=inner_url.split("/")
						file_name=file_name[len(file_name)-2]
						insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
						
					except:								
						continue
						# if btype==1:
					# 	folder_name="http://blog.peeraid.com.ng/Tech"
					# elif btype==2:
					# 	folder_name="http://blog.peeraid.com.ng/Sport/"
					# elif btype==3:
					# 	folder_name="http://blog.peeraid.com.ng/Business/"
					# elif btype==4:
					# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
					# elif btype==5:
					# 	folder_name="http://blog.peeraid.com.ng/Problems/"
					# elif btype==6:
					# 	folder_name="http://blog.peeraid.com.ng/Trending"
					# elif btype==7:
					# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
					# elif btype==8:
					# 	folder_name="http://blog.peeraid.com.ng/Research/"
					# elif btype==9:
					# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
					# elif btype==10:
					# 	folder_name="http://blog.peeraid.com.ng/Comics/"
					# elif btype==11:
					# 	folder_name="http://blog.peeraid.com.ng/Games/"
					# elif btype==12:
					# 	folder_name="http://blog.peeraid.com.ng/General/"
													
					# try:
					# 	file=open(folder_name+file_name,'w')
					# 	file.write(sumary.strip())
					# 	file.close()
					# except:
					# 	file.close()						

					if len(title_app)==0:
						title_app.add(title)
					elif title in title_app:
						title_app.add(title)
						continue
				
			
		

	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_smile(urlfile,page,btype,url_site):

	smile="http://www.kipsmiling.com/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		scrap=0
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		#ret_href=htmltext.find_all('a')	
	#url and text collection
		for sibling in htmltext.find_all("article","latestPost"):
			anDch()
			inner_url=sibling.header.h2.a['href']
			title=sibling.header.h2.a.text
			thumb=""
			try:
				if "http://" not in inner_url:
					inner_url=urlfile+inner_url

				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("div","thecontent").contents
				thumb=img_sumary=sibling.a.img['src']
				#print(inner_url)
				if scrap>=5:
					break
				scrap=scrap+1
			except:
				continue

			# for tit in title_arr:
			# 	title=title+str(tit)
			sumary=""
			for sumr in sumary_arr:
				
				if sumr.text:
				#	if re.match('<p',str(sumr)) or re.match('<h2',str(sumr))  or re.match('<ul',str(sumr)) or re.match('<li',str(sumr)) or re.match('<em',str(sumr))or re.match('<b',str(sumr)) or re.match('<img',str(sumr)):
				#		if re.match('<img',str(sumr)):
				#			sumr['max-width']=200
				#			sumr['height']=200
					sumary=sumary+str(sumr)
				else:
					continue
				# print(sumr)
				# print(sumary)

			# sumary=BeautifulSoup(sumary,"lxml")						
						
			# Prepare SQL query to INSERT a record into the database.
			title=title.strip()
			exist=exist_blog_data(inner_url)
			if exist>0:
				print("Exist")
				continue
			else:
				try:
					file_name=inner_url.split("/")
					file_name=file_name[len(file_name)-2]
					
					insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
				except:								
					continue

				# if btype==1:
				# 	folder_name="http://blog.peeraid.com.ng/Tech"
				# elif btype==2:
				# 	folder_name="http://blog.peeraid.com.ng/Sport/"
				# elif btype==3:
				# 	folder_name="http://blog.peeraid.com.ng/Business/"
				# elif btype==4:
				# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
				# elif btype==5:
				# 	folder_name="http://blog.peeraid.com.ng/Problems/"
				# elif btype==6:
				# 	folder_name="http://blog.peeraid.com.ng/Trending"
				# elif btype==7:
				# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
				# elif btype==8:
				# 	folder_name="http://blog.peeraid.com.ng/Research/"
				# elif btype==9:
				# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
				# elif btype==10:
				# 	folder_name="http://blog.peeraid.com.ng/Comics/"
				# elif btype==11:
				# 	folder_name="http://blog.peeraid.com.ng/Games/"
				# elif btype==12:
				# 	folder_name="http://blog.peeraid.com.ng/General/"

						
				# try:
				# 	file=open(folder_name+file_name,'w')
				# 	file.write(sumary.strip())
				# 	file.close()
				# except:
				# 	file.close()						

			if len(title_app)==0:
				title_app.add(title)
			elif title in title_app:
				title_app.add(title)
				continue
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()

def blog_data_thinksimplenow(urlfile,page,btype,url_site):

	thinksimple="http://thinksimplenow.com/"
	# prepare a cursor object using cursor() method
	
	httplink=urlfile+page
	
	try:
		scrap=0
		htmlfile=urlopen(httplink)
		htmltext=BeautifulSoup(htmlfile.read(),"lxml")

		ret_href=htmltext.find_all('a')	
	#url and text collection
		for sibling in htmltext.find_all("div","posts"):
			anDch()
			inner_url=sibling.article.h1.a['href']
			title=sibling.article.h1.a.text
			thumb=""
			try:
				if "http://" not in inner_url:
					inner_url=urlfile+inner_url
				html_inner=urlopen(inner_url)
				html_inner_text=BeautifulSoup(html_inner.read(),"lxml")
				sumary_arr=html_inner_text.find("article").contents
				thumb=img_sumary=html_inner_text.find("figure").img['src']
				#print(inner_url)
				if scrap>=5:
					break
				scrap=scrap+1
			except:
				continue

			# for tit in title_arr:
			# 	title=title+str(tit)
			sumary=""
			for sumr in sumary_arr:
				
			#	if re.match('<p',str(sumr)) or re.match('<a',str(sumr)) or re.match('<h2',str(sumr))  or re.match('<ul',str(sumr)) or re.match('<li',str(sumr)) or re.match('<em',str(sumr))or re.match('<b',str(sumr)) or re.match('<img',str(sumr)):
			#		if re.match('<img',str(sumr)):
			#			sumr['max-width']=200
			#			sumr['height']=200
				sumary=sumary+str(sumr)
			#	else:
			#		continue
				# print(sumr)
				# print(sumary)

			# sumary=BeautifulSoup(sumary,"lxml")						
						
			# Prepare SQL query to INSERT a record into the database.
			title=title.strip()
			exist=exist_blog_data(inner_url)
			if exist>0:
				
				print("Exist")
				continue
			else:
				try:

					file_name=inner_url.split("/")
					file_name=file_name[len(file_name)-2]
					
					insert_blog_data(btype,inner_url,title,1,thumb,img_sumary,file_name,htmlspecialchars(sumary),url_site)
				except:								
					continue

				# if btype==1:
				# 	folder_name="http://blog.peeraid.com.ng/Tech"
				# elif btype==2:
				# 	folder_name="http://blog.peeraid.com.ng/Sport/"
				# elif btype==3:
				# 	folder_name="http://blog.peeraid.com.ng/Business/"
				# elif btype==4:
				# 	folder_name="http://blog.peeraid.com.ng/Tutorials/"
				# elif btype==5:
				# 	folder_name="http://blog.peeraid.com.ng/Problems/"
				# elif btype==6:
				# 	folder_name="http://blog.peeraid.com.ng/Trending"
				# elif btype==7:
				# 	folder_name="http://blog.peeraid.com.ng/Fashion/"
				# elif btype==8:
				# 	folder_name="http://blog.peeraid.com.ng/Research/"
				# elif btype==9:
				# 	folder_name="http://blog.peeraid.com.ng/inspiration/"
				# elif btype==10:
				# 	folder_name="http://blog.peeraid.com.ng/Comics/"
				# elif btype==11:
				# 	folder_name="http://blog.peeraid.com.ng/Games/"
				# elif btype==12:
				# 	folder_name="http://blog.peeraid.com.ng/General/"
							
				# try:
				# 	file=open(folder_name+file_name,'w')
				# 	file.write(sumary.strip())
				# 	file.close()
				# except:
				# 	file.close()						

			if len(title_app)==0:
				title_app.add(title)
			elif title in title_app:
				title_app.add(title)
				continue
				
		
	except HTTPError as he:
		print(he)
		# exit()
		#continue
	except AttributeError as ae:
		print(ae)		
		# exit()




def insert_blog_data(blog_type_id,inner_url,title,pic_id,thumb,data_pic,file_url,file_txt,url):
	
	blog_url_id=insert_blog(url)
	# if blog_url_id==0:
	# 	return
	cursor = db.cursor()
	sql_insert = "INSERT INTO blog_data(blog_url_id,blog_type_id,blog_link,title,pic_id,thumb,data_pic,file_url)\
		VALUES ('%d','%d','%s','%s','%d','%s','%s','%s')" % \
		(blog_url_id,blog_type_id,inner_url,title,pic_id,thumb,data_pic,file_url)
	
	try:
		# Execute the SQL command
		cursor.execute(sql_insert)
		db.commit()
		txt_len=len(file_txt)/500
		tlen=math.ceil(txt_len)
		lastx=0
		for xl in range(1,tlen):			
			nextx=xl*500					
			rtxt=file_txt[lastx:nextx]
			lastx=nextx			
			try:
				cursor = db.cursor()
				# Prepare SQL query to INSERT a record into the database.
				sql_insert = "INSERT INTO blog_data_txt(blog_txt_link,blog_txt_file)\
		       		VALUES ('%s','%s')" % \
		       		(inner_url,rtxt)
				# Execute the SQL command
				cursor.execute(sql_insert)
				
				print(url)
				# Commit your changes in the database
				db.commit()
			except:
				# Rollback in case there is any error
				continue
				db.rollback()
				db.close()
		
	except:
		# Rollback in case there is any error
		db.rollback()
		db.close()
		


def insert_blog(urlfile):
	try:
		if(count_blog(urlfile)==0):			
			cursor = db.cursor()
			# Prepare SQL query to INSERT a record into the database.
			sql_insert = "INSERT INTO blog(blog_url)\
			       VALUES ('%s')" % \
			       (urlfile)
			# Execute the SQL command
			cursor.execute(sql_insert)
			# Commit your changes in the database
			db.commit()
		sql_read_count= "SELECT * from blog where blog_url='%s'" %(urlfile)
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		urlcount = cursor.fetchall()
		return urlcount[0][0]
	except:
		# Rollback in case there is any error
		db.rollback()
		db.close()
		return 0

def insert_txt(innerurl,summary):
	try:		
		cursor = db.cursor()
		# Prepare SQL query to INSERT a record into the database.
		sql_insert = "INSERT INTO blog_data_txt(blog_txt_link,blog_txt_file)\
		       VALUES ('%s','%s')" % \
		       (innerurl,summary)
		# Execute the SQL command
		cursor.execute(sql_insert)
		# Commit your changes in the database
		db.commit()
	except:
		# Rollback in case there is any error
		db.rollback()
		db.close()



def count_blog(urlfile):

	sql_read_count= "SELECT * from blog where blog_url='%s'" %(urlfile)
	try:
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		urlcount = len(cursor.fetchall())
		
	except:
		print("")
		db.close()
	
	return urlcount


def count_blog_data(urlfile):
	
	sql_read_count= "SELECT * from blog_data where blog_link='%s'" %(urlfile)
	try:
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		urlcount = len(cursor.fetchall())
		
	except:
		print("")	
		db.close()
	
	return urlcount

def exist_blog(urlfile):
	
	sql_read_count= "SELECT * from blog where blog_url='%s'" %(urlfile)
	try:
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		urlcount = len(cursor.fetchall())
		if urlcount>0:
			return 1
		else:
			return 0
	except:		
		# db.close()
		return 0

def exist_blog_data(urlfile):
	
	sql_read_count= "SELECT * from blog_data where blog_link='%s'" %(urlfile)
	try:
		cursor = db.cursor()

		# Execute the SQL command
		cursor.execute(sql_read_count)
		urlcount = len(cursor.fetchall())
		if urlcount>0:
			return 1
		else:
			return 0
	except:	
		# db.close()
		return 0
	

def blog_url_id(urlfile):
	
	sql_read_count= "SELECT * from blog where blog_url='%s'" %(urlfile)
	try:
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		
	except:	
		print("")	
		# db.close()
	return cursor.fetchall()[0][0]

def blog_type_id(type):
	
	sql_read_count= "SELECT * from blog_type where blog_type='%s'" %(urlfile)
	try:
		cursor = db.cursor()
		# Execute the SQL command
		cursor.execute(sql_read_count)
		
	except:
		print("")
		# db.close()
	return cursor.fetchall()[0][0]
	
def csv_writer(data, path):

    """

    Write data to a CSV file path

    """

    with open(path, 'a') as csv_file:

        writer = csv.writer(csv_file, delimiter=',')

        for line in data:

            writer.writerow(line)



with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_zdnet(zdnet_secure,"","http://www.zdnet.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()	
	blog_data_zdnet(zdnet_inn,"","http://www.zdnet.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_zdnet(zdnet_win,"","http://www.zdnet.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_zdnet(zdnet_smart,"","http://www.zdnet.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_tinybuddha(tinybud,"",9,"https://tinybuddha.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_thinksimplenow(thinksimplenow,"",9,"http://www.thinksimplenow.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_smile(smile,"",9,"http://www.kipsmiling.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_skysports(skysports,"",2,"http://www.skysports.com")
# blog_data_skysports_trend(trend,"",2)

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_possible(possible,"",9,"https://possibilitychange.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_peace(peace,"",9,"http://blog.peacerevolution.net")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	strtyp=str(date.today().year)+"/"+str(date.today().month)
	blog_data_hbr_org(hbr_org,"",3,"/"+strtyp+"","http://www.hbr.org")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_bplan(bplan,"",3,"http://articles.bplans.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_bbc(bbc_world,"",12,"/news/world","http://www.bbc.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_bbc(bbc_business,"",3,"/news/business","http://www.bbc.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_bbc(bbc_tech,"",1,"/news/technology","http://www.bbc.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_bbc(bbc_science,"",1,"/news/science_and_environment","http://www.bbc.com")

with Controller.from_port(port = 9151) as controller:
	controller.authenticate()
	anDch()
	blog_data_applied(applied,"",9,"http://www.appliedneuroscienceblog.com")

