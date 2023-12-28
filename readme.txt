#this app has no build folder
#need to run the app (debugging)

#ngrok download
https://ngrok.com/download

#ngrok install
unzip ngrok.zip
copas token

# In a new terminal
php spark serve 
ngrok http 8080
 or
php spark serve -host 0.0.0.0 -port 8080 (codeigniter 4 port)
ngrok http 0.0.0.0:8080

#killall ngrok (windows + r)
taskkill /f /im ngrok.exe