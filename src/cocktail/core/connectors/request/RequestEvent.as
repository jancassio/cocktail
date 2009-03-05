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

package cocktail.core.connectors.request 
{
	import ch.capi.events.MassLoadEvent;
	import ch.capi.net.ILoadableFile;
	import ch.capi.net.IMassLoader;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;	

	/**
	 * Event class for the RequestKeeper class.
	 * 
	 * @author	nybras | nybras@codeine.as
	 * @see	RequestConnector
	 * @see	RequestKeeper
	 */
	public class RequestEvent extends Event
	{
		
		/* ---------------------------------------------------------------------
			CONSTANTS ( event types )
		--------------------------------------------------------------------- */
		
		public static const START : String = MassLoadEvent.FILE_OPEN;
		public static const PROGRESS : String = ProgressEvent.PROGRESS;
		public static const COMPLETE : String = Event.COMPLETE;
		public static const INIT : String = Event.INIT;
		public static const ERROR : String = IOErrorEvent.IO_ERROR;
		
		
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var iLoadableFile : ILoadableFile;
		public var iMassLoader : IMassLoader;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZATION
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new RequestEvent instance.
		 * @param type	Event type.
		 * @param iLoadableFile	The dispatching target ( when its an ILoadableFile instance / unique file loading )
		 * @param IMassLoader	The dispatching target ( when its an IMassLoader instance / multiple files loading )
		 */
		public function RequestEvent( type : String, iLoadableFile : ILoadableFile = null, iMassLoader : IMassLoader = null )
		{
			super( type );
			
			this.iLoadableFile = iLoadableFile;
			this.iMassLoader = iMassLoader;
		}
		
	}
}