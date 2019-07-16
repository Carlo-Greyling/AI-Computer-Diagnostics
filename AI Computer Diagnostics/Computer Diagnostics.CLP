(deftemplate computer_state(slot error_num)(multislot error_type)(slot error_condition))

(deffacts computer_states
	(computer_state(error_num 1)(error_type Computer turn on)(error_condition pending)))

(defrule computerON
	?f1 <- (computer_state(error_num 1)(error_type Computer turn on)(error_condition pending))
	=>
	(printout t "Does the computer turn on? Y/N" crlf)
	(bind ?input(read))
	(modify ?f1(error_condition ?input))
	(open "ErrorStates.dat" testfile "w")
	(printout testfile "Error State: " 1 crlf "State Type: Computer turn on" crlf "Condition: " ?input crlf crlf)
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 2)(error_type Screen output)(error_condition Y)))
		(printout testfile "Error State: " 2 crlf "State Type: Screen output" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 3)(error_type PSU faulty)(error_condition Y)))
		(printout testfile "Error State: " 3 crlf "State Type: Power Supply Unit faulty" crlf "Condition: " ?input crlf))
		(close testfile))
	
(defrule screenOutput
	?f2 <- (computer_state(error_num 2)(error_type Screen output)(error_condition Y))
	=>
	(printout t "Is there any display on the screen? Y/N" crlf)
	(bind ?input(read))
	(modify ?f2(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 4)(error_type Computer boots)(error_condition Y)))
		(printout testfile "Error State: " 4 crlf "State Type: Computer boots" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 5)(error_type Faulty GPU)(error_condition Y)))
		(printout testfile "Error State: " 5 crlf "State Type: Faulty Graphics Processing Unit" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule faultyGPU
	(computer_state(error_num 5)(error_type Faulty GPU)(error_condition Y))
	=>
	(printout t "Faulty Graphics Processing Unit, test and replace Graphics Processing Unit if needed" crlf)
	(save-facts "LogFile.dat"))
		
(defrule computerBoot
	?f3 <- (computer_state(error_num 4)(error_type Computer boots)(error_condition Y))
	=>
	(printout t "Restart the computer a few times. Does the computer boot every time Y/N" crlf)
	(bind ?input(read))
	(modify ?f3(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 31)(error_type Computer beeping)(error_condition Y)))
		(printout testfile "Error State: " 31 crlf "State Type: Computer Beeping" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 3)(error_type PSU faulty)(error_condition Y)))
		(printout testfile "Error State: " 3 crlf "State Type: Power Supply Unit faulty" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule computerBeep
	?f4 <- (computer_state(error_num 31)(error_type Computer beeping)(error_condition Y))
	=>
	(printout t "Does the computer make a beeping noise? Y/N" crlf)
	(bind ?input(read))
	(modify ?f4(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 10)(error_type Motherboard troubleshoot)(error_condition Y)))
		(printout testfile "Error State: " 10 crlf "State Type: Motherboard Troubleshoot" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 7)(error_type New hardware)(error_condition Y)))
		(printout testfile "Error State: " 7 crlf "State Type: New Hardware" crlf "Condition: " ?input crlf crlf))
		(close testfile))
	
(defrule troubleshootMotherboard
	(computer_state(error_num 10)(error_type Motherboard troubleshoot)(error_condition Y))
	=>
	(printout t "Troubleshoot the motherboard by using the motherboard manual" crlf)
	(save-facts "LogFile.dat"))
	
(defrule PSUfailure
	?f6 <- (computer_state(error_num 3)(error_type PSU faulty)(error_condition Y))
	=>
	(printout t "The Power Supply Unit may be fried or faulty." crlf  "Test Power Supply Unit." crlf "Does Power Supply Unit work? Y/N" crlf)
	(bind ?input(read))
	(modify ?f6(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 6)(error_type Power switch working)(error_condition Y)))
		(printout testfile "Error State: " 6 crlf "State Type: Power Switch Working" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 14)(error_type Replace PSU)(error_condition Y)))
		(printout testfile "Error State: " 14 crlf "State Type: Power Switch Working" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule powerSwitch
	?f7 <- (computer_state(error_num 6)(error_type Power switch working)(error_condition Y))
	=>
	(printout t "Does the power switch work? Y/N" crlf)
	(bind ?input(read))
	(modify ?f7(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition Y)))
		(printout testfile "Error State: " 13 crlf "State Type: Faulty Motherboard Connections" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition Y)))
		(printout testfile "Error State: " 13 crlf "State Type: Faulty Motherboard Connections" crlf "Condition: " ?input crlf crlf))
		(close testfile))
	
(defrule newHardware
	?f8 <- (computer_state(error_num 7)(error_type New hardware)(error_condition Y))
	=>
	(printout t "Have you recently installed any new hardware? Y/N" crlf)
	(bind ?input(read))
	(modify ?f8(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 8)(error_type Remove Restart)(error_condition Y)))
		(printout testfile "Error State: " 8 crlf "State Type: Remove Restart" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 9)(error_type Boot drive startup)(error_condition Y)))
		(printout testfile "Error State: " 9 crlf "State Type: Boot Drive Startup" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule removeANDrestart
	?f9 <- (computer_state(error_num 8)(error_type Remove Restart)(error_condition Y))
	=>
	(printout t "Remove the new hardware and restart the computer. Is the issue resolved? Y/N" crlf)
	(bind ?input(read))
	(modify ?f9(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 11)(error_type PSU not enough)(error_condition Y)))
		(printout testfile "Error State: " 11 crlf "State Type: Screen output" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 10)(error_type Motherboard troubleshoot)(error_condition Y)))
		(printout testfile "Error State: " 10 crlf "State Type: Motherboard troubleshoot" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule PSUnotEnough
	(computer_state(error_num 11)(error_type PSU not enough)(error_condition Y))
	=>
	(printout t "Your Power Supply Unit may not be large enough to supply power to all of your hardware. Replace your Power Supply Unit with a larger model." crlf)
	(save-facts "LogFile.dat"))
	
(defrule HDDstart
	?f11 <- (computer_state(error_num 9)(error_type Boot drive startup)(error_condition Y))
	=>
	(printout t "Did the HDD start up? Y/N" crlf)
	(bind ?input(read))
	(modify ?f11(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 17)(error_type Hard drive detected)(error_condition Y)))
		(printout testfile "Error State: " 17 crlf "State Type: Hard drive detected" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 12)(error_type IDE cables)(error_condition Y)))
		(printout testfile "Error State: " 12 crlf "State Type: IDE cables" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule IDEcables
	(computer_state(error_num 12)(error_type IDE cables)(error_condition Y))
	=>
	(printout t "Try different IDE cables. Current IDE cables may be faulty" crlf)
	(save-facts "LogFile.dat"))
	
(defrule motherboardConnections
	?f12 <- (computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition Y))
	=>
	(printout t "Your cable connections may be on the wrong motherboard pins. Are the cable connections faulty? Y/N" crlf)
	(bind ?input(read))
	(modify ?f12(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 16)(error_type Connect pins)(error_condition Y)))
		(printout testfile "Error State: " 16 crlf "State Type: Connect pins" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 15)(error_type Replace Power Switch)(error_condition Y)))
		(printout testfile "Error State: " 15 crlf "State Type: Replace Power Switch" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule connectPins
	(computer_state(error_num 16)(error_type Connect pins)(error_condition Y))
	=>
	(printout t "Consult motherboard manual to identify on which pins your cables need to be connected." crlf)
	(save-facts "LogFile.dat"))
	
(defrule replacePowerSwitch
	(computer_state(error_num 15)(error_type Replace Power Switch)(error_condition Y))
	=>
	(printout t "Power switch may be faulty. Replace power switch" crlf)
	(save-facts "LogFile.dat"))
	
	
(defrule PSUandMotherboardConnections
	(and(computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition N))(computer_state(error_num 6)(error_type Power switch working)(error_condition Y)))
	?f13 <- (computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition N))
	=>
	(printout t "Power Supply Unit may be fried or faulty. Test your Power Supply Unit to make sure it is in working condition" crlf "Is the Power Supply Unit working? Y/N" crlf)
	(bind ?input(read))
	(modify ?f13(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(retract ?f13)
		(assert(computer_state(error_num 13)(error_type Faulty Motherboard Connections)(error_condition Y)))
		(printout testfile "Error State: " 14 crlf "State Type: Replace Power Supply Unit" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 14)(error_type Replace PSU)(error_condition Y)))
		(printout testfile "Error State: " 14 crlf "State Type: Replace Power Supply Unit" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule replacePSU
	(computer_state(error_num 14)(error_type Replace PSU)(error_condition Y))
	=>
	(printout t "Power Supply Unit fried or faulty. Replace Power Supply Unit" crlf)
	(save-facts "LogFile.dat"))
	
(defrule HDDdetected
	?f14 <- (computer_state(error_num 17)(error_type Hard drive detected)(error_condition Y))
	=>
	(printout t "Is the hard drive detected as the master boot drive? Y/N" crlf)
	(bind ?input(read))
	(modify ?f14(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 19)(error_type Boot sector error)(error_condition Y)))
		(printout testfile "Error State: " 19 crlf "State Type: Boot sector error" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 18)(error_type Jumper and BIOS set)(error_condition Y)))
		(printout testfile "Error State: " 18 crlf "State Type: Jumper and BIOS set" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule bootSectorError
	?f15 <- (computer_state(error_num 19)(error_type Boot sector error)(error_condition Y))
	=>
	(printout t "Do you have a 'Boot sector not found' error? Y/N" crlf)
	(bind ?input(read))
	(modify ?f15(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 20)(error_type Recover MBR)(error_condition Y)))
		(printout testfile "Error State: " 20 crlf "State Type: Recover MBR" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 21)(error_type NTLDR Error)(error_condition Y)))
		(printout testfile "Error State: " 21 crlf "State Type: NTLDR Error" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule recoverMBR
	(computer_state(error_num 20)(error_type Recover MBR)(error_condition Y))
	=>
	(printout t "MBR corrupt. Recover your Master Boot Record from Windows." crlf)
	(save-facts "LogFile.dat"))
	
(defrule HDDsetMaster
	?f16 <- (computer_state(error_num 18)(error_type Jumper and BIOS set)(error_condition Y))
	=>
	(printout t "Set jumper and BIOS to set HDD as master boot device." crlf "Is the hard drive detected as the master boot drive? Y/N" crlf)
	(bind ?input(read))
	(modify ?f16(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 19)(error_type Boot sector error)(error_condition Y)))
		(printout testfile "Error State: " 19 crlf "State Type: Boot sector error" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 23)(error_type Other devices)(error_condition Y)))
		(printout testfile "Error State: " 23 crlf "State Type: Other devices" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule otherDevices
	?f17 <- (computer_state(error_num 23)(error_type Other devices)(error_condition Y))
	=>
	(printout t "Are there any other storage devices linked to the system? Y/N" crlf)
	(bind ?input(read))
	(modify ?f17(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 24)(error_type Swap slots)(error_condition Y)))
		(printout testfile "Error State: " 24 crlf "State Type: Swap slots" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 25)(error_type Test HDD)(error_condition Y)))
		(printout testfile "Error State: " 25 crlf "State Type: Test HDD" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule swapSlots
	?f18 <- (computer_state(error_num 17)(error_type Hard drive detected)(error_condition Y))
	=>
	(printout t "Try swapping SATA slots and cables" crlf)
	(modify ?f18(error_condition N))
	(modify ?f18(error_condition Y))
	(save-facts "LogFile.dat"))
	
(defrule testHDD
	?f19 <- (computer_state(error_num 25)(error_type Test HDD)(error_condition Y))
	=>
	(printout t "HDD may be faulty. Test HDD in another computer. Does the HDD work in the other computer? Y/N" crlf)
	(bind ?input(read))
	(modify ?f19(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 32)(error_type Motherboard controller dead)(error_condition Y)))
		(printout testfile "Error State: " 32 crlf "State Type: Motherboard controller dead" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 28)(error_type HDD broken)(error_condition Y)))
		(printout testfile "Error State: " 28 crlf "State Type: HDD broken" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule motherboardController
	(computer_state(error_num 32)(error_type Motherboard controller dead)(error_condition Y))
	=>
	(printout t "Motherboard controller is dead. Replace or repair motherboard." crlf)
	(save-facts "LogFile.dat"))
	
(defrule HDDdead
	(computer_state(error_num 28)(error_type HDD broken)(error_condition Y))
	=>
	(printout t "HDD broken or faulty. Replace HDD" crlf)
	(save-facts "LogFile.dat"))
	
(defrule NTLDRerror
	?f20 <- (computer_state(error_num 21)(error_type NTLDR Error)(error_condition Y))
	=>
	(printout t "Do you have a 'Missing NTLDR' error? Y/N" crlf)
	(bind ?input(read))
	(modify ?f20(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert(computer_state(error_num 22)(error_type Recover NTLDR)(error_condition Y)))
		(printout testfile "Error State: " 22 crlf "State Type: Recover NTLDR" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 26)(error_type Boot from other)(error_condition Y)))
		(printout testfile "Error State: " 26 crlf "State Type: Boot from other" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule recoverNTLDR
	(computer_state(error_num 22)(error_type Recover NTLDR)(error_condition Y))
	=>
	(printout t "Recover NTLDR from Windows" crlf)
	(save-facts "LogFile.dat"))
	
(defrule bootOther
	?f20 <- (computer_state(error_num 26)(error_type Boot from other)(error_condition Y))
	=>
	(printout t "Use any other bootable devices such as CD, floppy disk or USB. Is the boot device able to detect HDD partitions? Y/N" crlf)
	(bind ?input(read))
	(modify ?f20(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 27)(error_type Windows safe mode)(error_condition Y)))
		(printout testfile "Error State: " 27 crlf "State Type: Windows safe mode" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 29)(error_type Scan HDD)(error_condition Y)))
		(printout testfile "Error State: " 29 crlf "State Type: Scan HDD)" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule safeMode
	?f21 <- (computer_state(error_num 27)(error_type Windows safe mode)(error_condition Y))
	=>
	(printout t "Is Windows Safe Mode working? Y/N" crlf)
	(bind ?input(read))
	(modify ?f21(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 33)(error_type Windows safe launch)(error_condition Y)))
		(printout testfile "Error State: " 33 crlf "State Type: Windows safe launch" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 30)(error_type Windows repair)(error_condition Y)))
		(printout testfile "Error State: " 30 crlf "State Type: Windows repair" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule safeModeLaunch
	(computer_state(error_num 33)(error_type Windows safe launch)(error_condition Y))
	=>
	(printout t "Launch Windows in Safe Mode" crlf)
	(save-facts "LogFile.dat"))
	
(defrule windowsRepair
	(computer_state(error_num 30)(error_type Windows repair)(error_condition Y))
	=>
	(printout t "Launch Windows Repair" crlf)
	(save-facts "LogFile.dat"))
	
(defrule scanHDD
	?f22 <- (computer_state(error_num 29)(error_type Scan HDD)(error_condition Y))
	=>
	(printout t "Scan HDD for any errors. Is the HDD error free? Y/N" crlf)
	(bind ?input(read))
	(modify ?f22(error_condition ?input))
	(open "ErrorStates.dat" testfile "a")
	(if (or(=(str-compare ?input "Y")0)(=(str-compare ?input "y")0))
		then
		(assert (computer_state(error_num 34)(error_type recover MBR and File Systems)(error_condition Y)))
		(printout testfile "Error State: " 34 crlf "State Type: recover MBR and File Systems" crlf "Condition: " ?input crlf crlf)
		else
		(assert (computer_state(error_num 28)(error_type HDD broken)(error_condition Y)))
		(printout testfile "Error State: " 28 crlf "State Type: HDD broken" crlf "Condition: " ?input crlf crlf))
		(close testfile))
		
(defrule recoverMBRandFileSystems
	(computer_state(error_num 34)(error_type recover MBR and File Systems)(error_condition Y))
	=>
	(printout t "Recover Master Boot Record and File System Tables from Windows" crlf)
	(save-facts "LogFile.dat"))