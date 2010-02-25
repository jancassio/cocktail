/**
 * @exampleText This would be the class you will dispatch the events.
 */
 
var gunz : Gunz; 
var gunz_update : Gun; 

// creates a new Gunz list
gunz = new Gunz( this );

// For convention Gun's names begin with "gunz_" + Gun type
gunz_update = new Gun( gunz, this, "update" );

// whenever you need, you can dispatch your event
gunz_update.shoot( new MyCustomBullet( "anything the bullet requires" ) );