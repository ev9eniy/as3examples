package view {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	/**
	 * Получим имя спрайта из SWC как Sprite
	 * @example
	 * @param Number
	 * @return Bitmap
	 */
	public class ViewDucks extends Sprite {
		private var _score : int;

		public function ViewDucks($name : String) : void {
			// Получаем по имени класс
			var $class : Class = getDefinitionByName($name) as Class;
			addChild(new Bitmap(new $class()));
		}

		/**
		 *  Устанавливаем кол-во очков за убийство утки 
		 * @example
		 * @param		val
		 */
		public function set score(val : int) : void {
			_score = val;
		}

		/**
		 * Получаем очки за убийство утки
		 */
		public function get score() : int {
			return _score;
		}
	}
}
