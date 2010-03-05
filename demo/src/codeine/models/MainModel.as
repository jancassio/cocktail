package codeine.models 
{
	import codeine.AppModel;

	/**
	 * Handles the main Model behaviors.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainModel extends AppModel
	{
		override public function after_load() : void
		{
			log.debug( "=====" );
			log.debug( "Checking InlineDataSource binds..." );
			log.debug( "song: " + bind.g( "song" ) );			log.debug( "year: " + bind.g( "year" ) );
			log.debug( "duration: " + bind.g( "duration" ) );
			log.debug( "=====" );
			
			log.debug( "=====" );
			log.debug( "Checking XMLDataSource binds..." );
			log.debug( "artist: " + bind.g( "artist" ) );
			log.debug( "decade: " + bind.g( "decade" ) );
			log.debug( "=====" );
			
			
			log.debug( "=====" );
			log.debug( "Checking AMFDataSource binds..." );
			log.debug( "instrument1: " + bind.g( "instrument1" ) );
			log.debug( "instrument2: " + bind.g( "instrument2" ) );
			log.debug( "=====" );
			
			log.debug( "=====" );
			log.debug( "Checking HTTPDataSource binds..." );
			log.debug( "instrument-string: " + bind.g( "instrument-string" ) );
			log.debug( "=====" );
			
			log.debug( "=====" );
			log.debug( "Checking JSONDataSource binds..." );
			log.debug( "songs-num: " + bind.g( "songs-num" ) );
			log.debug( "=====" );
		}
	}
}
