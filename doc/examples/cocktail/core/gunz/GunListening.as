/**
 * @exampleText This would be the class you will listen to Gun events.
 */
 
// add a listener
any_class.gunz_update.add( _do_something )

// this function will be executed when Gun dispatches the event by the 
// shoot() method
function _do_something( bullet : MyCustomBullet ) : void
{
	trace( bullet.any_property );
}