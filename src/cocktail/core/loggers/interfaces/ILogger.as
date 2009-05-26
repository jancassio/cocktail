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

package cocktail.core.loggers.interfaces {	import cocktail.core.loggers.Logger;				/**	 * Interface for Loggers.	 * @author nybras | nybras@codeine.it	 */	public interface ILogger 	{		/* ---------------------------------------------------------------------			LOG METHODS		--------------------------------------------------------------------- */				/**		 * Shows/log every kind of message, following a common template.		 */		function log ( ...params ) : void;				/**		 * Show/log info's messages.		 * @param params	FATAL message to be logged.		 */		function fatal ( ...params ) : Logger;
		/**		 * Show/log info's messages.		 * @param params	ERROR message to be logged.		 */		function error ( ...params ) : Logger;				/**		 * Show/log debugs's messages.		 * @param params	DEBUG message to be logged.		 */		function debug ( ...params ) : Logger; 		 		/**		 * Show/log info's messages.		 * @param params	WARN message to be logged.		 */		function warn ( ...params ) : Logger;				/**		 * Show/log notice's messages.		 * @param params	NOTICE message to be logged.		 */		function notice ( ...params ) : Logger;				/**		 * Show/log info's messages.		 * @param params	INFO message to be logged.		 */		function info ( ...params ) : Logger;	}}