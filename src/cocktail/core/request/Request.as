package cocktail.core.request 
{
	import cocktail.Cocktail;
	import cocktail.core.router.Route;

	/**
	 * Represents GET and POST requests
	 * 
	 * GET will mostly change the cocktail url, if silent = true browser wont be
	 * notified about the cahnge.
	 * 
	 * POST will mostly submit your actions, to a webpage or even to cocktail. 
	 * 
	 * @author nybras | nybras@codeine.it
	 * @author hems | hems@henriquematias.com
	 */
	public class Request
	{
		/* CONSTANTS */
		
		
		public static const GET : String = "get";

		public static const POST : String = "post";

		/* VARS */
		
		private var _cocktail : Cocktail;

		private var _silent : Boolean;
		
		private var _type : String;

		private var _uri : String;

		private var _route : Route;

		private var _data : Object;

		/* INITIALIZING */
		
		/**
		 * Instiate a Request
		 */
		public function Request(
			type : String,
			uri : String,
			silent: Boolean = false,
			data : * = null
		) : void
		{
			_uri = uri;
			_silent = silent;
			this.type = type;
			this.data = data;
		}

		/* BOOTING */
		
		/**
		 * Boots the Index base class.
		 * @param cocktail	Cocktail reference.
		 */
		public function boot( cocktail : Cocktail ) : *
		{
			_cocktail = cocktail;
			
			uri = _uri;
			
			return this;
		}

		/* GETTERS / SETTERS */
		
		public function get uri() : String
		{
			return _uri;
		}

		/*
		 * Saves a clean_uri, @see RoutesTail::clean_uri
		 */
		public function set uri( uri : String ) : void
		{
			_uri = _cocktail.routes.clean_uri( uri );
			
			( _route = new Route( _uri ) ).boot( _cocktail );
		}

		public function get type() : String
		{
			return _type;
		}

		public function set type( type : String ) : void
		{
			_type = type;
		}

		/*
		 * Data added to request.
		 */
		public function get data() : Object
		{
			return _data;
		}

		/*
		 * Set request Data.
		 * If type == GET object will be serialized and appended to address
		 * i.e. ?name=blah&age=17
		 * 
		 * If type == POST object will be posted 
		 */
		public function set data( data : Object ) : void
		{
			
			if( type == POST )
			{
				_data = data;
			}
			else
			{
				//TODO: save string for GET requests, append it to _uri, and test
				_data = data;
			}
		}

		/*
		 * Everytime uri changes, a new Route is created based on it 
		 */
		public function get route() : Route
		{
			return _route;
		}
		
		/**
		 * If type == GET and silent == true, browser wont be notified about
		 * the cocktail deeplink change.
		 */
		public function get silent() : Boolean
		{
			return _silent;
		}
	}
}