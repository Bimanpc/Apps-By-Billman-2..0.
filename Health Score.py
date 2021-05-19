# Health Calculator

# func to show health score of user
def healthScore():
	print(' ')
	numberOfFruits = int(input('Fruits You Eat in Week : ')) 
	numberOftimesFastFood = int(input('Times You Eat FastFood in a Week : '))  
	cigars = int(input('Cigars You Smoke In Week : ')) 
	workoutTime = int(input('How Much minutes You Workout EveryDay : '))  
	bodyMassIndex = int(input('Whats Your BodyMassIndex : '))
	if 18 < bodyMassIndex < 26 :
		print(' ')
		healthScore = (numberOfFruits + workoutTime + bodyMassIndex ) - (cigars + numberOftimesFastFood) 
		print(healthScore)
	else :
		print(' ')
		healthScore = (numberOfFruits + workoutTime) - (cigars + numberOftimesFastFood + bodyMassIndex )
		print(healthScore)	

# main code
while True:
	startOrEnd = str(input('Start or End : '))
	if startOrEnd == 'Start':
		print(healthScore())
		continue
	else :
		quit()	
