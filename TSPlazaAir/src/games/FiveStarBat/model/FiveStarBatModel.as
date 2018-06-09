package games.FiveStarBat.model
{
	import cx.gamebase.model.GlobalModel;

	public class FiveStarBatModel extends GlobalModel
	{
		public static function _getInstance() : FiveStarBatModel
		{
			return _instance == null ? _instance = new FiveStarBatModel() : _instance;
		}
		public function FiveStarBatModel()
		{
			super();
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			return true;
		}
	}
}