TTS_frontend.vbs
	This folder must be present.
		- C:\CFMS\TTS_frontend\Log
		- C:\CFMS\TTS_frontend\Tmp
	Program Sript Detail WorkFlow
		- Script wait Argument in NxCommandCenter Application
		- Set Value Validate
		- Delete Old File in Folder Log
		- Delete Old File in Folder Tmp
		- Create File in Folder Log [C:\CFMS\TTS_frontend\Log\{user}] and White File Formate JSon
		- Create File in Folder Tmp [C:\CFMS\TTS_frontend\Tmp\{data}] and White File Formate JSon
		- get Data All in Tmp and Write in File c:\CFMS\TTS_frontend\Data\SendData.txt  
		- Run Script c:\CFMS\TTS_frontend\Data\SendData.vbs
			- Read File header = "C:\CFMS\TTS_frontend\Data\Header.html"
			- Read File dataer = "C:\CFMS\TTS_frontend\Data\SendData.txt"
			- Read File footer = "C:\CFMS\TTS_frontend\Data\Footer.html"
			- Replace value user and Detail Authen
			- Mix File gen to HTML File C:\CFMS\TTS_frontend\Data\SendData.html
			- Run SendData.html