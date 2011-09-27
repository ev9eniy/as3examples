/**
 * ev9eniy.info 2011-03-03
 * Тренировка в создании Flash игр
 * Игра Убей утку
 */
package {	
	import controller.ControllerExtends;
	import model.ModelExtends;
	import view.ViewDucks;
	import view.ViewExtends;
	import view.ViewStage;
	import flash.display.Sprite;
	/**
	 * Инициализируем игру от класса Спрайта	 
	 */
	public class Game extends Sprite {
		public var model : ModelExtends;
		public var view : ViewExtends;
		public var controller : ControllerExtends;
		//Сцена игры из SWC библиотеки
		public var mcBackground : ViewStage = new ViewStage();

/**
 * В конструкторе центрируем сцену и добавляем в класс контейнер. 
 */
		public function Game() {
			mcBackground.y = stage.stageHeight / 2;
			mcBackground.x = stage.stageWidth / 2;
			addChild(mcBackground);
			/**
			 * Инициализируем модель
			 */
			model = new ModelExtends(stage,
			/*objectOnStage*/ {
				'11':{objY:-60, at:mcBackground.mcBackground, speedSec:1.5, between:1, count:1, mc:new ViewDucks('bdDuck3'), score:20}
				 ,'12':{objY:-60, at:mcBackground.mcBackground, speedSec:1.9, between:3, count:1, mc:new ViewDucks('bdDuck3'), score:20}
				 ,'13':{objY:-60, at:mcBackground.mcBackground, speedSec:1.5, between:2, count:1, mc:new ViewDucks('bdDuck3'), score:20}
				, '21':{objY:-10, at:mcBackground.mcWave1, speedSec:3.8, between:0, count:1, mc:new ViewDucks('bdDuck2'), score:10}
				, '22':{objY:-10, at:mcBackground.mcWave1, speedSec:3, between:2, count:1, mc:new ViewDucks('bdDuck2'), score:10}
				, '23':{objY:-10, at:mcBackground.mcWave1, speedSec:3, between:3, count:1, mc:new ViewDucks('bdDuck2'), score:10}
				, '31':{objY:55, at:mcBackground.mcWave2, speedSec:7.5, between:4, count:1, mc:new ViewDucks('bdDuck1'), score:5}
				, '32':{objY:55, at:mcBackground.mcWave2, speedSec:7.1, between:2, count:1, mc:new ViewDucks('bdDuck1'), score:5}
				, '33':{objY:55, at:mcBackground.mcWave2, speedSec:7.4, between:3, count:1, mc:new ViewDucks('bdDuck1'), score:5}
			}
			/*objectParam*/, {ducks:0, shots:0, hits:0, score:0}
				);
				/**
				 * Инициализируем вид передавай модель и объект для манипуляции
				 */
			view = new ViewExtends(model, stage, mcBackground,
			/*textObj*/ {
			'reset':mcBackground.mcFace.bStop,'score':mcBackground.mcFace.tScore, 'shots':mcBackground.mcFace.tShots, 'hits':mcBackground.mcFace.tHits, 'ducks':mcBackground.mcFace.tDucks
			 },
			/*Sound*/ { 'shots':new mp3Shots(), 'kill':new mp3GotOne()});
			/**
			 * Инициализируем контроллер для связки мыши и с моделью 
			 */
			controller = new ControllerExtends(stage, model);
		}
	}
}
