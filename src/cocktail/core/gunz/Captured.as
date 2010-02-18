package cocktail.core.gunz 
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author nybras | me@nybras.com
	 */
	internal class Captured
	{
		/* ===== VARS ======================================================= */
		private var _gun : Gun;
		private var _bullet_feed : Function;
		private var _target : DisplayObject;
		private var _type : String;

		/* ===== INITIALIZING =============================================== */
		public function Captured(
			gun : Gun,
			target : DisplayObject,
			type : String
		)
		{
			_gun = gun;
			_target = target;
			_type = type;
		
			_target.addEventListener( _type, _proxy );
		}

		/* ===== PROXY ====================================================== */
		private function _proxy( event : Event ) : void 
		{
			var bullet : Bullet;
		
			bullet = _bullet_feed( _gun.type );
			bullet.event = event;
		
			_gun.pull( bullet );
		}

		/* ===== BULLET FEED ================================================ */
		public final function feed( handler : Function ) : void
		{
			_bullet_feed = handler;
		}

		/* ===== DESTROY ==================================================== */
		internal function _destroy() : void
		{
			_target.removeEventListener( _type, _proxy );
		}
	}
}