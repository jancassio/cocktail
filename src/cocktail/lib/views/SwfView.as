package cocktail.lib.views 
{
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.lib.View;

	import flash.display.MovieClip;

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class SwfView extends View 
	{
		public var swf: MovieClip;
		
		/**
		 * This function is a victim from _src_slave's gunz_complete
		 */
		override protected function _source_loaded( bullet: ASlaveBullet ) : void
		{
			swf = MovieClip( GraphSlave( bullet.owner ).content );
		}

		override protected function _instantiate_display() : Boolean 
		{
			super._instantiate_display( );
			
			if( !swf ) return false;
			
			sprite.addChild( swf );
			
			return true;
		}
	}
}
