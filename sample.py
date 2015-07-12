from nltk.corpus import sentiwordnet as swn
import json
from pymongo import MongoClient
from sets import Set
import memcache
word_set = Set()
client = MongoClient()
db = client['test']
#db.create_collection("senti_coll")
senti_c = db.test.senti_coll
mc = memcache.Client(["127.0.0.1:11211"])
s_list = swn.senti_synsets('Happy')
print s_list
import codecs
f = codecs.open('pg78.txt', 'r', 'UTF-8')
lines = f.readlines()
print lines
print len(lines)
#for line in f:
#    print(line)
def calculate_sentiment(word,lineno):
    senti_dict = mc.get("name");
    s_list = swn.senti_synsets(word)
    if len(s_list) !=0:
        element = s_list[0]
        senti_dict = {}
        senti_dict["bookname"]="Tarzan of the Apes"
        senti_dict["lineno"]=lineno
        senti_dict["pos"]=element.pos_score()
        senti_dict["neg"]=element.neg_score()
        senti_dict["obj"]=element.obj_score()
        s_dict = {}
        s_dict[word]=senti_dict
        print s_dict
        #senti_c.save(s_dict)
    return
#calculate_sentiment("happy")
for line in lines:
    words = line.split(" ")
    for word in words:
        c_word = word.strip("\n")
        c_word = c_word.strip("\r")
        c_word = c_word.strip(".")
        c_word = c_word.strip(".")
        c_word = c_word.replace(".","")
        c_word = c_word.strip(",")
        c_word = c_word.strip(";")
        c_word = c_word.strip(":")
        c_word = c_word.strip("\"")
        c_word = c_word.strip("\'")
        word_set.add(c_word)
c = 1
for word in word_set:
    c+=1
    calculate_sentiment(word,c)
    print c 
