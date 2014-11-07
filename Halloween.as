package  {
	import flash.geom.Vector3D;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ihart.event.*;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Halloween {

		//set up the socket with localhost, using port 5204
		private var hostName:String = "localhost";
	  	//private var hostName:String = "192.168.10.1"; //hallway
        private var port:uint = 5204;
		
		//set up a cvManager to handle our CVEvents
		private var cvManager : CVManager;
		
		//the maximum x and y offset of the pumpkins
		private var yOffsetMax = 50;
		private var xOffsetMax = 50;
		
		// create variable for a scary sound and link it to the audio file
		private var scarySound:Sound = new Sound(new URLRequest("Sound/scary_sound.mp3"));
		// create a SoundChannel for the sound
		private var soundChannelScary : SoundChannel;
		// create a boolean for the sound that tells whether or not the the sound currently being played
		private var playingS : Boolean = false;
		// create a timer for the sound that will be set to correspond to the length of the audio clip
		private var timerS : Timer;
		
		//create a vector of pumpkins
		private var pumpkins: Vector.<Pumpkin> = new Vector.<Pumpkin>();
		//create a variable to hold the Skeleton symbol
		var currentSkeleton: Skeleton; 

		//might not need this since we only need one symbol to show up
		private var skeletons: Vector.<Skeleton> = new Vector.<Skeleton>(); 
		
		private var firstTimer:Timer = new Timer(15000,1); //this timer will trigger the "scary" part
		
		private var secondTimer:Timer = new Timer(15000,1); //this timer will trigger the "game" part

		//WHAT IS THE TIMER FOR THE SOUND DOING?? FIGURE THIS OUT
		
		/**
		* Constructor initializes the cvManager and adds an event listener to it.
		*/
	
		public function Halloween() {
					cvManager = new CVManager(hostName, port);
			cvManager.addEventListener(CVEvent.SHELL, getData);
			//scare is the funtion that will define what happen1 ks when the timer ends (or completes)
			firstTimer.addEventListener(TimerEvent.TIMER_COMPLETE, scare); 
			//create timers of the specified length and number of repeats 
			timerS = new Timer(delay, repeat);
				//add event listeners so that when a timer is complete, 
			//a function can be called to change the appropriate boolean back to false
			timerC.addEventListener(TimerEvent.TIMER_COMPLETE, timerCComplete);


			//refresh is the funtion that will define what happens when the timer ends (or completes)
			secondTimer.addEventListener(TimerEvent.TIMER_COMPLETE, refresh); 

		}
		
		
		/**
		* Gets data about a CVEvent and creates pumpkins based on that data.
		*/
		public function getData (e : CVEvent) : void {
			
			trace( "Acquiring data... " );
			var numBlobs : int = e.getNumBlobs();
			var blobX : Number;
			var blobY : Number;
			var rot : Number;
			var currentPumpkin : Pumpkin;
			
			//for every blob there is on the screen
			for (var i : int = 0; i < numBlobs; i++) {
				
				currentPumpkin = new Pumpkin();
				
				//save the blob's x and y values
				blobX = e.getX(i);
				blobY = e.getY(i);
				
				//add a random rotation to the pumpkin (between 0 and 60 degrees)
				rot = Math.random() * 60;
				currentPumpkin.rotation = rot;
				
				//add the new flower to the scene
				addChild(currentPumpkin);
				
				//generate the new pumpkin's x and y based on the blob's x and y
				currentPumpkin.x = generateOffset(blobX, xOffsetMax);
				currentPumpkin.y = generateOffset(blobY, yOffsetMax);
				
				//add the new pumpkin to the vector
				pumpkins.push(currentPumpkin);
				
				//remove any old pumpkins
				removeOld();
			}
			
			firstTimer.start(); 
		}
		
		/**
		* Removes pumpkins that have disappeared from view from the screen and the vector.
		**/
		public function removeOld () : void {
			
			//for every pumpkin in the vector
			for (var i : int = 0; i < pumpkins.length; i++) {
				
				//if the reference portion of the pumpkin is not visible
				if (pumpkins[i].currentFrame == 20) {
					
					//remove the flower from the screen
					removeChild(pumpkins[i]);
					
					//remove the pumpkin from the vector
					pumpkins.splice(i, 1);
				}
			}
		}
		
		/**
		* Generates a random offset for a pumpkin's x or y value.
		**/
		public function generateOffset (initialNum: Number, maxOffset: Number): Number {
			
			//set the amount of offset randomly
			var offset : Number = Math.random() * maxOffset;
			
			//set the sign of the offset (0 is negative, 1 is positive)
			var sign : int = Math.floor(Math.random() * 2);
			
			if (sign == 0) {
				return initialNum - offset;
			}
			
			return initialNum + offset;
		}
		
		
	private function refresh(e:TimerEvent):void {
					
					//remove it from the screen
					removeChild(currentSkeleton);
					
					//remove it from the array 
					constellations.splice(i, 1);					
					
	}
	
	private function scare(e:TimerEvent):void{
		
		currentSkeleton = new Skeleton(); 
		
		addChild(currentSkeleton);
		
		//ADD SOUND AT SAME TIME THAT SKELETON SHOWS UP
		trace("PLAY Scary sound");
						//play the audio clip found in soundChannelScary
						soundChannelScary = scarySound.play();
						//change the boolean playingS to true
						playingS = true;
						//start the timer for S
						timerS.start();
		//generate the new pumpkin's x and y based on the blob's x and y
		//NO LONGER RANDOM
		currentSkeleton.x =0;  
		//ADD THE IMAGE TO THE CENTER ONCE WHAT ARE THE X AND Y coordinates for the center?
		currentSkeleton.y = 0; 
				
				//add the new pumpkin to the vector
		skeletons.push(currentSkeleton);
		
		secondTimer.start(); 
				
		}
	}	
		
}
		

		

 
