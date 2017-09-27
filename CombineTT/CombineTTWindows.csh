#!/bin/tcsh
set FILENAME = "${1}"
set Date_ = `date +%Y%m%d`
set PathLogFile = "/appl/netexpert/Custom/CombineTT/Log/CombineTTWindows_"$Date_
echo "$FILENAME" > /appl/netexpert/Log/Filename.txt
dos2unix /appl/netexpert/Log/Filename.txt /appl/netexpert/Log/Filename.txt
set FILENAME = `cat /appl/netexpert/Log/Filename.txt`
set TTSPATH = "/home/tts/client/ALCFMS"
echo `date +%Y%m%d" "%T`" Start" >> $PathLogFile
cat /appl/netexpert/Log/$FILENAME >> $PathLogFile

### Develop ###
#set TTS_IP="10.138.32.103"
### Production ###
set TTS_IP="10.235.94.120"

#echo "/usr/local/bin/scp /appl/netexpert/Log/$FILENAME tts@${TTS_IP}:$TTSPATH"
#/usr/local/bin/scp /appl/netexpert/Log/$FILENAME tts@${TTS_IP}:$TTSPATH
/appl/netexpert/Custom/sendalarm ${TTS_IP} 1504 /appl/netexpert/Log/$FILENAME 

rm /appl/netexpert/Log/$FILENAME

#ssh -l tts ${TTS_IP} ". /home/tts/.bash_profile;cd $TTSPATH;echo filename=$FILENAME; ./ALRecCFMS $FILENAME; exit" > /dev/null
#echo `date +%Y%m%d" "%T`" End" >> $PathLogFile

exit
