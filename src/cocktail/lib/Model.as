package cocktail.lib 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.base.MVL;
	import cocktail.lib.gunz.ModelBullet;

	/**
	 * @author hems
	 * @author nybras
	 */
	public class Model extends MVL
	{
		/* LOAD */
		
		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function before_load( request: Request ) : Boolean
		{
			return true;
		}

		/**
		 * Load model scheme.
		 */
		public function load_scheme( process : Request ) : Model
		{
			process;
			load_uri( xml_path ).gunz_complete.add( after_load );
			return this;
		}

		/**
		 * Load all datasources needed for the request.
		 */
		public function load_data( process : Request ) : Model
		{
			process;
			// load datasources
			return this;
		}

		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function after_load( bullet : ASlaveBullet ) : void
		{
			gunz_load_complete.shoot( new ModelBullet( ) );
			
			if( !_scheme )
				_scheme = new XML( TextSlave( bullet.owner ).data );
			
//			log.debug( "Model scheme loaded!" );
//			log.debug( _scheme.toXMLString() );		
		}

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		public function get xml_path() : String
		{
			var path : String;
			path = config.path( ".xml" ) + "models/";
			path += classname.toLowerCase( ).replace( "model", "" ) + ".xml";
			
			return path;
		}
	}
}