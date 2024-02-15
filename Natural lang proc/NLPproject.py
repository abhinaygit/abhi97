from nltk import ngrams,tokenize
from regex import P
import os
import pickle
import sys
import getopt

def generateLanguageModel(lang): 
    totalUnigrams=0
    bigramvalues={}
    os.chdir(lang)
    listFiles=os.listdir()
    for i in listFiles:
        totalUnigrams,bigramvalues=processFile(i,totalUnigrams,bigramvalues)
    os.chdir("../")
    file=open(lang+'_LangModel.pkl','wb')
    languageModel={}
    languageModel['model']=bigramvalues
    languageModel['count']=totalUnigrams
    pickle.dump(languageModel,file)
    file.close()
    return languageModel

#This is for processing the data files created. This function should be called for each file
#Hash of Hash will be updated automatically

def processFile(fileName,totalUnigrams,bigramvalues):
    file=open(fileName,'r')
    content=file.read()
    file.close()
    #content=content.lower()
    tokens=tokenize.RegexpTokenizer(r'\w+').tokenize(content)
    bigrams=ngrams(tokens,2)
    uc=0
    for c,j in enumerate(bigrams):
        uc=c
        preword,word=j
        if preword in bigramvalues.keys():
            bigramvalues[preword]['count']+=1
            if word in bigramvalues[preword].keys():
                bigramvalues[preword][word]+=1
            else:
                bigramvalues[preword][word]=1
        else:
            bigramvalues[preword]={}
            bigramvalues[preword]['count']=1
            bigramvalues[preword][word]=1

    return totalUnigrams+uc+1,bigramvalues

def processSentence(text,model):
    bigramvalues=model['model']
    totalUnigrams=model['count']
    text=text.lower()
    tokens=tokenize.RegexpTokenizer(r'\w+').tokenize(text)
    biGrams=ngrams(tokens,n=2)
    prob=1
    for c,i in enumerate(biGrams):
        preword,word=i
        if c==0:
            if preword in bigramvalues.keys():
                prob=prob*bigramvalues[preword]['count']/totalUnigrams
            else:
                prob=prob*1/totalUnigrams
        prob=prob*getProb(preword,word,model)
    return prob

def getProb(preWord,word,model):
    bigramvalues=model['model']
    totalUnigrams=model['count']
    if preWord in bigramvalues.keys():
        total=len(bigramvalues[preWord].keys())-1+bigramvalues[preWord]['count']
        if word in bigramvalues[preWord].keys():
            matchCount=bigramvalues[preWord][word]
        else:
            matchCount=1
    else:
        return 1/totalUnigrams
    return matchCount/total



def passArgs(argv):
    arg_help = "{0} -mode [train/test] -lang [English/French]".format(argv[0])
    
    try:
        opts, args = getopt.getopt(argv[1:], "h:m:l:",["help","mode=","lang="])
    except:
        print(arg_help)
        sys.exit(2)
    trainTestmode,trainTestLang="",""
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(arg_help)  # print the help message
            sys.exit(2)
        elif opt in ("-m", "--mode"):
            trainTestmode = arg
        elif opt in ("-l", "--lang"):
            trainTestLang = arg
    return trainTestmode,trainTestLang
if __name__=="__main__":
    print("Welcome to Lanuage modelling Demo")
    mode,language=passArgs(sys.argv)
    if (mode.lower()=="train"):
        generateLanguageModel(language)
    elif (mode.lower()=="test"):
        try:
            model=pickle.load(open(language+'_LangModel.pkl','rb'))
        except:
            print("Please train the model first!!!!")
            exit()
        while(True):
            sentence=input("Sentence : ")
            if sentence=="bye":break
            print(processSentence(sentence,model))

