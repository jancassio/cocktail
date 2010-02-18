package cocktail.core.gunz 
{
	import flash.events.Event;
	import flash.utils.describeType;

	/**
	 * @author nybras | me@nybras.com
	 */
	public class Bullet 
	{
		/* VARS */
		internal var _type : String;
		internal var _params : *;
		internal var _owner : *;
		internal var _now : Date;
		internal var _time : int;
		internal var _times : int;
		internal var _event : Event;

		/* INITIALIZING */
		public function Bullet( type : String ) : void
		{
			_type = type;
			_times = -1;
		}

		/* PUBLI GETTERS */
		public function get type() : String
		{
			return _type;	
		}

		public function get now() : Date 
		{
			return _now;
		}

		public function get times() : int 
		{
			return _times;
		}

		public function get time() : int 
		{
			return _time;
		}

		public function get params() : *
		{
			return _params;
		}

		public function get owner() : *
		{
			return _owner;
		}

		public function get event() : Event
		{
			return _event;
		}

		public function set event( event : Event ) : void
		{
			_event = event;
		}

		/* TO STRING CONVERSION */
		
		/**
		 * Format all public properties to String.
		 * @param	The bullet into String format.
		 */
		public function toString() : String
		{
			var obj_type : String;
			var output : String;
			var described : XML;
			var props : XMLList;
			var prop : XML;
			
			described = describeType( this );
			obj_type = String( described.@name ).split( "::" ).pop( );
			
			output = "[object " + obj_type + "]\n{\n";
			props = described[ "variable" ]; 
			
			output += "\ttype : String = " + type + ";\n";
			output += "\ttimes : Number = " + times + ";\n";
			output += "\ttime : Number = " + time + ";\n";
			output += "\tnow : Number = " + now + ";\n";
			output += "\towner : * = " + owner + ";\n";
			output += "\tparams : * = " + params + ";\n";
			output += "\n\t>>>>> VARIABLES:\n\t-----\n";
			
			for each( prop in props )
			{
				output += "\t" + prop.@name + " : ";
				output += String( prop.@type ).split( "::" ).pop( ) + " = ";
				output += this[ prop.@name ] + ";\n";
			}
			
			return output + "}";
		}
	}
}