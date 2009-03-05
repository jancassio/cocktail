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

package cocktail.lib.view.elements
{
	import cocktail.lib.view.elements.Element;
	import cocktail.utils.Timeout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;	

		/**
	 * Generic preloader in circle format.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class PreloaderElementTail extends Element 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var group : Sprite;
		
		private var background : Sprite; 
		private var foreground : Sprite; 
		
		private var radius : Number;
		private var thickness : Number;
		
		private var backgroundColor : uint = 0xCCCCCC;
		private var backgroundAlpha : Number = 1;
		
		private var foregroundColor : uint = 0x000000;
		private var foregroundAlpha : Number = 1;
		
		private var _progress : Number;
		private var hack : Timeout;
		
		private var fillingTimer : Timer;
		private var fillingProgress : Number;
		
		private var autoDestroy : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new PreloaderElement instance.
		 */
		public function PreloaderElementTail 
		( 
			autoDestroy : Boolean = true, 
			radius : Number = 30, 
			thickness : Number = 4 
		){
			this.autoDestroy = autoDestroy;
			this.radius = radius;
			this.thickness = thickness;
			
			group = new Sprite();
			group.name = "group";
			group.addChild( background = new Sprite() );
			
			background.graphics.lineStyle( thickness , backgroundColor , backgroundAlpha );
			background.graphics.drawCircle( 0, 0, radius );
			
			group.addChild( foreground = new Sprite() );
			foreground.rotation = -90;
			
			group.x = ( config.widthMovie / 2 );
			group.y = ( config.heightMovie / 2 );
			
			fillingTimer = new Timer( 10, 0 );
			fillingTimer.addEventListener( TimerEvent.TIMER , fillProgress );
		}

		
		
		/* ---------------------------------------------------------------------
			RENDER / DESTROY
		--------------------------------------------------------------------- */
		
		/**
		 * Show preloader.
		 */
		public function show ( follow_mouse : Boolean = true ) : void
		{
			hack = new Timeout( function () : void {
				progress = 0;
				fillingProgress = 0;
				fillingTimer.start();
				
				sprite.addChild( group );
				motion.alpha( 1, .5, .2 );
			} , 50 );
			
			follow_mouse;
			hack.exec();
		}
		
		/**
		 * Hide preloader.
		 */
		public function hide () : void
		{
			if ( sprite.alpha == 0 )
			{
				hack.abort();
				remove();
				return;
			}
			
			motion.alpha( 0, .3 ).listen( remove );
		}
		
		/**
		 * Remove preloader. 
		 */
		private function remove ( event : Event = null ) : void
		{
			fillingTimer.stop();
			
			if ( sprite.getChildByName( group.name ) && autoDestroy ) 
				sprite.removeChild( group );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PRELOADER PROGRESS
		--------------------------------------------------------------------- */
		
		public function get progress () : Number
		{
			return _progress || 0;
		}
		
		public function set progress (  ammount : Number  ) : void
		{
			_progress = ammount;
		}
		
		
		
		/**
		 * Updates the progress visualization.
		 */
		private function fillProgress ( event : TimerEvent ) : void
		{
			event;
			
			foreground.graphics.clear();
			foreground.graphics.lineStyle( thickness , foregroundColor , foregroundAlpha );
			
			foreground.graphics.moveTo(
				( radius * Math.cos ( Math.PI / 180 ) ),
				( radius * Math.sin ( Math.PI / 180 ) )
			);
			
			if ( Math.min( fillingProgress + .1, progress ) == fillingProgress )
				fillingProgress += .001;
			else
				fillingProgress += .01;
			
			fillingProgress = Math.max( fillingProgress, progress );
			
			for ( var angle : Number = 0; angle <= ( fillingProgress * 360 ); angle++ )
				foreground.graphics.lineTo (
					radius * Math.cos ( angle * Math.PI / 180 ),
					radius * Math.sin ( angle * Math.PI / 180 )
				);
		}
	}
}