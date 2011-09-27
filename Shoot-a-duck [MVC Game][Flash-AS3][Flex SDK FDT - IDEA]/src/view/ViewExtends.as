package view {
  import base.Model;
  import base.View;
  import base.trace_s;

  import com.greensock.TimelineMax;
  import com.greensock.TweenMax;

  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.MouseEvent;

  public class ViewExtends extends View {
	// Модель
	private var _model : *;
	// Сцена
	private var _stage : Stage;
	// Объекты для игры
	private var _objectForPlay : Class;
	// Объекты для обновления
	private var _objForUpdate : Object;
	// Объекты на сцени
	private var _objOnStage : Object = new Object();
	// Ссылки на текстовые объекты
	private var _textObj : Object = new Object();
	// Ссылка на звуки
	private var _objSound : Object = new Object();
	// Объекты на сцени
	private var _timeline : DisplayObjectContainer;
	// Переменная для анимации движения
	private var timeLineDucks : TimelineMax = new TimelineMax({});

	/**
	 * В конструкторе вызываем родителя и сохраняем переменные для игры 
	 * @param		m, s, t, textObj, objSound
	 */
	public function ViewExtends(m : Model = null, s : Stage = null, t : *=null, textObj : Object = null, objSound : Object = null) {
	  super(m, s);
	  _model = m;
	  _stage = s;
	  _timeline = t;
	  _textObj = textObj;
	  _objSound = objSound;
	  _objForUpdate = _model.dataUpdate;
	  // Иницилизируем игру, добавляем уток
	  addDucks();
	  // Обновлем параметры очков
	  updateView();
	}

	/**
	 * Переписываем родительскую функцию обновления сцены 
	 * @param		event
	 */
	override public function updateView(event : Event = null) : void {
	  _objForUpdate = _model.dataUpdate;
	  if (event != null) {
		_textObj.shots.text = _model.score.shots;
		_objSound.shots.play();
	  }
	  if (_objForUpdate['shoot'] != undefined) {
		_textObj.ducks.text = _model.score.ducks;
		if (_objOnStage[String(_objForUpdate['shoot'].name)] != undefined) {
		  _textObj.score.text = _model.score.score;
		  _textObj.hits.text = _model.score.hits;
		  duckShoot(_objForUpdate['shoot']);
		}
	  }
	}

	/**
	 * Добавляем объекты на сцену из модели
	 */
	public function addDucks() : void {
	  _objForUpdate = _model.dataUpdate;
	  var betweenSec : Number = 0;
	  var ducksCount : Number = 0;
	  for (var i:String in _objForUpdate) {
		for (var j : Number = 0;j < _objForUpdate[i]['count'];j++) {
		  ducksCount++;
		  var tmp : Object = new Object();
		  tmp = initObjectForPlay(_objForUpdate[i].mc, _objForUpdate[i].objY, _objForUpdate[i].animation, _objForUpdate[i].at, _objForUpdate[i].speedSec, _objForUpdate[i].between, _objForUpdate[i].score);
		  _objOnStage[String(tmp.name)] = 'duck';
		}
	  }
	  _model.ducksCount = ducksCount;
	}

	/**
	 * Инициализируем объекты на сцене
	 * Определяем глубину объекта
	 * И добавляем дальше или ближе объект (утку) 
	 * @param		objectForPlay, objY, animation, at, speedSec, between, score
	 */
	public function initObjectForPlay(objectForPlay : *, objY : Number, animation : String, at : DisplayObject, speedSec : Number, between : Number, score : Number) : * {
	  var index : Number = _timeline.getChildIndex(at) + 1;
	  objectForPlay.score = score;
	  objectForPlay.x = _stage.stageWidth;
	  objectForPlay.y = objY;
	  objectForPlay = _timeline.addChildAt(objectForPlay, index);
	  duckSwim(objectForPlay, speedSec, between, objY);
	  return objectForPlay;
	}

	/**
	 * Добавляем анимацию плавания 
	 * @example
	 * @param		objectForSwim, timeForSwim, between, objY
	 */
	public function duckSwim(objectForSwim : *=null, timeForSwim : Number = 4, between : Number = 0, objY : Number = 0) : * {
	  timeLineDucks.insert(TweenMax.to(objectForSwim, timeForSwim, {repeat:-1/*,yoyo:true,*/, x:-_stage.stageWidth * 0.8, delay:between}));
	}

	/**
	 * Стреляем в утку и показываем анимацию 
	 * @param		objectForKill
	 */
	public function duckShoot(objectForKill : *) : void {
	  TweenMax.to(objectForKill, .7, {overwrite:true, rotation:5, scaleY:0.1, y:objectForKill.y + objectForKill.height, bevelFilter:{blurX:10, blurY:10, strength:1, distance:10}});
	  _objSound.kill.play();
	}
  }
}
