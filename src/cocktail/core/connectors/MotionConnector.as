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

package cocktail.core.connectors
{
	import cocktail.core.connectors.motion.MotionKeeper;
	
	import gs.TweenMax;
	import gs.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;	

	/**
	 * MotionConnector class acts like a proxy between cocktail and some tween engine (in this case, the engine tween is TweenMax). 
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see	TweenMax
	 */
	public class MotionConnector 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var target : Sprite;
		
		
		public function get sprite (): Sprite
		{
			return target;
		}
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new MotionConnector instance.
		 * 
		 * @param target	Target that will receive all motion calls.	
		 */
		public function MotionConnector ( target : Sprite ){
			this.target = target;
		}
		
		
		
		/* ---------------------------------------------------------------------
			MOVE fature ( with start value option )
		--------------------------------------------------------------------- */
		
		/**
		 * Perform a tweenmax call.
		 * 
		 * @param prop	Prop to be cached.
		 * @param start	Start value to the given prop.
		 * @param duration	Duration for the transition.
		 * @param maxObj	All props to be repassed to the tween call (to TweenMax).
		 * @return	A MotionKeeper ojb, wich you can listen/unlisten for events ( start, progress, complete )
		 */
		private function move ( prop : String, start : Number, duration : Number, maxObj : Object ) : MotionKeeper
		{
			if ( ! isNaN( start ) )
				if ( prop != "frame" )
					target[ prop ] = start;
				else
					( target as MovieClip ).gotoAndStop( frame );
			
			return new MotionKeeper( TweenMax.to( target, duration, maxObj ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			MOTION SHORTCUTS
		--------------------------------------------------------------------- */
		
		/**
		 * Makes a 'x' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function x ( end : Number, duration : Number, delay : Number = 0, equation : Function =  null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "x", start, duration, { x : end, delay : delay, ease:equation } );
		}

		/**
		 * Makes a 'y' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function y ( end : Number, duration : Number, delay : Number = 0, equation : Function =  null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "y", start, duration, { y : end, delay : delay, ease:equation } );
		}
		
		/**
		 * Makes a 'xy' motion tween.
		 * 
		 * @param endX End-x value for the transition.
		 * @param endY End-y value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param startX  Start-x value for the transition.
		 * @param startY  Start-y value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public function xy ( endX : Number, endY : Number, duration : Number, delay : Number = 0, equation : Function =  null, startX : Number = undefined, startY : Number = undefined ) : MotionKeeper
		{
			x ( endX , duration , delay , equation, startX );
			return y ( endY , duration , delay , equation, startY );
		}
		
		
		
		/**
		 * Makes a 'xscale' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function scalex ( end : Number, duration : Number, delay : Number, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "scaleX", start, duration, { scaleX : end, delay : delay, ease:equation } );
		}
		
		/**
		 * Makes a 'yscale' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function scaley ( end : Number, duration : Number, delay : Number, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "scaleY", start, duration, { scaleY : end, delay : delay, ease:equation } );
		}
		
		
		/**
		 * Makes a 'xyscale' motion tween.
		 * 
		 * @param endX End-x value for the transition.
		 * @param endY End-y value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param startX  Start-x value for the transition.
		 * @param startY  Start-y value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function scalexy ( endX : Number, endY : Number, duration : Number, delay : Number = 0, equation : Function = null, startX : Number = undefined, startY : Number  = undefined ) : MotionKeeper
		{
			scalex ( endX , duration , delay , equation, startX );
			return scaley ( endY , duration , delay , equation, startY );
		}
		
		
		
		/**
		 * Makes a 'rotation' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function rotation ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "rotation", start, duration, { rotation : end, delay : delay, ease:equation } );
		}
		
		
		
		/**
		 * Makes a 'alpha' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function alpha ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "alpha", start, duration, { alpha : end, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		
		
		
		
		
		/**
		 * Makes a 'width' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function width ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "width", start, duration, { width : end, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		/**
		 * Makes a 'height' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function height ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "height", start, duration, { height : end, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		
		
		/**
		 * Makes a 'blurXY' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function frame ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "frame", start, duration, { frame : end, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		
		
		/**
		 * Makes a 'tint' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function tint ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			if( end < 0 ) {
				return this.move( "tint", start, duration, { removeTint  : true, delay : delay, ease: ( equation || Linear.easeNone ) } );
			} else {
				return this.move( "tint", start, duration, { tint : end, delay : delay, ease: ( equation || Linear.easeNone ) } );
			}
		}
		
		
		
		/**
		 * Makes a 'blurX' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function blurX ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "blurX", start, duration, { blurFilter : { blurX : end }, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		
		/**
		 * Makes a 'blurY' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function blurY ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "blurY", start, duration, { blurFilter : { blurY : end }, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
		
		/**
		 * Makes a 'blurXY' motion tween.
		 * 
		 * @param end End value for the transition.
		 * @param duration Duration value for the transition, in milleseconds.
		 * @param delay  Delay before start the transition, in milleseconds.
		 * @param equation Equation for the Egg transition.
		 * @param start  Start value for the transition.
		 * 
		 * @return	A reference to the MotionConnector itself, so you can concat many calls in the same line.
		 */
		public final function blurXY ( end : Number, duration : Number, delay : Number = 0, equation : Function = null, start : Number = undefined ) : MotionKeeper
		{
			return this.move( "blurXY", start, duration, { blurFilter : { blurX : end, blurY : end }, delay : delay, ease: ( equation || Linear.easeNone ) } );
		}
		
	}
}
