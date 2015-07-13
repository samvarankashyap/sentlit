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

# function that serves all the static files
@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root="static")

# function for the index page 
@route('/')
def index():
    return template('index')

def calculate_sentiment(word,wordno):
    s_list = swn.senti_synsets(word)
    if len(s_list) !=0:
        element = s_list[0]
        senti_dict = {}
        senti_dict["wordno"]=wordno
        senti_dict["pos"]=element.pos_score()
        senti_dict["neg"]=element.neg_score()
        senti_dict["obj"]=element.obj_score()
        s_dict = {}
        s_dict[word]=senti_dict
        print s_dict
        #senti_c.save(s_dict)
        return s_dict


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
        s_list = []
        word_set = Set()
        f = codecs.open(file_name, 'r', 'UTF-8')
        lines = f.readlines()
        for line in lines:
            words = line.split(" ")
            for word in words:
                c_word = clean_data(word)
                word_set.add(c_word)
        c = 1
        for word in word_set:
            c+=1
            s_dict = calculate_sentiment(word,c)
            s_list.append(s_dict)
            print c
        output1 = analyse_counters(s_list)
        sender_list1 = [{"key":0,"value":output1["pos"]},{"key":1,"value":output1["neg"]},{"key":2,"value":output1["obj"]}]
        sender_list2 = [{"key":0,"value":output1["pos_sum"]},{"key":1,"value":output1["neg_sum"]},{"key":2,"value":output1["obj_sum"]}]
        print sender_list1
        print sender_list2 
        output2 = senti_graph_plots(s_list)
        #print output2
        #print len(output2)
        #output = json.dumps(s_list)
        output2.append(sender_list1)        
        output2.append(sender_list2)        
        output = json.dumps(output2)
        print output1        
        resp = HTTPResponse(body=output,status=200)
        return resp

def clean_data(c_word):
    c_word = c_word.strip("\n")
    c_word = c_word.strip("\r")
    c_word = c_word.strip(".")
    c_word = c_word.strip(".")
    c_word = c_word.replace(".","")
    c_word = c_word.strip(",")
    c_word = c_word.strip(";")
    c_word = c_word.strip(":")
    c_word = c_word.strip("\"")
    c_word = c_word.strip("\'")
    return c_word

def analyse_counters(s_list):
    p_c=0
    n_c=0
    o_c=0
    p_sum = 0
    n_sum = 0
    o_sum = 0 
    for x in s_list:
        if x!=None:
            word = x.keys()[0]
            pos = x[word]["pos"]
            neg = x[word]["neg"]
            obj = x[word]["obj"]
            score_list = [pos,neg,obj]
            max_value = max(score_list)
            max_index = score_list.index(max_value)
            if max_index == 0:
                p_c +=1
                p_sum += max_value
            elif max_index == 1:
                n_c +=1
                n_sum += max_value
            else:
                o_c +=1 
                o_sum += max_value
    counters ={}
    counters["pos"]=p_c
    counters["neg"]=n_c
    counters["obj"]=o_c
    counters["pos_sum"]=int(p_sum) 
    counters["neg_sum"]=int(n_sum)
    counters["obj_sum"]=int(o_sum)
    return counters


def senti_graph_plots(s_list):
    data1 = []
    data2 = []
    data3 = []
    for x in s_list:
        if x!=None:
            word = x.keys()[0]
            pos = x[word]["pos"]
            neg = x[word]["neg"]
            obj = x[word]["obj"]
            line = x[word]["wordno"]
            pos_data = {}
            pos_data["word"]=line
            pos_data["score"]=pos
            data1.append(pos_data)
            neg_data = {}
            neg_data["word"]=line
            neg_data["score"]=neg
            data2.append(neg_data)
            obj_data = {}
            obj_data["word"]=line
            obj_data["score"]=obj
            data3.append(obj_data)
    data = [data1,data2,data3]
    return data


run(host='0.0.0.0', port=8080)
