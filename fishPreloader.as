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
			} // end function infoReady
		
		public function imageLoaded(ev:Event):void{
			//event.complete
			addChild( loader );
			//add what you loaded to the stage
			//remove all the preloader stuff
			fish_mc.parent.removeChild(fish_mc);
			background_mc.parent.removeChild(background_mc);
			} // end function imageLoaded
		
		public function loading(ev:ProgressEvent):void{
			//ProgressEvent.PROGRESS
			pct = ev.bytesLoaded/ev.bytesTotal;
			var newPos:Number = pct * stage.stageWidth;
			fish_mc.x = newPos;
			// give the fish some random verticle movement
			ylev = Math.random() * 0.09 - 0.085;
			fish_mc.y = fish_mc.y + ylev;
			// only issue a new bubble at a whole percentage value
			if (Math.round(pct*100) != cnt) {
				
				var mc:MovieClip = new bubble();
				var strPct:String = Math.round( pct * 100).toString();
				mc.bubble_txt.text = strPct + " %";
				mc.x = newPos + 22;
				mc.y = fish_mc.y - 42; // (-12)352;
//				mc.scaleX = mc.scaleY = 0;
				cnt = Math.round(pct*100);
				mc.z = 100;
				addChild(mc);
				
				} // end if
			} // end function loading
		
		public function fileRead(ev:IOErrorEvent):void{
			//IOErrorEvent.IO_ERROR
			loader.removeEventListener(ProgressEvent.PROGRESS, loading);
			background_mc.error_txt = "404 ERROR!!!!";
			} // end function fileRead
		
		public function httpReady(ev:HTTPStatusEvent):void{
			//HTTPStatusEvent.HTTP_STATUS
			if( ev.status != 0){
			background_mc.error_txt = String(ev.status) + " ERROR!!!!";
			} // end if
			
			if( ev.status == 404){
				//write a message to the user
				loader.removeEventListener(ProgressEvent.PROGRESS, loading);
				background_mc.error_txt = "404 ERROR!!!!";
				} // end if
			} // end function httpReady
		
	} // end class fishPreloader
	
} // end package
