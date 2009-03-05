<?php
/**
 * Simple Amf Service.
 * @autor nybras | nybras@codeine.it
 */
class Form
{
	/**
	 * Sends form.
	 * {
	 *	    locale: string - (en|pt)
	 *		name: string - (user name)
     *	    email: string - ( user email )
     *	    select: string - ( user selected option )
     *	    radio: string - ( user selected radio )
     *	    check: string - ( user selected checks )
     *	    comment: string - ( user comment )
	 * }
     * 
	 * @return <true> if form was successfully sent, <false> otherwise.
	 */
	function send ( $locale, $name, $email, $select, $radio, $check, $comment )
	{ 
		if ( $locale == "en" )
		{
			$body = "[SELECT]\r\n";
			$body .= "You choose to know more about: ". $select ."\r\n\r\n";
			
			$body .= "[RADIO]\r\n";
			$body .= "You choose: ". $radio ."\r\n\r\n";
			
			$body .= "[CHECK]\r\n";
			$body .= $check ."\r\n\r\n";
			
			$body .= "[COMMENT]\r\n";
			$body .= "Your comment: ". $comment;
		}
		else if ( $locale == "pt" )
		{
			$body = "[SELECT]\r\n";
			$body .= "Você escolheu saber mais sobre: ". $select ."\r\n\r\n";
			
			$body .= "[RADIO]\r\n";
			$body .= "Você escolheu: ". $radio ."\r\n\r\n";
			
			$body .= "[CHECK]\r\n";
			$body .= $check ."\r\n\r\n";
			
			$body .= "[COMENTÁRIO]\r\n";
			$body .= "Seu comentário: ". $comment;
		}
		
		$subject = "cocktail demo - form";
		$to = "$name <$email>";
		$from = "From: Cocktail Demo <cocktail@mailinator.com>";
		$body .= $comment;
		
		return mail( $to, $subject, $body );
	}
}