function updateMovieHeight ( value )
{
	value = Math.max ( value, window.innerHeight );
	document.getElementById("content").style.height = value + "px";
}

function setScroll ( x, y )
{
	window.scroll(
		(isNaN( x ) ? 0 : x ),
		(isNaN( y ) ? 0 : y )
	);
}


function openGiftCard (  )
{
	var centerWidth = (window.screen.width - 749) / 2;
    var centerHeight = (window.screen.height - 381) / 2;
	window.open("http://www.gemx.ca/ub/ubc.html","giftcard","height=381,width=749,left="+centerWidth+",top="+centerHeight);
	//window.open("http://www.gemx.ca/ub/ubc.html","giftcard","height=381,width=749");
}

function window_height ()
{
	return window.innerHeight;
}

window.onload = function()
{
	updateMovieHeight(window.innerHeight - 5);
}