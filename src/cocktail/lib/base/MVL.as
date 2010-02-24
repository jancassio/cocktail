package cocktail.lib.base 
{
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.Slave;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.core.slave.slaves.TextSlave;

	public class MVL extends MVCL
	{
		/* VARS */
		protected var _scheme : XML;
		private var _load_queue : Slave;
		private var _is_queue_opened : Boolean;

		/**
		 * 
		 */
		public function load_queue( opening : Boolean = false ) : Slave
		{
			if( opening )
			{
				_is_queue_opened = true;
				_load_queue = new Slave( false );
			}
			else
				_is_queue_opened = false;
			
			return Slave( _load_queue.load( ) );
		}

		/**
		 * 
		 */
		public function load_uri( uri : String ) : ASlave
		{
			var slave : ASlave;
			
			switch( uri.toLowerCase( ).split( "." ).pop( ) )
			{
				case "jpg": 
					slave = new GraphSlave( uri, _is_queue_opened );
				case "jpeg": 
					slave = new GraphSlave( uri, _is_queue_opened );
				case "png": 
					slave = new GraphSlave( uri, _is_queue_opened );
				case "gif": 
					slave = new GraphSlave( uri, _is_queue_opened );
				case "swf": 
					slave = new GraphSlave( uri, _is_queue_opened );
				case "xml": 
					slave = new TextSlave( uri, _is_queue_opened );
			}
			
			if( _is_queue_opened )
				_load_queue.append( slave );
			else
				ISlave( slave ).load( );
			
			return slave;
		}
	}
}
