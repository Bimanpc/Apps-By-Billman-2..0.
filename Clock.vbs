timerID = null
	timerRunning = false

	sub stopTimer
		if timerRunning then
			clearTimeout timerID
			timerRunning = false
		end if
	end sub

	sub startTimer
		stopTimer
		runClock
	end sub

	sub runClock
		Dim rgdow,rgmoy
		rgdow = Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
		rgmoy = Array("January","February","March","April","May","June","July","August","September","October","November","December")

		t_time = Now()
		alltime.innerText = t_time
		dow.innerText = rgdow(weekday(t_time)-1)
		moy.innerText = rgmoy(month(t_time)-1)
		dom.innerText = day(t_time)
		yr.innerText = year(t_time)
		TimerID = setTimeout("runClock",1000,"vbscript")
		timerRunning = true
	end sub