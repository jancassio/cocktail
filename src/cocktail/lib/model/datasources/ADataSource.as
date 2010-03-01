package cocktail.lib.model.datasources 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.lib.Model;

	public class ADataSource extends Index
	{
		/* GUNZ */
		public var gunz_load_start : Gun; 
		public var gunz_load_progress : Gun; 
		public var gunz_load_complete : Gun;

		private function _init_gunz() : void
		{
			gunz_load_start = new Gun( gunz, this, "load_start" );
			gunz_load_progress = new Gun( gunz, this, "load_progress" );
			gunz_load_complete = new Gun( gunz, this, "load_complete" );
		}

		/* VARS */
		public var id : String; 
		public var inject : String; 
		public var locale : String; 
		public var src : String; 
		protected var _raw : *;
		protected var _model : Model;
		protected var _scheme : XML; 
		protected var _binds : XMLList;

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			_init_gunz( );
			
			return s;		}

		public function ADataSource( model : Model, scheme : XML = null )
		{
			_model = model;
			_scheme = scheme;
		}

		/* LOADING */
		public function load() : void
		{
			var msg : String;
			
			msg = "This method (ADataSource.load) must be overritten by ";
			msg += "superclass.";
			log.fatal( msg );
		}
		
		/* PARSING */
		public function parse() : void
		{
			var msg : String;
			
			msg = "This method (ADataSource.parse) must be overritten by ";
			msg += "superclass.";
			log.fatal( msg );
		}
		
		/* BINDING */
		public function bind() : void
		{
			var msg : String;
			
			msg = "This method (ADataSource.bind) must be overritten by ";
			msg += "superclass.";
			log.fatal( msg );
		}
	}
}