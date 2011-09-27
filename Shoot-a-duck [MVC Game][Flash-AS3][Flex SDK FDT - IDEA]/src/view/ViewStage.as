package view {
	import flash.display.MovieClip;
	import flash.display.Sprite;

/**
 * Вид сцены
 */
	public class ViewStage extends Sprite {
		//Задний фон
		public var mcBackground : MovieClip = new mcBackgroundContainer();
		//Кулисы
		public var mcFace : MovieClip = new mcFaceStage();
		//Волны на экране
		public var mcWave1 : Sprite = new mcWaveA();
		public var mcWave2 : Sprite = new mcWaveB();
	
	/**
	 * В конструкторе добавляем объекты в этот класс
	 */
		public function ViewStage() {
			addChild(mcBackground);
			addChild(mcWave1);
			addChild(mcWave2);
			addChild(mcFace);
		}
	}
}
