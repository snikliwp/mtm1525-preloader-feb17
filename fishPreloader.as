package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	
	public class fishPreloader extends MovieClip {
		
		public var loader:Loader = new Loader();
		public var pct:Number = 0;
		public var cnt:Number = 1;
		public var ylev:Number = 0;
		
		
		public function fishPreloader() {
			// constructor code
			
			var req:URLRequest = new URLRequest("simFish-as2-version.swf");
			loader.contentLoaderInfo.addEventListener(Event.INIT, infoReady);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loading);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fileRead);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpReady);
			//go get the file
			loader.load(req);

		} // end function fishPreloader
		
		public function infoReady(ev:Event):void{
			//event.init
			trace("Image info is ready. width:" + ev.target.width);
		} // end function infoReady
		
		public function imageLoaded(ev:Event):void{
			//event.complete
			addChild( loader );
			//add what you loaded to the stage
			fish_mc.visible = false;
			//hide your preloader
			trace("Image could be added to the stage now.");
		} // end function imageLoaded
		
		public function loading(ev:ProgressEvent):void{
//trace("In function loading: ");
			//ProgressEvent.PROGRESS
			pct = ev.bytesLoaded/ev.bytesTotal;
			var newPos:Number = pct * stage.stageWidth;
			fish_mc.x = newPos;
			
			ylev = Math.random() * 0.09 - 0.085;
			trace("ylev = ", ylev);
			fish_mc.y = fish_mc.y + ylev;
			
			if (Math.round(pct*100) != cnt) {
				
				var mc:MovieClip = new bubble();
				
				var strPct:String = Math.round( pct * 100).toString();
				mc.bubble_txt.text = strPct + " %";
				mc.x = newPos + 22;
				mc.y = fish_mc.y + 12; // 352;
				mc.scaleX = mc.scaleY = 0;
				cnt = Math.round(pct*100);
				addChild(mc);
				
			} // end if
		} // end function loading
		
		public function fileRead(ev:IOErrorEvent):void{
			//IOErrorEvent.IO_ERROR
			trace("Could not open file. " + ev.text );
			loader.removeEventListener(ProgressEvent.PROGRESS, loading);
//				Bubble.Bubble_txt = "404 ERROR!!!!";
		} // end function fileRead
		
		public function httpReady(ev:HTTPStatusEvent):void{
			//HTTPStatusEvent.HTTP_STATUS
			trace("HTTP status code is " + ev.status);
			if( ev.status != 0){
				trace(" from " + ev.responseURL);
			} // end if
			
			if( ev.status == 404){
				//write a message to the user
				loader.removeEventListener(ProgressEvent.PROGRESS, loading);
//				Bubble.Bubble_txt = "404 ERROR!!!!";
			} // end if
		} // end function httpReady
		
//		public function goLoopy(ev:Event):void{
//			//add clouds at the base of the rocket
//			var _x:Number = launcher_mc.x + Math.random() * 20 - 10;	// 10 to 20
//			var _y:Number = launcher_mc.y + Math.random() * 20 - 10;	// 10 to 20
//			//var _x:Number = Math.random() * 20 - 10;	// 10 to 20
//			//var _y:Number = Math.random() * 20 - 10;	// 10 to 20
//			var _rot:Number = Math.random() * 360;							// 0 to 360
//			var _scale:Number = Math.random() * 0.8 + 0.2;  //between 20% and 100%
//			var c:MovieClip;
//			//if( Math.round(Math.random()) == 1){
//			if( pct < 0.50){
//				 c = new Cloud();
//			}else{
//				c = new CloudB();
//			}  // end else
//			c.rotation = _rot;
//			c.scaleX = c.scaleY = _scale;
//			c.x = _x;
//			c.y = _y;
//			addChild(c);
//			
//		} // end if
		
//			} // end function goLoopy
		
		
		
		
		
		
		
		
		
	} // end class fishPreloader
	
} // end package
