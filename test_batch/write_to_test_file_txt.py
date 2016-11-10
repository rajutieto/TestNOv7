import time
import datetime
while 1:
	f = open('test_file.txt','a')	
	f.write('This line of text was added on: ' + str(datetime.datetime.now()) + '\n') # python will convert \n to os.linesep
	f.close() # you can omit in most cases as the destructor will call i
	time.sleep(5)
