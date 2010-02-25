/**
 * @exampleText Creating a GunzGroup and listening for completion.
 */
 
// creates a Gunz list
var gunz : Gunz = new Gunz( this );
  
 // creates some Gun's
var gun1 : Gun = new Gun( gunz, this, "type1" );
var gun2 : Gun = new Gun( gunz, this, "type2" );
var gun3 : Gun = new Gun( gunz, this, "type3" );

// creates a group
var group : new GunzGroup();

// add Gun's to this group
group.add( gun1 );
group.add( gun2 );
group.add( gun3 );

// listens to when all Gun events completion
group.gunz_complete.add( all_events_shot, request );

// called when all Gun events were dispatched (shot)
function all_events_shot( bullet : Bullet ) : void
{
	trace( bullet.params );
}