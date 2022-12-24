state("sh3")
{
	byte fadeInState: "sh3.exe", 0x32D0D0;     // 3 = loading, 4 = black screen, 5 = gameplay, 9 = fade-in part of white transition betwwen Office building and Street
	byte sexyKills: "sh3.exe", 0x6CE66EE;      // Sexy Beam kills
	byte onscreenEvents: "sh3.exe", 0x7CC660;  // 1 = title screen, 2 = loading, 6 = inventory, 9 = maps, 10 = memos, 11 = 2D Screens, 14 = Options Menu, 19 = save 29 = load
	byte pauseMenu: "sh3.exe", 0x49E893;       // 0 = not paused 1 = paused 
	byte textType: "sh3.exe", 0x7A9600;        // 0 = No Text, 1 = paused text, 2 = unpaused text, 3 = paused item text, 4 = cutscene, 5 = loading, 6 = 2D screens
	byte IsDead : 0x6D2C662; 				   // 0 Alive, 1/2 Dead

	int cutsceneIndex: "sh3.exe", 0x32C8B4;	   // 1 = Heather in Amusement park, 4 = Heather's toilet escape
	int roomIndex: "sh3.exe", 0x32D2C0;        // 150 = Apartments
	
	float IGT: "sh3.exe", 0x6CE66F4; // Lazy method of testing whether 2D screens should tick IGT, still allows for alt-space to be used on puzzles and keypads
}

startup
{
	vars.timerModel = new TimerModel { CurrentState = timer };
}

init
{

}

update
{
	vars.isLoading = false;
	if (current.fadeInState != 5 && current.fadeInState < 12 && current.fadeInState != 9 
		|| current.onscreenEvents == 1 || current.onscreenEvents == 2 || current.onscreenEvents == 9 || current.onscreenEvents == 10 || (current.onscreenEvents == 11 && current.IGT == old.IGT) || current.onscreenEvents == 14
		|| current.cutsceneIndex > 0 || (current.pauseMenu == 1 && current.onscreenEvents != 6) || current.textType == 1 || current.textType == 3 || current.IsDead != 0) {
		
		vars.isLoading = true;
	}
	
	if (current.onscreenEvents == 1) {
		
		//vars.timerModel.Reset(); <-- Disabling this allows continues to be used in a run. 
	}
}

start
{
	if (current.cutsceneIndex == 0 && old.cutsceneIndex == 1 || current.cutsceneIndex == 0 && old.cutsceneIndex == 4) {

		return true;
	}				
}

split
{
	if (current.cutsceneIndex == 77 || current.roomIndex == 150 && current.sexyKills > 30) {

		return true;
	}	
}

reset
{

}

isLoading
{
	return vars.isLoading;
}