 /*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.core {	import cocktail.config.Config;
	import cocktail.core.loggers.AlconLogger;
	import cocktail.core.loggers.Logger;
	import cocktail.core.loggers.MonsterLogger;
	import cocktail.lib.Controller;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;	

		/**	 * Index class is the base class for almost every class inside cocktail package, specially the MVC core.	 * 	 * @author nybras | nybras@codeine.it	 */	public class Index 	{				/* ---------------------------------------------------------------------			ACCESS RESCRICTIONS		--------------------------------------------------------------------- */				protected namespace restricted;		protected var authorized : Array = new Array();								/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				private static var _config : Config;		private static var _router : Router;		private static var _finder : Function;				public var log : Logger;		public var alcon : AlconLogger;		public var monster : MonsterLogger;						
		/* ---------------------------------------------------------------------			INITIALIZING		--------------------------------------------------------------------- */				/**		 * Creates a new Index instance.		 */		public function Index ()		{			log = new Logger( class_path );			alcon = new AlconLogger( class_path );			monster = new MonsterLogger( class_path );						log = monster;		}								/* ---------------------------------------------------------------------			CONFIG CACHE & LISTENING		--------------------------------------------------------------------- */				/**		 * Caches the application base config.		 * @param config	Config instance reference.		 */		protected function cacheConfig ( config : Config ) : void		{			if ( Index._config == null ) {				Index._config = config;				return;			}			log.warn( "The config has already been cached by Cocktail." );
		}				/**		 * Caches the application router.		 * @param config	Router instance reference.		 */		protected function cacheRouter ( router : Router ) : void		{			if ( Index._router == null ) {				Index._router = router;				return;			}			log.warn( "The router has already been cached by Cocktail." );		}				/**		 * Caches the application finder.		 * @param config	Router instance reference.		 */		protected function cacheFinder ( finder : Function ) : void		{			if ( Index._finder == null ) {				Index._finder = finder;				return;			}			log.warn( "The finder has already been cached by Cocktail." );		}								/**		 * Get the application config.		 * @return	The application config.		 */		final public function get config ( ) : Config		{			return Index._config;		}				/**		 * Get the application router.		 * @return	The application router.		 */		final public function get router ( ) : Router		{			return Index._router;		}								/* ---------------------------------------------------------------------			FUNCTION & DEBUG UTILS		--------------------------------------------------------------------- */				/**		 * Sends all "trace" calls to the log.debug method.		 * @param message	Message to be traced.		 */		public function trace ( ...message ) : void		{			log.debug.apply( log, message );		}				/**		 * Creates a proxy function holding default params.		 * @param method	Method to be handled.		 * @param params	Default params to be passed to method ( these params will be added in *first* place ).		 * @return	The proxy function with the given params.		 */		public function proxy ( method : Function, ...params ) : Function		{			return ( function( ...innerParams ):void			{				method.apply( method.prototype, params.concat( innerParams ) );			} );		}				/**		 * Sweep the entire object, return a formated-string with all object levels & values.		 * @param params	Data to be sweeped.		 * @param level	Sweep cycle.		 * @param buffer	Sweep buffer.		 */		public function tree ( params : *, cycle : int = 0, buffer : String = "" ) : *		{			var output : String;			var tabs : String;			var child : *;			var data : *;			var i : int;						i = 0;			tabs = "";						while ( i++ < cycle )				tabs += "\t";						for ( child in params )			{				data = params[ child ];			    buffer += tabs +"["+ child +"] => "+ ( data is Array ? "[object Array]" : data );			    output = tree( data, ( cycle + 1 ) );							    if ( output != "" )			    	buffer += " {\n"+ output + tabs +"}";								buffer += "\n";			}						return buffer;		}								/* ---------------------------------------------------------------------			AUTH UTILS ( restricted access control )		--------------------------------------------------------------------- */				/**		 * Authenticates a class for restricted methods and/or properties access.		 * @return	If auth suceed sucessfully returns the restricted namespace, otherwise return <code>null</code>.		 */		final public function auth ( caller : Object ) : Namespace		{			var _class : Class;						for each ( _class in this.authorized )				if ( caller is _class )					return restricted;						return null;		}								/* ---------------------------------------------------------------------			UTILS		--------------------------------------------------------------------- */				/**		 * Search the area process (controller) based on the given name.		 * @param name	The areacontroller name ( upper case first ) without sufixes.		 * @return	The found process/controller instance.		 */		public function area ( name : String ) : Controller		{			return Index._finder( name );		}		/**		 * Returns a class reference to the given class path.		 */		public function get_class ( class_path : String ) : Class {			return getDefinitionByName( class_path ) as Class;		}					/**		 * Gets the class name.		 * @return	The class name, without the package notation '::' (package::class).		 */		public function get class_name () : String {			return this.class_path.split( "." ).pop();		}				/**		 * Gets the class path.		 * @return	The class path, with the package notation '::' as (package::class).		 */		public function get class_path () : String {			return ( getQualifiedClassName( this)  as String ).replace( "::", "." );					}
		
		
		
		/* ----------------------------------------------------------------------
			CASTING VALUES
		---------------------------------------------------------------------- */
		
		/**
		 * Cast the given value as <code>Number</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>Number</code>.
		 */
		protected function n ( value : * ) : uint
		{
			return Number ( value );
		}
		
		/**
		 * Cast the given value as <code>int</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>int</code>.
		 */
		protected function i ( value : * ) : int
		{
			return int ( value );
		}
		
		/**
		 * Cast the given value as <code>uint</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>uint</code>.
		 */
		protected function u ( value : * ) : uint
		{
			return uint ( value );
		}
		
		/**
		 * Cast the given value as <code>Boolean</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>Boolean</code>.
		 */
		protected function b ( value : * ) : Boolean
		{
			return Boolean ( value );
		}	}}