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

package cocktail.core.loggers 
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
		
		protected var target_class : String;
		protected static var level : uint;
		protected static var detail : uint;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Logger instance.
		 * @param class_name	Class name to be logged with all log calls.
		 */
		public function Logger ( class_name : String )
		{
			target_class = class_name;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LEVEL & MAIN LOG ( template )
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
		public function level ( logLevel : uint ) : void
		{
			Logger.level = logLevel;
		}
		
		/**
		 * Sets the log detail.
		 * @param logDetail	Application default log detail (default=1).
		 * 		<br/># 0=Doesnt add any extra prefix besides the log level.
		 * 		<br/># 1=Adds a prefix to all log calls, with the 'ClassName'
		 * 		<br/># 2=Adds a prefix to all log calls, with the 'packace.folderX.folderY.ClassName'.
		 */
		public function detail ( logDetail : uint ) : void
		{
			Logger.detail = logDetail;
		}
		
		/**
		 * Shows/log every kind of message, following a common template.
		 */
		public function log ( ...params ) : void
		{
			if ( Logger.detail == 1 )
				trace ( "["+ params[ 0 ] +"] {"+ target_class.split( "." ).pop() +"} ~: "+ params.slice( 1 ) );
			else if ( Logger.detail == 2)
				trace ( "["+ params[ 0 ] +"] {"+ target_class +"} ~: "+ params.slice( 1 ) );
			else
				trace ( "["+ params[ 0 ] +"] ~: "+ params.slice( 1 ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOG METHODS
		--------------------------------------------------------------------- */
		
		/**
		 * Show/log info's messages.
		 * @param params	FATAL message to be logged.
		 */
		public final function fatal ( ...params ) : Logger
		{
			if ( Logger.level > 0 )
			{
				log ( "FATAL", params );
				throw new Error( "Check the errors described above." );
			}
			
			return this;
		}
		
		/**
		 * Show/log info's messages.
		 * @param params	ERROR message to be logged.
		 */
		public final function error ( ...params ) : Logger
		{
			if ( Logger.level > 1 )
				log ( "ERROR", params );
			
			return this;
		}
		
		/**
		 * Show/log debugs's messages.
		 * @param params	DEBUG message to be logged.
		 */
		public final function debug ( ...params ) : Logger
		{
			if ( Logger.level > 2 )
				log ( "DEBUG", params );
			
			return this;
 		}
 		
 		/**
		 * Show/log info's messages.
		 * @param params	WARN message to be logged.
		 */
		public final function warn ( ...params ) : Logger
		{
			if ( Logger.level > 3 )
			{
				log ( "WARN", params );
			}
			
			return this;
		}
		
		/**
		 * Show/log notice's messages.
		 * @param params	NOTICE message to be logged.
		 */
		public final function notice ( ...params ) : Logger
		{
			if ( Logger.level > 4 )
				log ( "NOTICE", params );
			
			return this;
		}
		
		/**
		 * Show/log info's messages.
		 * @param params	INFO message to be logged.
		 */
		public final function info ( ...params ) : Logger
		{
			if ( Logger.level > 5 )
				log ( "INFO", params );
			
			return this;
		}
	}
}
