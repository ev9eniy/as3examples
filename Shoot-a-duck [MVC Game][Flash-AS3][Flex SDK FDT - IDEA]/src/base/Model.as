package base{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Stage;

	public class Model extends EventDispatcher {
		public static const MODEL_CHANGE:String="modelChange";
		public static const CURSOR_MOVE:String="cursorMove";
		private var _stop:Boolean;
		private var _cursor_obj:Object;
		private var _stage:Stage;

		public function Model(s:Stage) {
			_stage=s;
			_stop=true;
			_cursor_obj=new Object();
		}

		public function cursorUpdate(x:Number,y:Number):void{
			_cursor_obj.cursorX=x;
			_cursor_obj.cursorY=y;
			dispatchEvent(new Event(Model.CURSOR_MOVE));
		}
		
		public function get cursorX():Number {
			return _cursor_obj.cursorX;
		}

		public function get cursorY():Number {
			return _cursor_obj.cursorY;
		}		
		
		protected function resumeUpdate():void {
			_stage.addEventListener(Event.ENTER_FRAME, updateObjectPlace);
			_stop=false;
		}

		protected function stopUpdate():void {
			_stage.removeEventListener(Event.ENTER_FRAME, updateObjectPlace);
			_stop=true;
		}
		
		protected function updateModel():void {
			if(!_stop)
				dispatchEvent(new Event(Model.MODEL_CHANGE));
		}
		
		public function controllerMoveObject(modeMoving:*,playMoving:Boolean):void {
		}
	
		protected function updateObjectPlace(e:Event):void {
		}	
		
		public function get objX():Number {
			return 0;
		}

		public function get objY():Number {
			return 0;
		}		
	}
}