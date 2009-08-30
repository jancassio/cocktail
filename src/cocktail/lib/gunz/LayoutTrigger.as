/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright(C) 2009 Codeine.
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

package cocktail.lib.gunz 
{
	import cocktail.core.gunz.Trigger;						

	/**
	 * Trigger for layout.
	 * @author nybras | nybras@codeine.it
	 */
	public class LayoutTrigger extends Trigger
	{
		/* ---------------------------------------------------------------------
			BULLET TYPES
		--------------------------------------------------------------------- */
		
		public static const BOOT : String = "boot";
		public static const COMPLETE : String = "complete";
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Layout Trigger.
		 * @param owner	Trigger owner.
		 */
		public function LayoutTrigger( owner : * )
		{
			super( owner );
		}
		
		
		
		/* ---------------------------------------------------------------------
			EVENT LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Start/stop listening for BOOT bullets.
		 * @param hanlder	Bullet handler.
		 * @param params	Bullet params.
		 * @return	A reference to the LayoutTrigger itself, for inline reuse.
		 */
		public function boot(
			handler : Function,
			params : Array = null
		) : LayoutTrigger
		{
			handle( BOOT, handler, params );
			return this;
		}
		
		/**
		 * Start/stop listening for COMPLETE bullets.
		 * @param hanlder	Bullet handler.
		 * @param params	Bullet params.
		 * @return	A reference to the LayoutTrigger itself, for inline reuse.
		 */
		public function complete(
			handler : Function,
			params : Array = null
		) : LayoutTrigger
		{
			handle( COMPLETE, handler, params );
			return this;
		}
	}
}