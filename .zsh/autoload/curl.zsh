# http methods                    curl -XTRACE  <url>
# x-forwarded-for                 curl -H "X-Forwarded-For: 10.0.0.1" <url>
# basic authentication            curl -u <user>:<password> <url>
# post form                       curl -XPOST --form "b=4_1" <url>
# cookie                          curl --cookie "PHPSESSID=5ved46gn34dopkjhstrrfgdkk1;" <url>
# cookie files (save & send)      curl -c /tmp/cookie.txt -b /tmp/cookie.txt <url>
# set user-agent                  curl -A "Mozilla" <url>
# referer                         curl -H "Referer: https://www.cnn.com" <url>
# json                            curl -XPOST -H "Content-Type: application/json" -d "[[\"create\",
#                                 {\"type\":\"trial\",\"name\":\"bug\"}]] <url>
# silent                          curl -s <url>
# verbose                         curl -v <url>
# ignore certifikate issues       curl -k <url>
# follow redircts                 curl -L <url>
# redirect output into file       curl -o <file> <url>
# curl with proxy                 curl -x <proxy>:<port> <url>
# curl SSL V3                     curl -k -v --sslv3 <url>
# curl max time (4 seconds)       curl -m4 <url>
# file upload                     curl -XPOST -F ul=30000 -F location=/tmp/upload-form-data.txt
#                                 -F userfile=@/tmp/upload-file.txt <url>
# shell-shock                     curl -k -L -H 'User-Agent: () { :;}; curl -L  <return-server>;'  <url>
# post data from file             curl -data '@<filename>' <url>
# curl output response time       curl -o /dev/null -w%{time_connect}:%{time_starttransfer}%{time_total} <url>
# curl output request size        curl -o /dev/null -w%{size_request} %{size_upload} <url>
# curl output http status code    curl -o /dev/null -w%%{http_code} <url>
# curl resolve ip from other dns  curl --resolve "www.cnn.com:80:8.8.8.8" http://www.cnn.com

require curl && return 1

alias curltime="curl -K $HOME/.curl/time.curl"
alias curlcode="curl -K $HOME/.curl/code.curl"
alias @weather="curl -q http://wttr.in/Athens"
alias @moon="curl -q http://wttr.in/Moon"

# https://gist.github.com/nl5887/a511f172d3fb3cd0e42d
# slightly modified

transfer() {
  # check arguments
  if [ $# -eq 0 ];
  then
    echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi

  # get temporarily filename, output is written to this file show progress can be showed
  tmpfile=$( mktemp -t transferXXX )

  # upload stdin or file
  file=$1

  if tty -s;
  then
    basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

    if [ ! -e $file ];
    then
      echo "File $file doesn't exists."
      return 1
    fi

    if [ -d $file ];
    then
      # zip directory and transfer
      zipfile=$( mktemp -t transferXXX.zip )
      cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
      curl -q --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
      rm -f $zipfile
    else
      # transfer file
      curl -q --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
    fi
  else
    # transfer pipe
    curl -q --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
  fi

  # cat output link
  cat $tmpfile

  # cleanup
  rm -f $tmpfile
}
