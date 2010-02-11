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

package cocktail.core.logger
{

	/**
	 * Log class is only a simple class for tracing messages, and nothing more.
	 * @author nybras | nybras@codeine.it
	 */
	public class Logger
	{
		/* ---------------------------------------------------------------------
		VARS
		--------------------------------------------------------------------- */

		protected var _target_class : String;
		protected var _level : uint;
		protected var _detail : uint;

		
		
		/* ---------------------------------------------------------------------
		INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Logger instance.
		 * @param class_name	Class name to be logged with all log calls.
		 */
		public function Logger( class_name : String )
		{
			_target_class = class_name;
		}

		
		
		/* ---------------------------------------------------------------------
		TREE UTIL
		--------------------------------------------------------------------- */
		
		/**
		 * Sweep the entire object, return a formated-string with all object
		 * levels & values.
		 * @param params	Data to be sweeped.
		 * @param level	Sweep cycle.
		 * @param buffer	Sweep buffer.
		 */
		public function tree(
			params : *,
			cycle : int = 0,
			buffer : String = ""
		) : *
		{
			var output : String;
			var tabs : String;
			var data : *;
			var i : int;
			
			i = 0;
			tabs = "";
			
			while ( i++ < cycle )
				tabs += "\t";
			
			for ( var child : * in params )
			{
				data = params[ child ];
				buffer += tabs + "[" + child + "] => ";
				buffer += ( data is Array ? "[object Array]" : data );
				output = tree( data, ( cycle + 1 ) );
				
				if ( output != "" )
			    	buffer += " {\n" + output + tabs + "}";
				
				buffer += "\n";
			}
			
			return buffer;
		}

		
		
		/* ---------------------------------------------------------------------
		LEVEL & DETAIL (getter / setter )
		--------------------------------------------------------------------- */
		 
		/**
		 * Sets the log level.
		 * @param logLevel	Application default log level (default=5).
		 * 		<br/># 0=disable
		 * 		<br/># 1=fatal
		 * 		<br/># 2=fatal,error
		 * 		<br/># 3=fatal,error,debug
		 * 		<br/># 4=fatal,error,debug,warn
		 * 		<br/># 5=fatal,error,debug,warn,notice
		 * 		<br/># 6=fatal,error,debug,warn,notice,info
		 */
		public function set level( log_level : uint ) : void
		{
			_level = log_level;
		}

		/**
		 * Returns the log level.
		 */
		public function get level() : uint
		{
			return _level;
		}

		
		
		/**
		 * Sets the log detail.
		 * @param logDetail	Application default log detail (default=1).
		 * <br/># 0=Doesnt add any extra prefix besides the log level.
		 * <br/># 1=Adds the 'ClassName' prefix to all log calls.
		 * <br/># 2=Adds a 'packace.a.b.c..ClassName' prefix to all log calls.
		 */
		public function set detail( logDetail : uint ) : void
		{
			_detail = logDetail;
		}

		/**
		 * Returns the log detail.
		 */
		public function get detail() : uint
		{
			return _detail;
		}

		
		
		/* ---------------------------------------------------------------------
		MAIN LOG ( template )
		--------------------------------------------------------------------- */
		
		/**
		 * Shows/log every kind of message, following a common template.
		 */
		public function log( ...params ) : void
		{
			var output : String;
			
			output = "[" + params[ 0 ] + "] {";
			params = params.slice( 1 );
			
			if ( _detail == 1 )
				output += _target_class.split( "." ).pop( ) + "} ~: " + params;
			else if ( _detail == 2)
				output = _target_class + "} ~: " + params;
			else
				output += params;
			
			trace( output );
		}

		
		
		/* ---------------------------------------------------------------------
		LOG METHODS
		--------------------------------------------------------------------- */
		
		/**
		 * Show/log info's messages.
		 * @param params	FATAL message to be logged.
		 */
		public final function fatal( ...params ) : Logger
		{
			if ( _level > 0 )
			{
				log( "FATAL", params );
				throw new Error( "Check the errors described above." );
			}
			
			return this;
		}

		/**
		 * Show/log info's messages.
		 * @param params	ERROR message to be logged.
		 */
		public final function error( ...params ) : Logger
		{
			if ( _level > 1 )
				log( "ERROR", params );
			
			return this;
		}

		/**
		 * Show/log debugs's messages.
		 * @param params	DEBUG message to be logged.
		 */
		public final function debug( ...params ) : Logger
		{
			if ( _level > 2 )
				log( "DEBUG", params );
			
			return this;
		}

		/**
		 * Show/log info's messages.
		 * @param params	WARN message to be logged.
		 */
		public final function warn( ...params ) : Logger
		{
			if ( _level > 3 )
			{
				log( "WARN", params );
			}
			
			return this;
		}

		/**
		 * Show/log notice's messages.
		 * @param params	NOTICE message to be logged.
		 */
		public final function notice( ...params ) : Logger
		{
			if ( _level > 4 )
				log( "NOTICE", params );
			
			return this;
		}

		/**
		 * Show/log info's messages.
		 * @param params	INFO message to be logged.
		 */
		public final function info( ...params ) : Logger
		{
			if ( _level > 5 )
				log( "INFO", params );
			
			return this;
		}
	}
}
