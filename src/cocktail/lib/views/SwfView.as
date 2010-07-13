package cocktail.lib.views 
{
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.GraphSlave;

	import flash.display.MovieClip;

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class SwfView extends InteractiveView 
	{
		public var swf: MovieClip;
		
		/**
		 * This function is a victim from _src_slave's gunz_complete
		 */
		override protected function source_loaded( bullet: ASlaveBullet ) : void
		{
			swf = MovieClip( GraphSlave( bullet.owner ).content );
		}

		override protected function _instantiate_display() : *
		{
			if( !src ) return sprite;
			
			sprite = super._instantiate_display( );
			
			return sprite.addChild( swf );
		}
	}
}
