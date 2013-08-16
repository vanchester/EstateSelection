<?php
class File 
{
    public static function deleteDir($dir)
	{
		foreach(glob($dir . '/*') as $file) {
			if(is_dir($file)) rrmdir($file); else unlink($file);
		} rmdir($dir);
	}
}
 