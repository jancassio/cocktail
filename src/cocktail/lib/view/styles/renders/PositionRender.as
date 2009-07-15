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

package cocktail.lib.view.styles.renders 
{
	import cocktail.lib.view.styles.renders.Render;
	import cocktail.lib.view.styles.selectors.PositionSelector;
	import cocktail.lib.view.styles.values.enums.PositionEnum;
	import cocktail.lib.view.styles.values.vos.position.SnapVO;
	
	import flash.geom.Point;	

	/**
	 * Render all Position properties
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionRender extends Render 
	{
		/* ---------------------------------------------------------------------
			RENDER
		--------------------------------------------------------------------- */
		
		/**
		 * Start the automagic live rendering. 
		 */
		public function render () : void
		{
//			_style.plug( PositionSelector.POSITION, _position ).touch( _incremental );
			
			_style.touch( PositionSelector.POSITION, _incremental );
			
			_style.plug( PositionSelector.LEFT, _left ).touch( _incremental );
			_style.plug( PositionSelector.TOP, _top ).touch( _incremental );
			_style.plug( PositionSelector.RIGHT, _right ).touch( _incremental );
			_style.plug( PositionSelector.BOTTOM, _bottom ).touch( _incremental );
			_style.plug( PositionSelector.ALIGN, _align ).touch( _incremental );
			_style.touch( PositionSelector.SNAP, _incremental );
			_style.plug( PositionSelector.OVERFLOW, _overflow );
			_style.plug( PositionSelector.OVERFLOW_X, _overflow_x );
			_style.plug( PositionSelector.OVERFLOW_Y, _overflow_y );
			_style.plug( PositionSelector.Z_INDEX, _z_index );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		private function _incremental () : void
		{	
			switch ( _style.last_modified_property )
			{
				case PositionSelector.POSITION: _incremental_position(); break;
				case PositionSelector.SNAP: _incremental_snap(); break;
				default:
					_incremental_position();
					_incremental_snap();
			}
		}
		
		/**
		 * TODO: write docs
		 */
		private function _incremental_position () : void
		{
			var point : Point;
			
			switch ( _style.position )
			{
				// RELATIVE TO STAGE (stage.x, stage.y)
				case PositionEnum.position.ABSOLUTE:
					point = new Point( u ( _style.left ), u ( _style.top ) );
					_target.localToGlobal( point );
					_target.x = point.x;
					_target.y = point.y;
				break;
				
				// RELATIVE TO THE PARENT (parent.x, parent.y)
				case PositionEnum.position.RELATIVE:
					_target.x = u( _style.left );
					_target.y = u( _style.top );
				break;
			}
		}
		
		private function _incremental_snap () : void
		{
			var snap : SnapVO;
			
			snap = new SnapVO( _style.snap );
			
//			trace ( "-----" );
//			trace ( "SNAP LEFT: "+ snap.left );
//			trace ( "SNAP TOP: "+ snap.top );
//			trace ( "SNAP SCALE: "+ snap.scale );
		}
		
		
		
//		/**
//		  * TODO: Write render documentation.
//		  * @param value	TODO: Write param documentation.
//		  */
//		private function _position( value : * ) : void
//		{
//			_left( _style.left );
//			_right( _style.right );
//			_top( _style.top );
//			_bottom( _style.bottom );
//		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _left( value : * ) : void
		{
			_handle ( value );
			
			if ( _is_percent )
				_target.x = ( _target.parent.width * _clear_unit_u );
			else
				_target.x = _clear_unit_u;
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _top( value : * ) : void
		{
			_handle ( value );
			if ( _is_percent )
				_target.y = ( _target.parent.height * _clear_unit_u );
			else
				_target.y = _clear_unit_u;
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _right( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _bottom( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _align( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow_x( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow_y( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _z_index( value : * ) : void
		{
			// TODO: implement method
		}
	}
}