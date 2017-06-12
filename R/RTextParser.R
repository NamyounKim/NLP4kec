
.PkgName = "NLP4kec"
.onLoad <- function(libname, pkgname){
  library(rJava)

  initopt <- c("-Xmx3g", "-Dfile.encoding=UTF-8")
  options(java.parameters = initopt)

  .jpackage(pkgname, lib.loc = libname)
}

.onAttach <- function(libname, pkgname){
  .jinit(system.file(package = .PkgName))
  .jaddClassPath(dir( file.path(system.file(package = .PkgName),"java"), full.names=TRUE ))
}

text_parser_file <- function(path, useEn = F, language, korDicPath = "noDic"){
  obj = .jnew("com.namyun.pos.Starter")
  props_path = file.path(system.file(package = "NLP4kec"),"java")

  if(language == "zh"){
    .jcall(obj, "S", "rTextParserToFile",as.character(path), as.character(useEn), as.character(language), paste0(props_path,"/StanfordCoreNLP-chinese.properties"), "NULL")
  }else{
    .jcall(obj, "S", "rTextParserToFile",as.character(path), as.character(useEn), as.character(language),"NULL", as.character(korDicPath))
  }
}

text_parser <- function(path, useEn = F, language, korDicPath = "noDic"){
  obj = .jnew("com.namyun.pos.Starter")
  props_path = file.path(system.file(package = "NLP4kec"),"java")

  if(language == "zh"){
    return(.jcall(obj, "[Ljava/lang/String;", "rTextParserToR",as.character(path), as.character(useEn), as.character(language), paste0(props_path,"/StanfordCoreNLP-chinese.properties"), "NULL"))
  }else{
    return(.jcall(obj, "[Ljava/lang/String;", "rTextParserToR",as.character(path), as.character(useEn), as.character(language), "NULL", as.character(korDicPath)))
  }
}

extract_noun <- function(path, useEn = F, language, korDicPath = "noDic"){
  obj = .jnew("com.namyun.pos.Starter")
  props_path = file.path(system.file(package = "NLP4kec"),"java")

  if(language == "zh"){
    return(.jcall(obj, "[Ljava/lang/String;", "rExtractNounToR",as.character(path), as.character(useEn), as.character(language), paste0(props_path,"/StanfordCoreNLP-chinese.properties"), "NULL"))
  }else{
    return(.jcall(obj, "[Ljava/lang/String;", "rExtractNounToR",as.character(path), as.character(useEn), as.character(language), "NULL", as.character(korDicPath)))
  }
}



