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
	
	import nl.demonsters.debugger.MonsterDebugger;	
	/**
	 * DeMonsterLogger is the connector-class for DeMonster debugger.
	 * @author nybras | nybras@codeine.it
	 */
	public class MonsterLogger extends Logger implements ILogger
	{
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new DeMonsterLogger instance.
		 * @param class_name	Class name to be logged with all log calls.
		 */
		public function MonsterLogger ( class_name : String )
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
			var color : uint;
			
			
			if ( Logger.detail == 1 )
				msg = "["+ params[ 0 ] +"] {"+ target_class.split( "." ).pop() +"} ~: "+ params.slice( 1 );
			else if ( Logger.detail == 2)
				msg = "["+ params[ 0 ] +"] {"+ target_class +"} ~: "+ params.slice( 1 );
			else
				msg = "["+ params[ 0 ] +"] ~: "+ params.slice( 1 );
			
			color = 0x000000;
			switch ( params [ 0 ] )
			{
				case "INFO":	color = 0x000000;	break;
				case "NOTICE":	color = 0x333333;	break;
				case "DEBUG":	color = 0x0055AA;	break;
				case "WARN":	color = 0xFF8800;	break;
				case "ERROR":	color = 0xFF3300;	break;
				case "FATAL":	color = 0xBB0000;	break;
			}
			
			super.log.apply( super, params );
			MonsterDebugger.trace( this , msg, color );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DEMONSTER SHORTCUTS
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new application main entry.
		 * @param target	Target to inspect.
		 */
		public function inspect ( target : * ) : MonsterDebugger
		{
			return new MonsterDebugger ( target );
		}
	}
}