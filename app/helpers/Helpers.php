<?php
class Helpers
{
	public static function shortAddress($argument)
	{
		$streetPos = strpos($argument, 'ул.');
		if ($streetPos) {
			$argument = substr($argument, $streetPos);
		}
		return $argument;
	}

}
 