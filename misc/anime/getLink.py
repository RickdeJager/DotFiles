import subprocess
import jsbeautifier
import requests
import re
import json
import sys

vidLinkRegex = r"https?:\/\/.*?(\.eu|\.com).*?\.mp4"

def buildStreamUrl(item):
    embed_id = item["embed_id"]
    embed_pre = item["host"]["embed_prefix"].replace(r'\\', '')
    embed_suf = item["host"]["embed_suffix"]
    return embed_pre+embed_id+embed_suf

#Load shows from file
with open('shows.json', 'r') as json_data:
    showData = json.load(json_data)
rofiString = ""
for show in showData.keys():
    rofiString += show+"\n"
p1 = subprocess.Popen(['printf', rofiString], stdout=subprocess.PIPE)
pShow = subprocess.Popen(['rofi' ' -dmenu -lines 5 -p Show -i'], stdin=p1.stdout, stdout=subprocess.PIPE, shell=True)

chosenShow = pShow.communicate()[0].decode().rstrip()
pShow.wait()

p2 = subprocess.Popen(['printf',"Current\nNext\n"], stdout=subprocess.PIPE)
pNext = subprocess.Popen(['rofi' ' -dmenu -lines 5 -p Show -i'], stdin=p2.stdout, stdout=subprocess.PIPE, shell=True)

nextEp = pNext.communicate()[0].decode().rstrip() == 'Next'
pNext.wait()


episode = showData[chosenShow]["lastEpisode"] + (1 if nextEp else 0)
url = showData[chosenShow]["link"] + str(episode)

#1 for sub, 2 for dub
subdub = 2

def animeheaven():
    import selenium.webdriver
    from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
    caps = DesiredCapabilities.PHANTOMJS
    caps["phantomjs.page.settings.userAgent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1"
    driver = selenium.webdriver.PhantomJS(desired_capabilities=caps)
    driver.get(url)
    page = driver.page_source
    regObj = re.compile(vidLinkRegex)
    linkRes = regObj.search(page)
    return linkRes.group(0)

def masteranime():
    #To get the json object from the site
    varsRegex = r"{ anime.*"
    
    #To be used on the actual embedded site
    scriptRegex = r"eval\(function\(p,a,c,k,e,[dr]\)[\S\s]*?<\/script>"
    
    originalSite = requests.get(url).text
    
    regObj = re.compile(varsRegex, re.MULTILINE)
    jsonRes = regObj.search(originalSite)
    jsonString = jsonRes.group(0)
    
    #Slight edits to fully convert to json
    jsonString = jsonString.replace('anime', '"anime"')
    jsonString = jsonString.replace('mirrors', '"mirrors"')
    jsonString = jsonString.replace('auto_update', '"auto_update"')
    
    jsonObject = json.loads(jsonString)['mirrors']
    
    #Filter out unwanted hosts and pick sub or dub
    candidates = [item for item in jsonObject if item["type"]==subdub and item["host"]["name"] == "MP4Upload"]
    
    #Sort all JSON items left by Quality, highest first
    candidates.sort(key=lambda k: k["quality"], reverse=True)
    
    streamUrl = buildStreamUrl(candidates[0])
    
    regObj = re.compile(scriptRegex, re.MULTILINE)
    
    streamSite = requests.get(streamUrl)
    data = streamSite.text
    scriptRes = regObj.search(data)
    encodedScript = scriptRes.group(0)[:-10] #[:-10] to remove the script tag needed for regex
    plainScript = jsbeautifier.beautify(encodedScript)
    regObj = re.compile(vidLinkRegex)
    linkRes = regObj.search(plainScript)
    return linkRes.group(0)

if 'masterani.me' in url:
    link = masteranime()
elif 'animeheaven' in url:
    link = animeheaven()
#Increase episode counter by one before passing the link onto mpv/vlc
with open('shows.json', 'w') as jsonFile:
    showData[chosenShow]['lastEpisode'] = episode
    json.dump(showData, jsonFile, indent=4)
print(link)
