## NLP4kec

한글, 영어, 중국어 텍스트 데이터 파일을 입력받아 형태소 분석 후 R tm package에서 사용할 수 있도록 해주는 패키지
 - 한글은 은전한닢 형태소 분석기를 사용
 - 영어, 중국어는 Stanford core NLP 사용
 

## 1. 패키지 다운로드
  
  R 4.0.0 버전에서 사용가능하도록 업데이트 되었습니다.
  
  형태소 분석기 패키지 다운 받을 수 있는 링크

  - Linux/Mac 용 : http://bit.ly/NLP4kec_mac_1_4
  - Windows 용 : http://bit.ly/NLP4kec_win_1_4


## 2. 설치 방법
위에서 다운 받으신 파일을 가지고 패키지 인스톨을 하시면 됩니다. <br>(rJava패키지 사전에 인스톨 해야함 / JRE 1.8 이상이 요구됨)
<br><br> 직접설치
```
install.packages("다운받은 패키지 파일 경로", repos = NULL)
# 예시) install.packages("C:/Users/user/Desktop/class/NLP4kec_1.2.0.zip" , repos=NULL)

#또는 Rstudio에서 제공하는 패키지 인스톨 기능을 사용하세요.
```
or git clone 후 설치
```
#git에서 clone 하신 다음 설치도 가능
library(devtools)
install_local("해당 repo를 clone한 경로")
```


## 3. 사용법
엑셀 또는 CSV로 정리된 텍스트 데이터의 경로와 몇가지 옵션을 입력받아 형태소 분석을 처리함.
분석 대상 파일은 반드시 컬럼명이 id, content로 구성된 파일이어야함 (sample.xlsx 참조)
<br>
 - 파일(xlsx, csv)로 텍스트를 읽어서 형태소 분석 후 결과를 vector 형태로 가져오기
```
library(NLP4kec)
result = file_parser_r(path = "./sample.xlsx", language = "ko")
```

 - character vector를 형태소 분석하여 vector 형태로 가져오기
```
library(NLP4kec)
sample_sentence = "카레닌에게 잠에서 깨어나는 순간은 순수한 행복이었다."
r_parser_r(sample_sentence, language = "ko")
```

 - 형태소 분석 결과에서 동의어 처리하기
```
synonym_processing(parsedVector = parsedData, synonymDic = "동의어 사전 경로")
```

 - 파일(xlsx, csv)로 텍스트를 읽어서 형태소 분석 후 결과를 csv형태로 저장하기
```
result = file_parser_file(path = "./sample.xlsx", language = "ko")
```

 - 사용자 사전 적용해서 형태소 분석하기
```
result = file_parser_r(path = "./sample.xlsx", language = "ko", korDicPath = "dictionary 파일 경로")
```

 - 한글에서 영어로된 단어도 같이 분석할 경우
```
result = file_parser_r(path = "./sample.xlsx", language = "ko", useEn = T)
```

 - 영어 또는 중국어 분석하기
```
# 영어
result = file_parser_r(path = "./en_sample.xlsx", language = "en")

# 중국어
result = file_parser_r(path = "./zh_sample.xlsx", language = "zh")
```


## 4. tm패키지와 함께 사용 예시
```
library(tm)
library(NLP4kec)

#형태소 분석기 실행하기
parsedData = file_parser_r(path = "./sample.xlsx"
                         ,language = "ko"
                         ,korDicPath = "./dictionary.txt")

#단어간 스페이스 하나 더 추가하기 
parsedData = gsub(" ","  ",parsedData) #(윈도우에서 돌리는 경우에만 적용)

#Corpus 생성
corp = VCorpus(VectorSource(parsedData))

#특수문자 제거
corp = tm_map(corp, removePunctuation)

#Document Term Matrix 생성
dtm = DocumentTermMatrix(corp, control=list(removeNumbers=FALSE, wordLengths=c(2,Inf)))

#단어 양옆 스페이스 제거 및 한글자 단어 제외하기
colnames(dtmW) = trimws(colnames(dtmW))  #(윈도우에서 돌리는 경우에만 적용)
dtmW = dtmW[,nchar(colnames(dtmW)) > 1]

#연관 키워드 구하기
findAssocs(dtm, terms = "냉장고", corlimit = 0.2)
```
