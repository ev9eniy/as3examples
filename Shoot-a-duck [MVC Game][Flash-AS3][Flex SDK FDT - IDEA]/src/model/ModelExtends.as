package model {
  import base.Model;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.MouseEvent;

  /**
   * Расширяем базовую модель для управления функциями для
   * конкретной игры
   */
  public class ModelExtends extends Model {
	private var _objForGame : Object;
	//Передаём виду объекты для обновления
	private var _objForUpdate : Object;
	//Параметры игры
	private var _objParam : Object;
	//Кол-во очков
	private var _score : Number;
	//Параметры игры при инициализации
	private var _objParamSaved : Object;

	/**
	 * В конструкторе класса сохраняем переменный для манипуляций
	 */
	public function ModelExtends(s : Stage=null, objForGame : Object = null, objParam : Object = null,resetName:Object=null) {
	  super(s);
	  _objForUpdate = _objForGame = objForGame;
	  _objParamSaved = _objParam = objParam;
	  _score = 0;
	}
	/**
	 * Модель выстрела, обновляем очки и сообщаем виду об изменениях 
	 */
	public function shoot(e : MouseEvent) : void {
	  _objForUpdate = {'shoot':e.target};
	  _objParam.shots++;			
	  if ("score" in e.target) {
		_objParam.score += e.target.score;
		_objParam.hits++;
		_objParam.ducks--;
	  }
	  dispatchEvent(new Event(Model.MODEL_CHANGE));
	}

	/**
	 * Вид получает данные которые изменились в модели
	 */
	public function get dataUpdate() : Object {
	  return _objForUpdate;
	}

	/**
	 *  устанавливаем кол-во уток
	 */
	public function set ducksCount(ducksCount : Number) : void {
	  _objParam.ducks = ducksCount;
	}

	/**
	 *  Вид получает данные об очках
	 */
	public function get score() : Object {
	  return _objParam;
	}
  }
}
