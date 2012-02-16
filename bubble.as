package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class bubble extends MovieClip {
		
		public var xvel:Number = 0;
		public var yvel:Number = 0;

	public function bubble() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, goFrame);
		} // end function Bubble
		
		
		public function goFrame(ev:Event):void{
//		trace("in function goFrame: ");
			//move gradually towards the top of the screen
			//drift randomly left or right
			//slowly rotate
			//reduce the alpha slightly
			//when off the top of the screen OR when alpha below 1, remove the event listener and the object
			xvel += Math.random() * 1 - 0.5;
			yvel += Math.random() * 1 - 0.75;
			x += xvel;
			y += yvel;
//			alpha -= Math.random() * 0.01; //up to 1% reduction per frame
//			rotation += Math.random() * 3 - 1.5;
			if(scaleX < 1) {
				scaleX = scaleY = scaleX + .02;
			}// end if

			if(y < 0 || alpha < 0.01){
				removeEventListener(Event.ENTER_FRAME, goFrame);
				parent.removeChild(this);
			}// end if
			
		} // end function Bubble
		
	} // end class Bubble
	
} // end package
