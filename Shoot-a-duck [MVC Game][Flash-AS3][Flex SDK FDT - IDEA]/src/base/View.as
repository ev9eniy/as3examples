package base{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Mouse;

	public class View {
		private var _model:*;
		private var _cursor:*;
		private var _stage:Stage;

		public function View(m:*,s:Stage) {
			_model=m;
			_stage=s;
			_model.addEventListener(Model.MODEL_CHANGE, updateView);
		}

		public function initNewCursor(new_crusor:*):void {
			_cursor=new_crusor;
			_stage.addChild(_cursor);
			_cursor.enabled=false;
			Mouse.hide();
			_model.addEventListener(Model.CURSOR_MOVE, updateCursor);
		}
		
		public function updateView(event:Event = null):void {
		}
		
		public function updateCursor(event:Event = null):void {
			_cursor.x=_model.cursorX;
			_cursor.y=_model.cursorY;
		}

		public function set model(m:*):void {
			_model=m;
		}

		public function get model():* {
			return _model;
		}
	}
}