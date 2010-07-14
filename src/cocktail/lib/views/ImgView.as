package cocktail.lib.views 
{
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.GraphSlave;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class ImgView extends InteractiveView
	{
		public var img: Bitmap;
		
		/**
		 * This function is a victim from _src_slave's gunz_complete.
		 */
		override protected function source_loaded( bullet: ASlaveBullet ) : void
		{
			img = Bitmap( GraphSlave( bullet.owner ).content );
		}

		override protected function _instantiate_display() : * 
		{
			return Sprite( super._instantiate_display( ) ).addChild( img ); 
		}
	}
}
