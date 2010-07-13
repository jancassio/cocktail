package cocktail.core.router 
{
	import cocktail.Cocktail;
	import cocktail.core.request.Request;
	import cocktail.core.request.RequestAsync;
	import cocktail.lib.Controller;

	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;

	/**
	 * Handles all routing operations.
	 * @author nybras | nybras@codeine.it
	 * @author hems | hems@henriquematias.com
	 */
	public class Router
	{
		/* VARS */
		private var _initialized : Boolean;

		private var _history : Array;

		private var _index : Number;

		protected var _cocktail : Cocktail;

		public function boot( cocktail : Cocktail ) : Router
		{
			_history = new Array( );
			_index = -1;
			
			_cocktail = cocktail;
			
			return this;
		}

		/**
		 * Initializes the router, listening for SWFAddress.
		 */
		public function init() : void
		{
			if( _initialized )
				return;
			
			_initialized = true;
			
			if( _cocktail.config.is_in_browser )
				SWFAddress.addEventListener( SWFAddressEvent.CHANGE, _addressbar_change );
		}

		/* HISTORY HANDLERS */
		
		/**
		 * Check if theres external pages enough to perform a "back" operation.
		 * @return <code>true</code> if yes, <code>false</code> otherwise.
		 */
		public function get has_back() : Boolean
		{
			return( index > 0 );
		}

		/**
		 * Check it theres external pages enough to perform a "forward"
		 * operation.
		 * * @return <code>true</code> if yes, <code>false</code> otherwise.
		 */
		public function get has_forward() : Boolean
		{
			return( index < history.length );
		}

		/**
		 * Go forward one page.
		 */
		public function forward() : void
		{
			_index++;
			SWFAddress.forward( );
		}

		/**
		 * Go back one page.
		 */
		public function prev() : void
		{
			_index--;
			SWFAddress.back( );
		}

		/**
		 * Gets the history.
		 * @return	The history array.
		 */
		public function get history() : Array
		{
			return _history;
		}

		/**
		 * Gets the current history index.
		 * @return	The current history index.
		 */
		public function get index() : Number
		{
			return _index;
		}

		/* REQUEST HANDLERS */
		
		/**
		 * Redirects the application to the given request.
		 * @param request	Request to redirect the application to. 
		 */
		public function get( uri : String, silent : Boolean = false ) : void
		{
			var request : Request;
			
			request = new Request( Request.GET, uri, silent ).boot( _cocktail );
			
			if( _cocktail.config.is_in_browser && !silent )
			{
				if( request.route.mask != SWFAddress.getValue( ) )
					SWFAddress.setValue( request.route.mask );
			}
			else
				run( request );
		}

		public function post( uri : String, data : * ) : RequestAsync
		{
			// TODO: Implement / document Assyncronous post
			return new RequestAsync( uri, data ).boot( _cocktail );
		}

		/* LOCATION HANDLERS */
		
		/**
		 * Gets the current external url location.
		 * @return	The current external url location.
		 */
		public function get location() : String
		{
			return SWFAddress.getValue( );
		}

		/**
		 * Listen the browser url changes( SWFAddress ).
		 * @param event	SWFAddressEvent.
		 */
		private function _addressbar_change( event : SWFAddressEvent ) : void 
		{
			var request : Request;
			var uri : String;
			
			if( event.value != '/' )
				uri = event.value;
			else
				uri = _cocktail.config.default_uri;
				
			request = new Request( Request.GET, uri ).boot( _cocktail );
			
			history.push( request );
			_index++;
			
			run( request );
		}

		private function run( request : Request ) : * 
		{
			var ctl : Controller;
			
			ctl = _cocktail.factory.controller( request.route.api.controller );
			 
			return ctl.run( request );
		}
	}
}