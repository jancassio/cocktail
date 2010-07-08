package cocktail.lib.views 
{
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.lib.View;

	import flash.display.Bitmap;

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class ImgView extends View
	{
		public var img: Bitmap;
		
		/**
		 * This function is a victim from _src_slave's gunz_complete
		 */
		override protected function _source_loaded( bullet: ASlaveBullet ) : void
		{
			img = Bitmap( GraphSlave( bullet.owner ).content );
		}

		override protected function _instantiate_display() : Boolean 
		{
			super._instantiate_display( );

			trace( "where are me ?" );			
			sprite.addChild( img );
			
			return true;
		}
	}
}
