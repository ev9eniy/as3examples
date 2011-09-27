package controller {
  import base.Controller;
  import flash.display.Stage;
  import flash.events.MouseEvent;

  /**
   *  Контроллер действий пользователя
   */
  public class ControllerExtends extends Controller {
	public var model:*;
	/**
	 * Связываем действие с моделью 
	 * @param		s, m, objectMovingKey, btnControll
	 */
	function ControllerExtends(s:Stage=null,m:*=null,objectMovingKey:Object=null,btnControll:Object=null) {
	  super(s,m,objectMovingKey,btnControll);
	  model=m;
	  s.addEventListener(MouseEvent.CLICK,model.shoot);
	}		
  }
}
	
