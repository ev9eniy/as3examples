package base {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	public class Controller {
		public static var keyObject:Object=new Object();
		private var _objectMovingKey:Object=new Object();
		private var _stage:Stage;
		private var _model:*;
		private var _cursor_obj:Object;

		public function Controller(s:Stage,m:*,objectMovingKey:Object=null,btnControll:Object=null) {
			_stage=s;
			_model=m;
			if(objectMovingKey){
				_objectMovingKey=objectMovingKey;
				_stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
				_stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
				}
			if (btnControll) 
				setListenerToControl(btnControll);
		}
		
		public function initCursor(realtime:Boolean=false):void{
			_cursor_obj=new Object();
			_cursor_obj.realtime=realtime;
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCursor);
		}

		private function dragCursor(e:MouseEvent):void {
			_model.cursorUpdate(_stage.mouseX,_stage.mouseY);
			if (_cursor_obj.realtime)
				e.updateAfterEvent();
		}
		
		public function setListenerToControl(btnControll:Object):void{
			for(var i:String in btnControll) {
					connectObjectToFunction(
						btnControll[i]['btn'],
						btnControll[i]['event_type'],
						btnControll[i]['function_name']
					);
			}
 		}		

		public function connectObjectToFunction(movieClip:*,event_type:*,function_name:String):void{			
		/*		
			switch (function_name){
			case 'restartGame':
					movieClip.addEventListener(event_type,restartGame);
					break;
			}						
		*/		
		}
				
		private function keyDown(e:KeyboardEvent):void {
			keyPress(e.keyCode,true);
		}

		private function keyUp(e:KeyboardEvent):void {
			keyPress(e.keyCode,false);
		}
		
		protected function controllerUpdated(key:String,state:Boolean):void {
			
		}

		private function keyPress(key:int,keyPressed:Boolean):void {
			if (_objectMovingKey[key]==undefined) {
				return;
			}
			if (keyPressed) {
				if (! keyObject[key])
					keyObject[key]=keyPressed;
					controllerUpdated(_objectMovingKey[key],true);
				} else {
					keyObject[key]=keyPressed;
					controllerUpdated(_objectMovingKey[key],false);
				}
			
		}

	}
}