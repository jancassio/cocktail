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
	import cocktail.core.loggers.interfaces.ILogger;
	
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.Stage;	

	/**
	 * AlconLogger is the connector-class for Alcon debugger.
	 * @author nybras | nybras@codeine.it
	 */
	public class AlconLogger extends Logger implements ILogger
	{
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new AlconLogger instance.
		 * @param class_name	Class name to be logged with all log calls.
		 */
		public function AlconLogger ( class_name : String )
		{
			super ( class_name );
		}
		
		
		
		/* ---------------------------------------------------------------------
			MAIN LOG
		--------------------------------------------------------------------- */
		
		/**
		 * Shows/log every kind of message, following a common template.
		 */
		override public function log ( ...params ) : void
		{
			var msg : String;
			var level : uint;
			
			if ( Logger.detail == 1 )
				msg = "{"+ target_class.split( "." ).pop() +"} ~: "+ params.slice( 1 );
			else if ( Logger.detail == 2)
				msg = "{"+ target_class +"} ~: "+ params.slice( 1 );
			else
				msg = " ~: "+ params.slice( 1 );
			
			super.log.apply( super, params );
			
			try {
				level = Debug[ "LEVEL_"+ params[ 0 ] ];
			}
			catch ( e : Error )
			{
				level = Debug.LEVEL_DEBUG;
			}
			
			Debug.trace( params.slice( 1 ) , level );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ALCON SHORTCUTS
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		public function inspect ( target : * ) : void
		{
			Debug.inspect( target );
		}
		
		/**
		 * 
		 */
		public function mark ( color : uint = 0xFF00FF ) : void
		{
			Debug.mark( color );
		}
		
		/**
		 * 
		 */
		public function monitor ( stage : Stage, pollInterval : int = 500 ) : void
		{
			Debug.monitor( stage, pollInterval );
		}
	}
}