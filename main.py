__author__ = "samvaran kashyap"
__studentid__ = "1001142545"
__netid__ = "samvaran kashyap"
__class__ = "cloud computing section 2 3:30 to 5:30"
from bottle import route, run, template
from bottle import route, request, response, template, HTTPResponse
import uuid
from bottle import static_file
import csv
import random
import json
from nltk.corpus import sentiwordnet as swn
import json
from pymongo import MongoClient
from sets import Set
import memcache
import codecs
word_set = Set()
client = MongoClient()
db = client['test']
#db.create_collection("senti_coll")
senti_c = db.test.senti_coll
mc = memcache.Client(["127.0.0.1:11211"])
s_list = swn.senti_synsets('Happy')
print s_list
f = codecs.open('pg78.txt', 'r', 'UTF-8')
lines = f.readlines()
print lines
print len(lines)
#for line in f:
#    print(line)




# function that serves all the static files
@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root="static")

# function for the index page 
@route('/')
def index():
    return template('index')

# handles upload
@route('/uploadimage',  method='POST')
def uploadimage():
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        upload_file = request.files.get('uploadimage')
        file_name = upload_file.filename
        try:
            upload_file.save(".")
        except Exception as e:
            pass
        word_set = Set()
        client = MongoClient()
        db = client['test']
        senti_c = db.test.senti_coll
        mc = memcache.Client(["127.0.0.1:11211"])
        f = codecs.open('pg78.txt', 'r', 'UTF-8')
        lines = f.readlines()
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
        resp = HTTPResponse(body=output,status=200)
        return resp

run(host='0.0.0.0', port=8000)
