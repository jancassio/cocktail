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

package cocktail.core.data.dao {	import cocktail.config.Config;
	import cocktail.core.data.dao.DAO;
	import cocktail.utils.ArrayUtil;	
	/**	 * ProcessDAO class, used by Processes and Dependence class to store dependences	 * a little more organized.	 * 	 * @author nybras | nybras@codeine.it	 * @see	Processes	 */	public class ProcessDAO extends DAO 	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				public var url : String;		public var cleanUrl : String;				public var controller_name : String;		public var controller_path : String;		public var area_name : String;		public var action : String;		public var params : Array;		public var locale : String;				public var wait : Boolean;		public var freeze : Boolean;								/* ---------------------------------------------------------------------			INITIALIZING		--------------------------------------------------------------------- */				/**		 * Creates a new ProcessDAO instance.		 * @param url	The process url in string format (AreaName/action/param1/param2/praramN...).		 * @param wait	if <code>true</code> waits for the previous process <code>after_render</code> to continue, otherwise <code>false</code>, just goes on.		 */
		public function ProcessDAO ( url : String, wait : Boolean, freeze : Boolean )		{			var tmpUrl : Array;						// trace ( "$$$$$$$$$$$$ ANTES: "+ url +" ( "+ config.currentLocale +" ) ");						/*			 * removing first and last braces, if there's one			 */			 			if ( url.substr( 0, 1 ) == "/" )				url = url.substr( 1 );									if ( url.substr( -1 ) == "/"  )				url = url.substr( 0, -1 );									/*			 * spliting url into array			 */			tmpUrl = url.split( "/" );						// trace ( "---> parts: " + tmpUrl );						/*			 * if url hasn't a locale string prefix and the current locale is different from the default locale,			 * add a locale prefix to the url.			 */			 			if ( ! ArrayUtil.has( config.locales, tmpUrl[ 0 ] )  )			{				locale = ( config.currentLocale || config.defaultLocale );								// if locale prefix is different than the default locale, add it to the url				if ( config.currentLocale != config.defaultLocale )					url = ( locale + "/" + url );								// trace ( "@ IF 1 - locale : "+ locale );				// trace ( "@ IF 1 - url : "+ url );			}						/*			 * otherwise, if url has a locale string prefix, then just remove it from the url array			 */			 			else			{				locale = tmpUrl.shift();								if ( config.currentLocale != null )					locale = config.currentLocale;								// // trace ( "tem! :-) -> " + locale );				// trace ( "@ ELSE 1 - locale : "+ locale );				// trace ( "@ ELSE 1 - url : "+ url );			}									// trace ( "@ KEEPING - locale : "+ locale );			// trace ( "@ KEEPING - url : "+ url );									/*			 * if url is invalid, uses the default url			 */						if ( tmpUrl.length < 2 )				tmpUrl = config.defaultUrl.split( "/" );									// trace ( "@ FINALLY - locale : "+ locale );			// trace ( "@ FINALLY - url : "+ url );						this.cleanUrl = tmpUrl.join("/");			this.url = tmpUrl.join("/");						if ( locale != config.defaultLocale )				this.url = locale +"/" + this.url;						controller_name = tmpUrl[ 0 ];			controller_path = config.appId +".controllers."+ tmpUrl[ 0 ] +"Controller";						area_name = controller_name.toLocaleLowerCase();						action = tmpUrl[ 1 ];						params = ( tmpUrl.slice( 2 ) || [] );			params = ( params[0] == "" ? [] : params );						// trace ( "$$$$$$$$$$$$ DEPOIS: "+ url );						// // trace ( "LOCALE: "+ locale );			// // trace ( "CONTROLLER: " + controller_name );			// // trace ( "ACTION: "+ action );			// // trace ( "PARAMS: "+ params );			// // trace ( "----" );						this.wait = wait;			this.freeze = freeze;		}	}}